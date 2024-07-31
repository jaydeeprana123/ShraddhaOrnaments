import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/search/search_response.dart';
import 'package:shradha_design/response/search/term_list_response.dart';
import 'package:shradha_design/ui/productdetails/productDetails_scree.dart';
import '../../utils/my_icons.dart';
import '../../utils/utils.dart';
import 'SearchBloc.dart';

class SearchDelegateFragment extends SearchDelegate {
  final VoidCallback onButtonPressed;
  SearchBloc _searchBloc; //=new SearchBloc();
  bool isList = false;

  bool isTermListGet = false;
  String termId = "";
  String termName = "";

  int totalItems = 0;
  bool isPriceShow = false;
  SearchDelegateFragment({this.onButtonPressed});

  @override
  String get searchFieldLabel => "Search your product";

  @override
  ThemeData appBarTheme(BuildContext context) {
    _searchBloc = new SearchBloc(
        apiProvider: BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    if(_searchBloc.apiProvider.pref.getPriceToShow() == "1"){
      isPriceShow = true;
    }else{
      isPriceShow = false;
    }

    assert(context != null);

    MaterialLocalizations.of(context).searchFieldLabel;
    final ThemeData theme = Theme.of(context);
    assert(theme != null);

    return theme.copyWith(
        accentColor: Colors.white,
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: AppTheme.background,
          brightness: Brightness.dark,

          // color: AppTheme.white,
          // or use Brightness.dark
        ),
        textTheme: theme.textTheme.copyWith(
            headline6:
                theme.textTheme.headline6.copyWith(color: AppTheme.black)),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(color: AppTheme.black.withOpacity(0.5)),
        ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: AppTheme.black,
        ),
        onPressed: () {
          LogCustom.logd("xxxxxxxxxxx : search clear" + query);

          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),

      // icon: Icon(Icons.arrow_back),
      onPressed: () {
        LogCustom.logd("xxxxxxxxxxx : search arrow_back" + query);

        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Container(
        color: AppTheme.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              color: AppTheme.gray_300,
              size: 60,
            ),
            Text(
              "Please Search",
              style: AppTheme.subtitle.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    }

    return SizedBox();
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);

    if (query.length != 0) {
      /* ExtraModel extraModel = new ExtraModel();
      extraModel.setType(Constant.search);
      extraModel.setCategory(true);
      extraModel.setName(query);
      extraModel.setKey(query);

       */ /*Navigator.of(context).push(Utils.createRoute(
              context, ProductListPage(intentData: extraModel,),
              "ProductListPage"));

*/ /*
      PageTransition.createRoutedata(context,"ProductListPage",extraModel);
*/
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // if(!isTermListGet){
    //   isTermListGet = true;
    //   _searchBloc.getTermList();
    // }
    if (query.isEmpty) {
      _searchBloc.getTermList();
    }




    if (termId.isNotEmpty) {

      if(query == termName){
        _searchBloc.currentPage = 1;
        _searchBloc.getSearchTerm(termId, context, termName);
      }else{
        termId = "";
        termName = "";
      }



    }

    _searchBloc.currentPage = 1;



    if(termId.isEmpty){
      _searchBloc.getSearch(query);
    }


    LogCustom.logd("xxxxxxxxxxx : search111 " + query);

    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return getSearchView();
  }

  ScrollController _controller = ScrollController();

  loadmore() {
    if (_searchBloc.currentPage <= _searchBloc.totoalPage) {
      _searchBloc.currentPage = _searchBloc.currentPage + 1;
      _searchBloc.getSearch(query);
    }
  }

  Widget getSearchView() {

    return Stack(
      children: [
        query.isEmpty
            ? StreamBuilder(
                stream: _searchBloc.termList.stream,
                builder: (context, AsyncSnapshot<List<TermData>> snapshot) {
                  if (!snapshot.hasData) {
                    //   print("data is not available length - " +  snapshot.data.length.toString());

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  } else if (snapshot.data.length == 0) {
                    print("data is not available length - " +
                        snapshot.data.length.toString());

                    return SizedBox();
                  } else {
                    print("data is available length - " +
                        snapshot.data.length.toString());
                    isTermListGet = true;

                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              termId = snapshot.data[index].id.toString();
                              termName = snapshot.data[index].term;

                              query = snapshot.data[index].term;

                              _searchBloc.currentPage = 1;
                              _searchBloc.getSearchTerm(
                                  snapshot.data[index].id.toString(),
                                  context,
                                  snapshot.data[index].term);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 12, top: 4, right: 12),
                              child: Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                shadowColor: AppTheme.light_primarydark,
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(snapshot.data[index].term,
                                      style: AppTheme.subtitleopensanssemibold
                                          .copyWith(
                                              fontSize: 15,
                                              color: AppTheme.black_text_dark,
                                              fontWeight: FontWeight.w100)),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                },
              )
            : SizedBox(),


        query.isNotEmpty?  StreamBuilder(
          stream: _searchBloc.subject.stream, //
          builder: (context, AsyncSnapshot<List<ProductData>> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data.length == 0 && query != "") {

              return Center(
                child: Text(
                  "No Results Found.",
                  style: AppTheme.subtitle.copyWith(fontSize: 16),
                ),
              );
            } else if (snapshot.data.length == 0) {

              return SizedBox();

              // return Container(
              //   color: AppTheme.white,
              //   alignment: Alignment.center,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       SizedBox(
              //         height: 58,
              //       ),
              //       Icon(
              //         Icons.search,
              //         color: AppTheme.gray_300,
              //         size: 60,
              //       ),
              //       Text(
              //         "Please Search",
              //         style: AppTheme.subtitle.copyWith(fontSize: 16),
              //       ),
              //     ],
              //   ),
              // );
            } else {

              if( _searchBloc.totalItems >0){
                totalItems = _searchBloc.totalItems;
              }

              return NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  if (_controller.offset >=
                      (_controller.position.maxScrollExtent - 800) &&
                      !_searchBloc.isLoading() &&
                      _searchBloc.currentPage <= _searchBloc.totoalPage) {
                    loadmore();
                  }

                  return true;
                },
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Container(
                    color: AppTheme.off_White,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          color: AppTheme.bg,
                          padding: const EdgeInsets.only(left: 16.0, top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        style: TextStyle(
                                            color: AppTheme.black_text_dark,
                                            fontFamily:
                                            AppTheme.poppinsRegular,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            height: 1.2),
                                        text: "Total Items "),
                                    TextSpan(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.primarydark,
                                            fontFamily:
                                            AppTheme.poppinsRegular,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16,
                                            height: 1.5),
                                        text: "(" +
                                            totalItems.toString() +
                                            ")")
                                  ])),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            //padding:const EdgeInsets.all(0),
                            padding: EdgeInsets.only(
                                left: isList ? 12 : 0,
                                right: isList ? 12 : 0,
                                top: 0,
                                bottom: 0),
                            itemCount: snapshot.data.length,
                            crossAxisCount: isList ? 1 : 6,
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 2.0,
                            staggeredTileBuilder: (index) =>
                            new StaggeredTile.fit(
                                (Constant.isIpad) ? 2 : 3),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {

                                  query = "";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                              pId: snapshot.data[index].id
                                                  .toString(),
                                            )),
                                  )?.then((value) {
                                    onButtonPressed();
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 0),
                                  child: Stack(
                                    children: [
                                      // Container(
                                      //   margin: EdgeInsets.only(left: 16, ),
                                      //   width: double.infinity,
                                      //   height: 220
                                      //   ,decoration: BoxDecoration(color: AppTheme.transparent,
                                      //   border: Border.all(color: AppTheme.off_White, width: 0.8,),
                                      //   borderRadius: BorderRadius.circular(2.0),
                                      //
                                      //
                                      //
                                      //
                                      // ),
                                      // ),

                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(16),
                                        color: AppTheme.bg,

                                        // decoration: BoxDecoration(
                                        //   border: Border.all(color: AppTheme.light_grey, width:0.5,),
                                        //   borderRadius: BorderRadius.circular(2.0),
                                        //   // boxShadow: <BoxShadow>[
                                        //   //   BoxShadow(
                                        //   //     color: AppTheme.gray_300,
                                        //   //     offset: const Offset(0, 4),
                                        //   //     blurRadius: 2,
                                        //   //
                                        //   //   ),
                                        //   //
                                        //   // ],
                                        //
                                        //
                                        //
                                        // ),

                                        child: Column(children: <Widget>[
                                          // Image.asset('assets/images/logo.png',height: 100),

                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(2),
                                                topRight: Radius.circular(2),
                                                bottomLeft:
                                                Radius.circular(2),
                                                bottomRight:
                                                Radius.circular(2)),
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot
                                                  .data[index].imageName,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              errorWidget:
                                                  (context, url, error) =>
                                                  Image.asset(
                                                    logo_pink,
                                                    width: double.infinity,
                                                    color: AppTheme.off_White,
                                                    fit: BoxFit.cover,
                                                  ),
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                    logo_pink,
                                                    width: double.infinity,
                                                    color: AppTheme.off_White,
                                                    fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),

                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 12, right: 4),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                              isPriceShow? Text(
                                                    "\₹" +
                                                        Utils.currencyText(snapshot
                                                            .data[
                                                        index]
                                                            .price),
                                                    style: AppTheme.subtitleopensanssemibold.copyWith(
                                                        fontSize:
                                                        isList
                                                            ? 16
                                                            : 14,
                                                        color: AppTheme
                                                            .black_text_dark,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700)):SizedBox(),

                                                isPriceShow?   SizedBox(
                                                  height: isList ? 6 : 8,
                                                ):SizedBox(),

                                                Text(
                                                  snapshot.data[index].title,
                                                  style: AppTheme
                                                      .subtitleopensans
                                                      .copyWith(
                                                      fontSize: isList
                                                          ? 14
                                                          : 12,
                                                      color: AppTheme
                                                          .black_text,
                                                      fontWeight:
                                                      FontWeight
                                                          .w200),
                                                  maxLines: 2,
                                                ),

                                                // const SizedBox(
                                                //   height: 6,
                                                // ),
                                                // RichText(
                                                //     textAlign: TextAlign.center,
                                                //     text: TextSpan(
                                                //         children: [
                                                //           TextSpan(
                                                //               style:  TextStyle(
                                                //                   color:  AppTheme.medium_text_color,
                                                //                   fontFamily: AppTheme.poppinsRegular,
                                                //                   fontStyle:  FontStyle.normal,
                                                //                   fontSize:  isList?13:10,
                                                //                   height: 1.2
                                                //               ),
                                                //               text: "Code : "),
                                                //           TextSpan(
                                                //               style:  TextStyle(
                                                //                   color:  AppTheme.primarydark,
                                                //                   fontFamily:AppTheme.poppinsRegular,
                                                //                   fontStyle:  FontStyle.normal,
                                                //                   fontSize: isList?13:10,
                                                //                   height: 1.5
                                                //               ),
                                                //               text: snapshot.data[index].productCode)
                                                //         ]
                                                //     )
                                                // )
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),

                                      (snapshot.data[index].tna == "1")
                                          ? Positioned(
                                        left: 5,
                                        top: 2,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Image.asset(
                                            'assets/images/tna_icon.png',
                                            height: 25,
                                          ),
                                        ),
                                      )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        _getLoader(),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ):SizedBox()
      ],
    );
















    // return query.isNotEmpty?StreamBuilder(
    //   stream: _searchBloc.subject.stream, //
    //   builder: (context, AsyncSnapshot<List<ProductData>> snapshot) {
    //     if (!snapshot.hasData) {
    //       return Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Center(child: CircularProgressIndicator()),
    //         ],
    //       );
    //     } else if (snapshot.data.length == 0 && query != "") {
    //       return Center(
    //         child: Text(
    //           "No Results Found.",
    //           style: AppTheme.subtitle.copyWith(fontSize: 16),
    //         ),
    //       );
    //     } else if (snapshot.data.length == 0) {
    //       return Container(
    //         color: AppTheme.white,
    //         alignment: Alignment.center,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             SizedBox(
    //               height: 58,
    //             ),
    //             Icon(
    //               Icons.search,
    //               color: AppTheme.gray_300,
    //               size: 60,
    //             ),
    //             Text(
    //               "Please Search",
    //               style: AppTheme.subtitle.copyWith(fontSize: 16),
    //             ),
    //           ],
    //         ),
    //       );
    //     } else {
    //       return NotificationListener<ScrollUpdateNotification>(
    //         onNotification: (notification) {
    //           if (_controller.offset >=
    //               (_controller.position.maxScrollExtent - 800) &&
    //               !_searchBloc.isLoading() &&
    //               _searchBloc.currentPage <= _searchBloc.totoalPage) {
    //             loadmore();
    //           }
    //
    //           return true;
    //         },
    //         child: SingleChildScrollView(
    //           controller: _controller,
    //           child: Container(
    //             color: AppTheme.off_White,
    //             child: Column(
    //               mainAxisSize: MainAxisSize.max,
    //               children: <Widget>[
    //                 Container(
    //                   width: double.infinity,
    //                   color: AppTheme.bg,
    //                   padding: const EdgeInsets.only(left: 16.0, top: 16),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       RichText(
    //                           textAlign: TextAlign.left,
    //                           text: TextSpan(children: [
    //                             TextSpan(
    //                                 style: TextStyle(
    //                                     color: AppTheme.black_text_dark,
    //                                     fontFamily:
    //                                     AppTheme.poppinsRegular,
    //                                     fontStyle: FontStyle.normal,
    //                                     fontSize: 14,
    //                                     height: 1.2),
    //                                 text: "Total Items "),
    //                             TextSpan(
    //                                 style: TextStyle(
    //                                     fontWeight: FontWeight.w600,
    //                                     color: AppTheme.primarydark,
    //                                     fontFamily:
    //                                     AppTheme.poppinsRegular,
    //                                     fontStyle: FontStyle.normal,
    //                                     fontSize: 16,
    //                                     height: 1.5),
    //                                 text: "(" +
    //                                     snapshot.data.length.toString() +
    //                                     ")")
    //                           ])),
    //                       SizedBox(
    //                         height: 8,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 2,
    //                 ),
    //                 StaggeredGridView.countBuilder(
    //                     physics: const NeverScrollableScrollPhysics(),
    //                     shrinkWrap: true,
    //                     scrollDirection: Axis.vertical,
    //                     //padding:const EdgeInsets.all(0),
    //                     padding: EdgeInsets.only(
    //                         left: isList ? 12 : 0,
    //                         right: isList ? 12 : 0,
    //                         top: 0,
    //                         bottom: 0),
    //                     itemCount: snapshot.data.length,
    //                     crossAxisCount: isList ? 1 : 6,
    //                     mainAxisSpacing: 2.0,
    //                     crossAxisSpacing: 2.0,
    //                     staggeredTileBuilder: (index) =>
    //                     new StaggeredTile.fit(
    //                         (Constant.isIpad) ? 2 : 3),
    //                     itemBuilder: (context, index) {
    //                       return InkWell(
    //                         onTap: () {
    //                           Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) =>
    //                                     ProductDetailsScreen(
    //                                       pId: snapshot.data[index].id
    //                                           .toString(),
    //                                     )),
    //                           )?.then((value) {
    //                             onButtonPressed();
    //                           });
    //                         },
    //                         child: Container(
    //                           width: double.infinity,
    //                           margin: EdgeInsets.only(top: 0),
    //                           child: Stack(
    //                             children: [
    //                               // Container(
    //                               //   margin: EdgeInsets.only(left: 16, ),
    //                               //   width: double.infinity,
    //                               //   height: 220
    //                               //   ,decoration: BoxDecoration(color: AppTheme.transparent,
    //                               //   border: Border.all(color: AppTheme.off_White, width: 0.8,),
    //                               //   borderRadius: BorderRadius.circular(2.0),
    //                               //
    //                               //
    //                               //
    //                               //
    //                               // ),
    //                               // ),
    //
    //                               Container(
    //                                 width: double.infinity,
    //                                 padding: EdgeInsets.all(16),
    //                                 color: AppTheme.bg,
    //
    //                                 // decoration: BoxDecoration(
    //                                 //   border: Border.all(color: AppTheme.light_grey, width:0.5,),
    //                                 //   borderRadius: BorderRadius.circular(2.0),
    //                                 //   // boxShadow: <BoxShadow>[
    //                                 //   //   BoxShadow(
    //                                 //   //     color: AppTheme.gray_300,
    //                                 //   //     offset: const Offset(0, 4),
    //                                 //   //     blurRadius: 2,
    //                                 //   //
    //                                 //   //   ),
    //                                 //   //
    //                                 //   // ],
    //                                 //
    //                                 //
    //                                 //
    //                                 // ),
    //
    //                                 child: Column(children: <Widget>[
    //                                   // Image.asset('assets/images/logo.png',height: 100),
    //
    //                                   ClipRRect(
    //                                     borderRadius: BorderRadius.only(
    //                                         topLeft: Radius.circular(2),
    //                                         topRight: Radius.circular(2),
    //                                         bottomLeft:
    //                                         Radius.circular(2),
    //                                         bottomRight:
    //                                         Radius.circular(2)),
    //                                     child: CachedNetworkImage(
    //                                       imageUrl: snapshot
    //                                           .data[index].imageName,
    //                                       fit: BoxFit.cover,
    //                                       width: double.infinity,
    //                                       errorWidget:
    //                                           (context, url, error) =>
    //                                           Image.asset(
    //                                             logo_pink,
    //                                             width: double.infinity,
    //                                             color: AppTheme.off_White,
    //                                             fit: BoxFit.cover,
    //                                           ),
    //                                       placeholder: (context, url) =>
    //                                           Image.asset(
    //                                             logo_pink,
    //                                             width: double.infinity,
    //                                             color: AppTheme.off_White,
    //                                             fit: BoxFit.cover,
    //                                           ),
    //                                     ),
    //                                   ),
    //
    //                                   Container(
    //                                     padding: const EdgeInsets.only(
    //                                         top: 12, right: 4),
    //                                     child: Column(
    //                                       mainAxisSize: MainAxisSize.max,
    //                                       crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                       mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                       children: <Widget>[
    //                                         Row(
    //                                           children: [
    //                                             Expanded(
    //                                                 child: Text(
    //                                                     "\₹" +
    //                                                         Utils.currencyText(snapshot
    //                                                             .data[
    //                                                         index]
    //                                                             .price),
    //                                                     style: AppTheme.subtitleopensanssemibold.copyWith(
    //                                                         fontSize:
    //                                                         isList
    //                                                             ? 16
    //                                                             : 14,
    //                                                         color: AppTheme
    //                                                             .black_text_dark,
    //                                                         fontWeight:
    //                                                         FontWeight
    //                                                             .w700))),
    //
    //                                             // InkWell(
    //                                             //   onTap: (){
    //                                             //
    //                                             //     if(snapshot.data[index].wishlist==Constant.isWishlist){
    //                                             //       snapshot.data[index].wishlist="0";
    //                                             //       addremoveWishlist(false, snapshot.data[index].id.toString());
    //                                             //     }else{
    //                                             //       snapshot.data[index].wishlist="1";
    //                                             //       addremoveWishlist(true, snapshot.data[index].id.toString());
    //                                             //     }
    //                                             //
    //                                             //
    //                                             //
    //                                             //   },
    //                                             //   child: SvgPicture.asset((snapshot.data[index].wishlist==Constant.isWishlist)?favourite:favourite,height: 18,color: (snapshot.data[index].wishlist==Constant.isWishlist)?AppTheme.primary:AppTheme.light_grey,),
    //                                             // )
    //                                           ],
    //                                         ),
    //
    //                                         SizedBox(
    //                                           height: isList ? 6 : 8,
    //                                         ),
    //
    //                                         Text(
    //                                           snapshot.data[index].title,
    //                                           style: AppTheme
    //                                               .subtitleopensans
    //                                               .copyWith(
    //                                               fontSize: isList
    //                                                   ? 13
    //                                                   : 11,
    //                                               color: AppTheme
    //                                                   .black_text,
    //                                               fontWeight:
    //                                               FontWeight
    //                                                   .w200),
    //                                           maxLines: 2,
    //                                         ),
    //
    //                                         // const SizedBox(
    //                                         //   height: 6,
    //                                         // ),
    //                                         // RichText(
    //                                         //     textAlign: TextAlign.center,
    //                                         //     text: TextSpan(
    //                                         //         children: [
    //                                         //           TextSpan(
    //                                         //               style:  TextStyle(
    //                                         //                   color:  AppTheme.medium_text_color,
    //                                         //                   fontFamily: AppTheme.poppinsRegular,
    //                                         //                   fontStyle:  FontStyle.normal,
    //                                         //                   fontSize:  isList?13:10,
    //                                         //                   height: 1.2
    //                                         //               ),
    //                                         //               text: "Code : "),
    //                                         //           TextSpan(
    //                                         //               style:  TextStyle(
    //                                         //                   color:  AppTheme.primarydark,
    //                                         //                   fontFamily:AppTheme.poppinsRegular,
    //                                         //                   fontStyle:  FontStyle.normal,
    //                                         //                   fontSize: isList?13:10,
    //                                         //                   height: 1.5
    //                                         //               ),
    //                                         //               text: snapshot.data[index].productCode)
    //                                         //         ]
    //                                         //     )
    //                                         // )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ]),
    //                               ),
    //
    //                               (snapshot.data[index].tna == "1")
    //                                   ? Positioned(
    //                                 left: 5,
    //                                 top: 2,
    //                                 child: InkWell(
    //                                   onTap: () {},
    //                                   child: Image.asset(
    //                                     'assets/images/tna_icon.png',
    //                                     height: 25,
    //                                   ),
    //                                 ),
    //                               )
    //                                   : SizedBox.shrink(),
    //                             ],
    //                           ),
    //                         ),
    //                       );
    //                     }),
    //                 _getLoader(),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // ):StreamBuilder(
    //   stream: _searchBloc.termList.stream,
    //   builder: (context, AsyncSnapshot<List<TermData>> snapshot) {
    //     if (!snapshot.hasData) {
    //       //   print("data is not available length - " +  snapshot.data.length.toString());
    //
    //       return Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Center(child: CircularProgressIndicator()),
    //         ],
    //       );
    //     } else if (snapshot.data.length == 0) {
    //       print("data is not available length - " +
    //           snapshot.data.length.toString());
    //
    //       return SizedBox();
    //     } else {
    //       print("data is available length - " +
    //           snapshot.data.length.toString());
    //       isTermListGet = true;
    //
    //       return ListView.builder(
    //           shrinkWrap: true,
    //           scrollDirection: Axis.vertical,
    //           itemCount: snapshot.data.length,
    //           itemBuilder: (context, index) {
    //             return InkWell(
    //               onTap: () {
    //                 termId = snapshot.data[index].id.toString();
    //                 termName = snapshot.data[index].term;
    //
    //                 _searchBloc.currentPage = 1;
    //                 _searchBloc.getSearchTerm(
    //                     snapshot.data[index].id.toString(),
    //                     context,
    //                     snapshot.data[index].term);
    //               },
    //               child: Container(
    //                 margin: EdgeInsets.only(
    //                     left: 12, top: 4, right: 12),
    //                 child: Card(
    //                   elevation: 1.0,
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(6)),
    //                   shadowColor: AppTheme.light_primarydark,
    //                   child: Container(
    //                     padding: EdgeInsets.all(12),
    //                     child: Text(snapshot.data[index].term,
    //                         style: AppTheme.subtitleopensanssemibold
    //                             .copyWith(
    //                             fontSize: 15,
    //                             color: AppTheme.black_text_dark,
    //                             fontWeight: FontWeight.w100)),
    //                   ),
    //                 ),
    //               ),
    //             );
    //           });
    //     }
    //   },
    // );


  }

  Widget _getLoader() {
    return StreamBuilder(
        stream: _searchBloc.loading,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data != null && snapshot.data) {
            return Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.primarydark),
                        strokeWidth: 5.0,
                      ),
                      height: 28.0,
                      width: 28.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ));
          } else {
            return SizedBox();
          }
        });
  }
}
