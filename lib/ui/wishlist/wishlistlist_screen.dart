import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/wishlist/wish_list_response.dart';
import 'package:shradha_design/ui/productdetails/productDetails_scree.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/ui/wishlist/WishlistListBloc.dart';

import '../../utils/my_icons.dart';
import '../../utils/utils.dart';

class WishListScreen extends StatefulWidget {
  @override
  WishListScreenState createState() {
    return WishListScreenState();
  }
}

class WishListScreenState extends State<WishListScreen>
    with WidgetsBindingObserver {
  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  WishListBloc _bloc; //= HomeBloc();

  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  bool isList = false;
  bool isPriceShow = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    LogCustom.logd("xxxxxxxxxx  home page initState");

    _bloc = WishListBloc(
        apiProvider: BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    if(_bloc.apiProvider.pref.getPriceToShow() == "1"){
      isPriceShow = true;
    }else{
      isPriceShow = false;
    }

    callApi();

    super.initState();
  }

/*

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:

        LogCustom.logd("xxxxxxxxx resume checkout");

        if(mounted){
          callApi();
        }


        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:

        LogCustom.logd("xxxxxxxxx resume mycart ::state" + state.toString());

        break;

    }

    LogCustom.logd("xxxxxxxxx resume mycart ::state"+state.toString());

  }

*/

  void callApi() {
    Map parms = new Map<String, String>();

    parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());

    _bloc.getwishlist(false, parms);
  }

  @override
  Widget build(BuildContext context) {
    LogCustom.logd("xxxxxxxxxx  home page build");

    return CommonScaffold(
      onFlatButtonPressed: () {
        setState(() {});
      },
      //scaffoldKey: _scaffoldKey,
      appTitle: "Wish List",
      backGroundColor: AppTheme.light_grey,
      showDrawer: false,
      showFAB: false,
      bodyData: Scaffold(
        backgroundColor: AppTheme.off_White,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<bool>(
            future: _getDelayed(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              } else {
                return Container(
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      children: [
                        newArival(),
                      ],
                    ));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget newArival() {
    return Column(
      children: [
        bannerBuild(),
      ],
    );
  }

  Widget bannerBuild() {
    return StreamBuilder(
      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<WishListResponse> snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data.data != null &&
            snapshot.data.data.length != 0) {
          return Column(
            children: [
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
                                  fontFamily: AppTheme.poppinsRegular,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  height: 1.2),
                              text: "Total Items "),
                          TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primarydark,
                                  fontFamily: AppTheme.poppinsRegular,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  height: 1.5),
                              text: "(" +
                                  _bloc.subject.value.data.length.toString() +
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
                  itemCount: _bloc.subject.value.data.length,
                  crossAxisCount: isList ? 1 : 6,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  staggeredTileBuilder: (index) =>
                      new StaggeredTile.fit((Constant.isIpad) ? 2 : 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                    pId: _bloc.subject.value.data[index].id
                                        .toString(),
                                  )),
                        )?.then((value) {
                          setState(() {

                          });
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

                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(2),
                                          topRight: Radius.circular(2),
                                          bottomLeft: Radius.circular(2),
                                          bottomRight: Radius.circular(2)),
                                      child: CachedNetworkImage(
                                        imageUrl: _bloc.subject.value
                                            .data[index].imageName,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorWidget: (context, url, error) =>
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

                                  ],
                                ),

                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 12, right: 4),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                     isPriceShow? Text(
                                          "\₹" +
                                              Utils.currencyText(_bloc
                                                  .subject
                                                  .value
                                                  .data[index]
                                                  .price),
                                          style: AppTheme
                                              .subtitleopensanssemibold
                                              .copyWith(
                                                  fontSize:
                                                      isList ? 16 : 14,
                                                  color: AppTheme
                                                      .black_text_dark,
                                                  fontWeight: FontWeight
                                                      .w700)):SizedBox(),
                                      isPriceShow? SizedBox(
                                        height: isList ? 6 : 8,
                                      ):SizedBox(),
                                      Text(
                                        _bloc.subject.value.data[index].title,
                                        style: AppTheme.subtitleopensans
                                            .copyWith(
                                                fontSize: isList ? 14 : 12,
                                                color: AppTheme.black_text,
                                                fontWeight: FontWeight.w200),
                                        maxLines: 2,
                                      ),
                                      // const SizedBox(
                                      //   height: 6,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.start,
                                      //   children: [
                                      //     Expanded(
                                      //       child: RichText(
                                      //           textAlign: TextAlign.left,
                                      //           text: TextSpan(children: [
                                      //             TextSpan(
                                      //                 style: TextStyle(
                                      //                     color: AppTheme
                                      //                         .medium_text_color,
                                      //                     fontFamily: AppTheme
                                      //                         .poppinsRegular,
                                      //                     fontStyle:
                                      //                         FontStyle.normal,
                                      //                     fontSize:
                                      //                         isList ? 13 : 10,
                                      //                     height: 1.2),
                                      //                 text: "Code : "),
                                      //             TextSpan(
                                      //                 style: TextStyle(
                                      //                     color: AppTheme
                                      //                         .primarydark,
                                      //                     fontFamily: AppTheme
                                      //                         .poppinsRegular,
                                      //                     fontStyle:
                                      //                         FontStyle.normal,
                                      //                     fontSize:
                                      //                         isList ? 13 : 10,
                                      //                     height: 1.5),
                                      //                 text: _bloc
                                      //                     .subject
                                      //                     .value
                                      //                     .data[index]
                                      //                     .productCode)
                                      //           ])),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),

                            InkWell(
                              onTap: () {
                                addremoveWishlist(
                                    false,
                                    _bloc.subject.value.data[index].id
                                        .toString(),
                                    index);
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.all(6),
                                    width: 20.0,
                                    height: 22.0,
                                    decoration: new BoxDecoration(
                                      color: AppTheme.off_White,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Icon(
                                          Icons.cancel_sharp,
                                          size: 20,
                                          color: AppTheme.black_grey,
                                        ))),
                              ),

                              // Container(
                              //   padding: EdgeInsets.only(top: 2, bottom: 2, left: 4, right: 4),
                              //   decoration: BoxDecoration(
                              //     // color: AppTheme.primarydark,
                              //     border: Border.all(color: AppTheme.primarydark, width: 0.5,),
                              //     borderRadius: BorderRadius.circular(8.0),
                              //     // boxShadow: <BoxShadow>[
                              //     //   BoxShadow(
                              //     //     color: AppTheme.light_pink,
                              //     //     offset: const Offset(0, 4),
                              //     //     blurRadius: 6,
                              //     //
                              //     //   ),
                              //     //
                              //     // ],
                              //
                              //
                              //
                              //   ),
                              //
                              //   child: Row(
                              //     children: [
                              //
                              //       Icon(Icons.delete_forever_sharp,size: 13,color: AppTheme.primarydark,),
                              //
                              //       SizedBox(width: 1,),
                              //
                              //       Text( "REMOVE" , style: TextStyle(
                              //           fontWeight: FontWeight.w400,
                              //           color: AppTheme.primarydark,
                              //           fontFamily: AppTheme.poppinsRegular,
                              //           fontStyle: FontStyle.normal,
                              //           fontSize: 9,
                              //           height: 1.5)),
                              //     ],
                              //   ),
                              // ),
                            ),

                            (_bloc.subject.value.data[index].tna == "1")
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
            ],
          );
        } else if (snapshot.hasError) {
          return CommonError(error: snapshot.error);
        } else {
          return CommonLoading();
        }
      },
    );
  }

  addremoveWishlist(bool isAdd, String productId, int index) async {
    await Pr.show(context);

    Map<String, String> parms = new Map<String, String>();
    parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());
    parms.putIfAbsent("product_id", () => productId);

    await _bloc.addremoveWhislist(isAdd, parms);

    _bloc.subject.value.data.removeAt(index);

    await Pr.hide(context);

    callApi();

    setState(() {});
  }

  void callSerachApi(String msg) {
    // _bloc.getSearch(msg);
  }

  @override
  void dispose() {
    LogCustom.logd("xxxxxxxxxx  home page dispose");
    WidgetsBinding.instance.removeObserver(this);

    _bloc?.dispose();
    super.dispose();
  }
}
