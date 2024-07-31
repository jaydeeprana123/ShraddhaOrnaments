import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/search/search_response.dart';
import 'package:shradha_design/ui/productdetails/productDetails_scree.dart';
import 'SearchBloc.dart';

class SearchDelegateFragment extends SearchDelegate {

   SearchBloc _searchBloc;//=new SearchBloc();


  @override
  String get searchFieldLabel => "Search your product";


  @override
  ThemeData appBarTheme(BuildContext context) {

    _searchBloc=new SearchBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );

    assert(context != null);

    MaterialLocalizations.of(context).searchFieldLabel;
    final ThemeData theme = Theme.of(context);
    assert(theme != null);

return theme.copyWith(

    accentColor: Colors.white,
    appBarTheme :theme.appBarTheme.copyWith(
      backgroundColor: AppTheme.background,
      brightness: Brightness.dark,

     // color: AppTheme.white,
      // or use Brightness.dark
    ) ,

    textTheme: theme.textTheme.copyWith(

    headline6: theme.textTheme.headline6.copyWith(
          color: AppTheme.black)
          ),

          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,

        hintStyle: TextStyle(color: AppTheme.black.withOpacity(0.5)),));

  }



  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear,color: AppTheme.black,),
        onPressed: () {
          LogCustom.logd("xxxxxxxxxxx : search clear"+query);

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
        LogCustom.logd("xxxxxxxxxxx : search arrow_back"+query);


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
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(Icons.search ,color: AppTheme.gray_300,size: 60,),

            Text("Please Search",style: AppTheme.subtitle.copyWith(fontSize: 16),),
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

       *//*Navigator.of(context).push(Utils.createRoute(
              context, ProductListPage(intentData: extraModel,),
              "ProductListPage"));

*//*
      PageTransition.createRoutedata(context,"ProductListPage",extraModel);
*/
    }


  }


  @override
  Widget buildSuggestions(BuildContext context) {

    _searchBloc.currentPage=1;
    _searchBloc.getSearch(query);
    LogCustom.loge("xxxxxxxxxxx : search "+query);

    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return getSearchView();
  }


   ScrollController _controller = ScrollController();




   loadmore(){


     if(_searchBloc.currentPage <= _searchBloc.totoalPage){
       _searchBloc.currentPage=_searchBloc.currentPage+1;
       _searchBloc.getSearch(query);

     }

   }




   Widget getSearchView(){

    return StreamBuilder(
      stream: _searchBloc.subject.stream,
      builder: (context, AsyncSnapshot<List<ProductData>> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else if (snapshot.data.length == 0 && query!="") {
          return Center(

            child: Text(
              "No Results Found.",style: AppTheme.subtitle.copyWith(fontSize: 16),),
          );
        }else if (snapshot.data.length == 0) {

          return Container(
            color: AppTheme.white,
            alignment: Alignment.center,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(Icons.search ,color: AppTheme.gray_300,size: 60,),

                Text("Please Search",style: AppTheme.subtitle.copyWith(fontSize: 16),),
              ],
            ),
          );

        } else {


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

              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[


                  StaggeredGridView.countBuilder(
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap : true,
                      scrollDirection: Axis.vertical,
                      //padding:const EdgeInsets.all(0),
                      padding: const EdgeInsets.only(left:4,right: 4,top: 0,bottom: 15),
                      itemCount: snapshot.data.length,
                      crossAxisCount: 6,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      staggeredTileBuilder: (index) => new StaggeredTile.fit((Constant.isIpad)?2:3),
                      itemBuilder: (context,index){


                        return InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId:snapshot.data[index].id.toString() ,)),);

                          },
                          child: Stack(
                            children: [

                              Container(
                                // width: 120,
                                margin: EdgeInsets.all(4),

                                //padding: EdgeInsets.all(5),

                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: AppTheme.gray_300,
                                      offset: const Offset(1, 1),
                                      blurRadius: 2,

                                    ),

                                  ],

                                ),



                                child:Column(children: <Widget>[


                                  Container(
                                    color:AppTheme.white,
                                    padding: EdgeInsets.all(5),
                                    child: CachedNetworkImage(imageUrl:snapshot.data[index].imageName,fit: BoxFit.contain,height: 170,
                                      errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',width: 120,height: 120, ),
                                      placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',width: 120,height: 120,),
                                    ),
                                  ),



                                  Container(
                                      color: AppTheme.white,

                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("\₹"+snapshot.data[index].price , style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.primary,fontSize: 12)),
                                          Text(snapshot.data[index].title , style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black,fontSize: 12)),
                                        ],
                                      )
                                  ),

                                ]),



                              ),


                              (snapshot.data[index].tna=="1")? Positioned(
                                left: 3,
                                top: 3,
                                child: InkWell(
                                  onTap: (){


                                  },
                                  child: Image.asset('assets/images/tna_icon.png',height: 25,),
                                ),
                              ):SizedBox.shrink(),


                            ],
                          ),
                        );

                      }) ,


                  _getLoader(),

                ],

              ),
            ),
          );


        }
      },
    );

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
                         valueColor: AlwaysStoppedAnimation<Color>(
                             AppTheme.primarydark),
                         strokeWidth: 5.0,
                       ),
                       height: 28.0,
                       width: 28.0,

                     ),

                     const SizedBox(height: 20,),

                   ],
                 )
             );
           } else {
             return SizedBox();
           }
         }
     );
   }



}





