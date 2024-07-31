import 'dart:ffi';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/categoryproductlist/product_list_response.dart';
import 'package:shradha_design/ui/productdetails/productDetails_scree.dart';
import 'package:shradha_design/ui/productlist/ProductListBloc.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/ui/widget/loader.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_icons.dart';
import '../../utils/utils.dart';

class ProductListScreen extends StatefulWidget {
  final String catId;
  final String catName;
    bool isList = false;
   ProductListScreen({Key key, this.catId, this.catName, this.isList})
      : super(key: key);

  @override
  ProductListScreenState createState() {
    return ProductListScreenState();
  }
}

class ProductListScreenState extends State<ProductListScreen>
    with TickerProviderStateMixin {
  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;
  ProductListBloc _bloc; //= HomeBloc();


  bool isPriceShow = false;

  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  void initState() {
    LogCustom.logd("xxxxxxxxxx  home page initState");

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _bloc = ProductListBloc(
        apiProvider: BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    if(_bloc.apiProvider.pref.getPriceToShow() == "1"){
      isPriceShow = true;
    }else{
      isPriceShow = false;
    }

    callApi();

    super.initState();
  }

  void callApi() {
    Map parms = new Map<String, String>();

    parms.putIfAbsent("id", () => widget.catId.toString());

    if (selectedSortBy == 4) {
      _bloc.getProductList(false, parms, Api.category_new_products);
    } else {
      parms.addAll(getFilter());
      _bloc.getProductList(false, parms, Api.category_products);
    }
  }

  @override
  Widget build(BuildContext context) {
    LogCustom.logd("xxxxxxxxxx  home page build");

    return CommonScaffold(
      //scaffoldKey: _scaffoldKey,
      onFlatButtonPressed: () {
        setState(() {});
      },
      appTitle: widget.catName,
      backGroundColor: AppTheme.light_grey,
      showDrawer: false,
      showFAB: false,
      bodyData: Scaffold(
        backgroundColor: AppTheme.off_White,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                // physics: AlwaysScrollableScrollPhysics(),
                child: FutureBuilder<bool>(
                  future: _getDelayed(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox.shrink();
                    } else {
                      return Container(
                          alignment: Alignment.center,
                          // padding: EdgeInsets.all(10),
                          //  margin: EdgeInsets.only(left: 5,right: 5) ,
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
            // Container(height: 4,color: AppTheme.bg,),
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.gray_300, width: 1,),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end
                ,children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16 ),
                    //width: 100,
                    alignment: Alignment.topRight,
                    color: AppTheme.bg,
                    // decoration: BoxDecoration(
                    //   borderRadius: const BorderRadius.all(Radius.circular(1)),
                    //   color: Colors.white,
                    //   boxShadow: <BoxShadow>[
                    //     BoxShadow(
                    //       color: AppTheme.gray_300,
                    //       offset: const Offset(1, 1),
                    //       blurRadius: 2,
                    //
                    //     ),
                    //
                    //   ],
                    //
                    // ),

                    child: InkWell(
                      onTap: (){

                        sortbyView();

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SvgPicture.asset(sort,height: 20,color: AppTheme.black_text,),
                          SizedBox(width: 5,),
                          Text("Sort By",style: AppTheme.subtitleopensans.copyWith(color: AppTheme.black_text,fontSize: 14, fontWeight: FontWeight.w400) ,),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 1,),

                Expanded(
                  child: Container(
                    color: AppTheme.bg,
                    padding: EdgeInsets.all(16),
                    //width: 100,
                    alignment: Alignment.topRight,
                    //color: AppTheme.white,
                    // decoration: BoxDecoration(
                    //   borderRadius: const BorderRadius.all(Radius.circular(1)),
                    //   color: Colors.white,
                    //   boxShadow: <BoxShadow>[
                    //     BoxShadow(
                    //       color: AppTheme.gray_300,
                    //       offset: const Offset(1, 1),
                    //       blurRadius: 2,
                    //
                    //     ),
                    //
                    //   ],
                    //
                    // ),

                    child: InkWell(
                      onTap: (){



                        // setState(() {
                        //
                        // });

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ProductListScreen(
                                  catId: widget.catId,

                                  catName: widget.catName,

                                  isList: !widget.isList,

                                )));

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SvgPicture.asset(widget.isList?grid:list,height: widget.isList?15:20,color: AppTheme.black_text,),
                          SizedBox(width: 6,),
                          Text(widget.isList?"Show In Grid":"Show In List",style: AppTheme.subtitleopensans.copyWith(color: AppTheme.black_text,fontSize: 14, fontWeight: FontWeight.w400)  ,),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
              ),
            ),

            Container(height: 12,color: AppTheme.bg,),
          ],
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
      builder: (context, AsyncSnapshot<ProductListResponse> snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data.data != null &&
            snapshot.data.data.length != 0) {
          return Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            left: widget.isList ? 12 : 0,
                            right: widget.isList ? 12 : 0,
                            top: 0,
                            bottom: 0),
                        itemCount: _bloc.subject.value.data.length,
                        crossAxisCount: widget.isList ? 1 : 6,
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

                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
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
                                              imageUrl: _bloc
                                                  .subject.value.data[index].imageName,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              errorWidget: (context, url, error) =>
                                                  Image.asset(
                                                    logo_pink,
                                                    width: double.infinity,
                                                    color: AppTheme.off_White,
                                                    fit: BoxFit.cover,
                                                  ),
                                              placeholder: (context, url) => Image.asset(
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
                                                            widget.isList ? 16 : 14,
                                                        color: AppTheme
                                                            .black_text_dark,
                                                        fontWeight: FontWeight
                                                            .w700)):SizedBox(),
                                            isPriceShow?  SizedBox(
                                              height: widget.isList ? 6 : 8,
                                            ):SizedBox(),
                                            Text(
                                              _bloc.subject.value.data[index].title,
                                              style: AppTheme.subtitleopensans
                                                  .copyWith(
                                                      fontSize: widget.isList ? 14 : 12,
                                                      color: AppTheme.black_text,
                                                      fontWeight: FontWeight.w200),
                                              maxLines: 2,
                                            ),
                                            // const SizedBox(
                                            //   height: 6,
                                            // ),
                                            // RichText(
                                            //     textAlign: TextAlign.center,
                                            //     text: TextSpan(children: [
                                            //       TextSpan(
                                            //           style: TextStyle(
                                            //               color: AppTheme
                                            //                   .medium_text_color,
                                            //               fontFamily:
                                            //                   AppTheme.poppinsRegular,
                                            //               fontStyle: FontStyle.normal,
                                            //               fontSize: widget.isList ? 13 : 10,
                                            //               height: 1.2),
                                            //           text: "Code : "),
                                            //       TextSpan(
                                            //           style: TextStyle(
                                            //               color: AppTheme.primarydark,
                                            //               fontFamily:
                                            //                   AppTheme.poppinsRegular,
                                            //               fontStyle: FontStyle.normal,
                                            //               fontSize: widget.isList ? 13 : 10,
                                            //               height: 1.5),
                                            //           text: _bloc.subject.value
                                            //               .data[index].productCode)
                                            //     ]))
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),

                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: (){

                                        if(_bloc.subject.value.data[index].wishlist==Constant.isWishlist){
                                          _bloc.subject.value.data[index].wishlist="0";
                                          addremoveWishlist(false, _bloc.subject.value.data[index].id.toString());
                                        }else{
                                          _bloc.subject.value.data[index].wishlist="1";
                                          addremoveWishlist(true, _bloc.subject.value.data[index].id.toString());
                                        }

                                      },
                                      child: Container(padding:EdgeInsets.all(4),child: Image.asset((_bloc.subject.value.data[index].wishlist==Constant.isWishlist)?'assets/images/like_active.png':'assets/images/like.png',height: 32,)),
                                    ),
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
                ),
              ),


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

  addremoveWishlist(bool isAdd, String productId) async {
    await Pr.show(context);

    Map<String, String> parms = new Map<String, String>();
    parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());
    parms.putIfAbsent("product_id", () => productId);

    await _bloc.addremoveWhislist(isAdd, parms);

    await Pr.hide(context);

    setState(() {});
  }

  void callSerachApi(String msg) {
    // _bloc.getSearch(msg);
  }

  int selectedSortBy = 4;

  sortbyView() {
    int selectedSortByTemp;

    selectedSortByTemp = selectedSortBy;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 4,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, state) {
            return Container(
                color: Colors.transparent,
                height: 375,

                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: AppTheme.white,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            "Sort By",
                            style:
                                TextStyle(color: AppTheme.black_text_dark, fontSize: 18),
                          ),
                        ),
                        Divider(
                          color: AppTheme.nearlyWhite,
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      state(() {
                                        selectedSortByTemp = 4;
                                        // _selectedSortBy = "lowPrice";
                                      });
                                    },
                                    child: Text(
                                      "Newest First",
                                      style: AppTheme.subtitleopensans.copyWith(color: AppTheme.black_grey,fontSize: 14, fontWeight: FontWeight.w400)
                                    ),
                                  )),
                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,
                                    child: Radio(
                                      value: 4,
                                      activeColor: AppTheme.black_grey,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {
                                        state(() {
                                          selectedSortByTemp = 4;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      state(() {
                                        selectedSortByTemp = 0;
                                        // _selectedSortBy = "lowPrice";
                                      });
                                    },
                                    child: Text(
                                      "Name: A TO Z",
                                      style: AppTheme.subtitleopensans.copyWith(color: AppTheme.black_grey,fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  )),
                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,
                                    child: Radio(
                                      value: 0,
                                      activeColor: AppTheme.black_grey,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {
                                        state(() {
                                          selectedSortByTemp = 0;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      state(() {
                                        selectedSortByTemp = 1;
                                      });
                                    },
                                    child: Text(
                                      "Name: Z TO A",
                                      style:AppTheme.subtitleopensans.copyWith(color: AppTheme.black_grey,fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  )),
                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,
                                    child: Radio(
                                      value: 1,
                                      activeColor: AppTheme.black_grey,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {
                                        state(() {
                                          selectedSortByTemp = 1;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      state(() {
                                        selectedSortByTemp = 2;
                                      });
                                    },
                                    child: Text(
                                      "Price: HIGH TO LOW",
                                      style: AppTheme.subtitleopensans.copyWith(color: AppTheme.black_grey,fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  )),
                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,
                                    child: Radio(
                                      value: 2,
                                      activeColor: AppTheme.black_grey,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {
                                        state(() {
                                          selectedSortByTemp = 2;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      state(() {
                                        selectedSortByTemp = 3;
                                      });
                                    },
                                    child: Text(
                                      "Price: LOW TO HIGH",
                                      style: AppTheme.subtitleopensans.copyWith(color: AppTheme.black_grey,fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  )),
                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,
                                    child: Radio(
                                      value: 3,
                                      activeColor: AppTheme.black_grey,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {
                                        state(() {
                                          selectedSortByTemp = 3;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0, top: 4),
                              child: Container(
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppTheme.black_grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: AppTheme.subtitleopensans.copyWith(color: AppTheme.white,fontSize: 14, fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0, top: 4),
                              child: Container(
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppTheme.black_grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 8,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      if (selectedSortBy !=
                                          selectedSortByTemp) {
                                        selectedSortBy = selectedSortByTemp;

                                        if (_bloc != null) {
                                          _bloc.subject.sink.add(null);
                                        }

                                        callApi();
                                      }

                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        'Apply',
                                        style: AppTheme.subtitleopensans.copyWith(color: AppTheme.white,fontSize: 14, fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  Map getFilter() {
    Map parms = new Map<String, String>();

    if (selectedSortBy == 4) {
      // parms.putIfAbsent("column", () => "title");
      // parms.putIfAbsent("order", () => "asc");
    } else if (selectedSortBy == 0) {
      parms.putIfAbsent("column", () => "title");
      parms.putIfAbsent("order", () => "asc");
    } else if (selectedSortBy == 1) {
      parms.putIfAbsent("column", () => "title");
      parms.putIfAbsent("order", () => "desc");
    } else if (selectedSortBy == 2) {
      parms.putIfAbsent("column", () => "price");
      parms.putIfAbsent("order", () => "desc");
    } else if (selectedSortBy == 3) {
      parms.putIfAbsent("column", () => "price");
      parms.putIfAbsent("order", () => "asc");
    }

    return parms;
  }

  @override
  void dispose() {
    LogCustom.logd("xxxxxxxxxx  home page dispose");
    // WidgetsBinding.instance.removeObserver(this);

    _bloc?.dispose();
    _animationController.dispose();
    super.dispose();
  }
}


