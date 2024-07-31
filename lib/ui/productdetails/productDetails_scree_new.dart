import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/CartConstants.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/product_details_response.dart';
import 'package:shradha_design/ui/productdetails/ProductDetailsBloc.dart';
import 'package:shradha_design/ui/productdetails/ZoomImageFragment.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/ui/widget/snack.dart';
import 'package:shradha_design/utils/page_transition.dart';
import 'package:shradha_design/utils/pager/flutter_swiper.dart';
import 'package:shradha_design/utils/pager/src/swiper.dart';

import 'package:shradha_design/utils/cart_db.dart' as cart_database;
import 'package:shradha_design/utils/uidata.dart';
import 'package:shradha_design/utils/utils.dart';
import 'package:shradha_design/utils/validation.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_icons.dart';
import '../widget/common_scaffold.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String pId;

  const ProductDetailsScreen({Key key, this.pId}) : super(key: key);

  @override
  ProductDetailsScreenState createState() {
    return ProductDetailsScreenState();
  }
}

class ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  final database = cart_database.openDB();

  ProductDetailsBloc _bloc; //= HomeBloc();

  int selectdImage = 0;
  int totalImage = 0;

  SwiperController swiperController;

  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  void initState() {
    // boxcontroller = new TextEditingController();
    // pcscontroller = new TextEditingController();
    // dzonecontroller = new TextEditingController();

    _bloc = ProductDetailsBloc(
        apiProvider: BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    callApi(widget.pId.toString());

    swiperController = SwiperController();

    super.initState();
  }

  void callApi(String id) async {
    Map parms = new Map<String, String>();

    parms.putIfAbsent("id", () => id);
    // parms.putIfAbsent("id", () => "249");

    await _bloc.getProduct(false, parms);

    checkCount();
  }

  checkCount() async {
    // final database = cart_database.openDB();
    List<CartConstants> db = await cart_database.cart(database);

    if (Constant.count != db.length) {
      Constant.count = db.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    LogCustom.logd("xxxxxxxxxx  home page build");


    return CommonScaffold(
      //scaffoldKey: _scaffoldKey,
      appTitle: "Product Detail",
      backGroundColor: AppTheme.bg,
      isCartRemove: true,
      showDrawer: false,
      showFAB: false,
      bodyData:  Scaffold(
          body: FutureBuilder<bool>(
            future: _getDelayed(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              } else {
                return Container(
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(10),
                    //  margin: EdgeInsets.only(left: 5,right: 5) ,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // margin: EdgeInsets.only(top: 20),
                          child: bannerBuild(),
                        ),
//                       Container(
//                         height: 100,
//                         margin: EdgeInsets.only(top: 20),
//                         padding: EdgeInsets.only(top: 12, right: 10),
//                         alignment: Alignment.center,
//                         child: Row(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 5, left: 5),
//                                 padding: EdgeInsets.all(2),
//                                 alignment: Alignment.topLeft,
//                                 child: Image.asset(
//                                     'assets/images/p_detail4.png',
//                                     fit: BoxFit.fitHeight,
//                                     height: 40),
//                               ),
//                             ),
//                             Expanded(
//                                 child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 /*InkWell(
//                                   onTap: (){
//
//
//                                     if(_bloc.subject!=null && _bloc.subject.value.data!=null){
//                                       share(_bloc.subject.value.data.title, _bloc.subject.value.data.productImages[0],Utils.currencyText(_bloc.subject.value.data.price));
//
//                                     }
//
//                                   },
//                                   child: Container(
//                                     margin: EdgeInsets.only(right: 2,),
//                                     padding: EdgeInsets.all(2),
//                                     alignment: Alignment.topCenter,
//                                     child: Image.asset('assets/images/p_detail3.png',fit: BoxFit.fitHeight,height:  40),
//                                   ),
//                                 ),
// */
//
//                                 // InkWell(
//                                 //   onTap: () {
//                                 //     if (ModalRoute.of(context).settings.name ==
//                                 //             null ||
//                                 //         ModalRoute.of(context).settings.name !=
//                                 //             UIData.wishListScreen) {
//                                 //       PageTransition.createRoutedata(
//                                 //           context, "WishListScreen", null);
//                                 //     }
//                                 //   },
//                                 //   child: Container(
//                                 //     margin: EdgeInsets.only(
//                                 //       right: 2,
//                                 //     ),
//                                 //     padding: EdgeInsets.all(2),
//                                 //     alignment: Alignment.topCenter,
//                                 //     child: Image.asset(
//                                 //         'assets/images/p_detail2.png',
//                                 //         fit: BoxFit.fitHeight,
//                                 //         height: 40),
//                                 //   ),
//                                 // ),
//                                 Stack(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         if (ModalRoute.of(context)
//                                                     .settings
//                                                     .name ==
//                                                 null ||
//                                             ModalRoute.of(context)
//                                                     .settings
//                                                     .name !=
//                                                 UIData.cartScreen) {
//                                           // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),);
//
//                                           PageTransition.createRoutedata(
//                                               context, "CartScreen", null);
//                                         }
//                                       },
//                                       child: Container(
//                                         margin: EdgeInsets.only(
//                                           right: 2,
//                                         ),
//                                         padding: EdgeInsets.all(2),
//                                         alignment: Alignment.topCenter,
//                                         child: Image.asset(
//                                             'assets/images/p_detail1.png',
//                                             fit: BoxFit.fitHeight,
//                                             height: 40),
//                                       ),
//                                     ),
//                                     (Constant.count.toString() != "0")
//                                         ? new Positioned(
//                                             right: 0,
//                                             top: 2,
//                                             child: new Container(
//                                               alignment: Alignment.center,
//                                               padding: EdgeInsets.all(1),
//                                               decoration: new BoxDecoration(
//                                                 color: Colors.green,
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                               ),
//                                               constraints: BoxConstraints(
//                                                 minWidth: 22,
//                                                 minHeight: 22,
//                                               ),
//                                               child: Text(
//                                                 Constant.count.toString(),
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 13,
//                                                 ),
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                             ),
//                                           )
//                                         : SizedBox.shrink(),
//                                   ],
//                                 ),
//                               ],
//                             )),
//                           ],
//                         ),
//                       ),


                        Container(
                          margin: EdgeInsets.only(right: 16, bottom: 100),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: (){

                              },
                              backgroundColor: AppTheme.off_White_bg,
                              child: Stack(

                                children: [

                                  InkWell(
                                    onTap: (){
                                      if(ModalRoute.of(context).settings.name==null || ModalRoute.of(context).settings.name!=UIData.cartScreen){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),);

                                        PageTransition.createRoutedata(context,"CartScreen",null);

                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 2,),
                                      padding: EdgeInsets.all(12),
                                      alignment: Alignment.topCenter,
                                      child: Image.asset('assets/images/white_cart.png',height:  70, color: AppTheme.black_text_dark,),
                                    ),
                                  ),

                                  (Constant.count.toString() != "0") ? new Positioned(
                                    right: 0,
                                    top: 2,
                                    child: new Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(1),
                                      decoration: new BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 22,
                                        minHeight: 22,
                                      ),
                                      child: Text( Constant.count.toString(), style: TextStyle(color: Colors.white,fontSize: 13,), textAlign: TextAlign.center,    ),
                                    ),
                                  ) : SizedBox.shrink(),

                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ));
              }
            },
          )),
    );

  }

  Widget bannerBuild() {
    return StreamBuilder(
      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductDetailsResponse> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return newArival(snapshot.data);
        } else if (snapshot.hasError) {
          return CommonError(error: snapshot.error);
        } else {
          return CommonLoading();
        }
      },
    );
  }

  Widget newArival(ProductDetailsResponse response) {
    String swipeDirection = "";
    totalImage = response.data.productImages.length;

    return GestureDetector(
      onPanUpdate: (details) {
        swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
      },
      onPanEnd: (details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        // int sensitivity = 2;

        LogCustom.logd("xxxxxxxxxx ::" + swipeDirection);

        if (swipeDirection == "right") {
          // Right Swipe

          if (response.data.next_id != null && response.data.next_id != "") {
            callApi(response.data.next_id.toString());
            _bloc.subject.sink.add(null);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: response.data.next_id.toString(),)),);
          } else {
            Snack.showInfo(context, "No more item here!");
          }
        } else if (swipeDirection == "left") {
          //Left Swipe

          if (response.data.prev_id != null && response.data.prev_id != "") {
            callApi(response.data.prev_id.toString());
            _bloc.subject.sink.add(null);
            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
            //     ProductDetailsScreen(pId: response.data.prev_id.toString(),)),);
          } else {
            Snack.showInfo(context, "No more item here!");
          }
        }
      },
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(0),
                          //padding: EdgeInsets.only(bottom: 30),
                          //height: 400,
                          height: Constant.isIpad ? 600 : 400,
                          child: new Stack(
                            alignment: AlignmentDirectional.topCenter,
                            fit: StackFit.loose,
                            children: <Widget>[
                              Swiper(
                                controller: swiperController,
                                itemCount: response.data.productImages.length,
                                autoplay: true,
                                loop: false,
                                physics: NeverScrollableScrollPhysics(),
                                //  index: selectdImage,
                                autoplayDisableOnInteraction: false,
                                onTap: (index) {
                                  PageTransition.createRoutedata(
                                    context,
                                    "ZoomImageFragment",
                                    ZoomImageData(index, response.data.title,
                                        response.data.productImages),
                                  );
                                },

                                onIndexChanged: (index) {
                                  LogCustom.logd("xxxxxxxxxx :onIndexChanged:");

                                  setState(() {
                                    selectdImage = index;
                                  });
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    color: AppTheme.background,
                                    child: Container(
                                      // margin: EdgeInsets.all(1),
                                      color: AppTheme.bg,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        response.data.productImages[index],
                                        fit: BoxFit.contain,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/no_image.jpg',
                                                height:
                                                Constant.isIpad ? 150 : 100),
                                        placeholder: (context, url) => Image.asset(
                                            'assets/images/loading_dots.gif',
                                            height: Constant.isIpad ? 150 : 100),
                                      ),
                                    ),
                                  );
                                },
                                // pagination: SwiperPagination(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    response.data.productImages.length> 1? Transform.translate(
                      offset: Offset(0, -20),
                      child: Container(
                        margin: EdgeInsets.only(left: 16, top: 26, right: 16),
                        // margin: EdgeInsets.only(top:10),
                        height: 60,

                        alignment: Alignment.center,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            itemCount: response.data.productImages.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    // swiperController.event=index;
                                    selectdImage = index;
                                    swiperController.move(index);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 50,
                                  // decoration: BoxDecoration(
                                  //     // color: AppTheme.primarydark,
                                  //     border: Border.all(
                                  //       color: (selectdImage == index)
                                  //           ? AppTheme.primary
                                  //           : AppTheme.white,
                                  //       width: 2,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(35.0)),

                                  decoration: BoxDecoration(color: AppTheme.white,
                                    border: Border.all(color: selectdImage == index?AppTheme.primarydark:AppTheme.off_White, width:selectdImage == index?1: 0.5,),
                                    borderRadius: BorderRadius.circular(6.0),
                                    // boxShadow: <BoxShadow>[
                                    //   BoxShadow(
                                    //     color: AppTheme.gray_300,
                                    //     offset: const Offset(0, 4),
                                    //     blurRadius: 2,
                                    //
                                    //   ),
                                    //
                                    // ],



                                  ),


                                  child: Card(
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      // padding: EdgeInsets.all(4),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        response.data.productImages[index],
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              'assets/images/no_image.jpg',
                                              width: 50,
                                              height: 50,
                                            ),
                                        placeholder: (context, url) => Image.asset(
                                          'assets/images/loading_dots.gif',
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ):SizedBox(),

                    Container(
                      margin: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  response.data.title,
                                  style: AppTheme.subtitleopensans.copyWith(
                                      fontSize: 16,
                                      color: AppTheme.black_text_dark,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),


                              InkWell(
                                onTap: (){

                                  if(response.data.wishlist==Constant.isWishlist){
                                    response.data.wishlist="0";
                                    addremoveWishlist(false, response.data.id.toString());
                                  }else{
                                    response.data.wishlist="1";
                                    addremoveWishlist(true, response.data.id.toString());
                                  }



                                },
                                child: SvgPicture.asset((response.data.wishlist==Constant.isWishlist)?favourite:favourite,height: 24,color: (response.data.wishlist==Constant.isWishlist)?AppTheme.primary:AppTheme.light_grey,),
                              )
                            ],
                          ),



                          SizedBox(height: 2,),

                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        style:  TextStyle(
                                            color:  AppTheme.medium_text_color,
                                            fontFamily: AppTheme.poppinsRegular,
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13,
                                            height: 1.2
                                        ),
                                        text: "Product Code: "),
                                    TextSpan(
                                        style:  TextStyle(
                                            color:  AppTheme.primarydark,
                                            fontFamily:AppTheme.poppinsRegular,
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13,
                                            height: 1.5
                                        ),
                                        text: response.data.productCode)
                                  ]
                              )
                          ),

                          SizedBox(height: 2,),

                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        style:  TextStyle(
                                            color:  AppTheme.medium_text_color,
                                            fontFamily: AppTheme.poppinsRegular,
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13,
                                            height: 1.2
                                        ),
                                        text: "Item No: "),
                                    TextSpan(
                                        style:  TextStyle(
                                            color:  AppTheme.primarydark,
                                            fontFamily:AppTheme.poppinsRegular,
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 13,
                                            height: 1.5
                                        ),
                                        text: response.data.itemNo)
                                  ]
                              )
                          ),


                          SizedBox(height: 2,),


                          Text(
                            "\₹" + response.data.price,
                            style: AppTheme.subtitleopensans.copyWith(
                                fontSize: 22,
                                color: AppTheme.black_text_dark,
                                fontWeight: FontWeight.w600),
                          ),




                          // SizedBox(
                          //   height: 16,
                          // ),


                          // Container(color: AppTheme.off_White,height: 2,),

                          // Container(
                          //   width: double.infinity,
                          //   padding:
                          //   EdgeInsets.only(left: 15, top: 8, bottom: 8),
                          //   color: AppTheme.black,
                          //   child: Text(
                          // "PRODUCT DETAILS",
                          // style: AppTheme.subtitleopensans.copyWith(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w100,
                          //     color: AppTheme.white),
                          //   ),
                          // ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //         child: Container(
                          //       decoration: BoxDecoration(
                          //         borderRadius:
                          //             const BorderRadius.all(Radius.circular(2)),
                          //         color: Colors.white,
                          //         boxShadow: <BoxShadow>[
                          //           BoxShadow(
                          //             color: AppTheme.gray_300,
                          //             offset: const Offset(1, 1),
                          //             blurRadius: 2,
                          //           ),
                          //         ],
                          //       ),
                          //
                          //       padding:
                          //           EdgeInsets.only(left: 15, top: 8, bottom: 8),
                          //       //color: AppTheme.white,
                          //       child: Column(
                          //         children: [
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //           Row(
                          //             children: [
                          //               Expanded(
                          //                 child: Text(
                          //                   "PRODUCT NUMBER :",
                          //                   style: AppTheme.subtitleopensans
                          //                       .copyWith(color: AppTheme.light_text_color, fontSize: 12),
                          //                 ),
                          //               ),
                          //               Expanded(
                          //                 child: Text(
                          //                   response.data.itemNo,
                          //                   style: AppTheme.subtitleopensans
                          //                       .copyWith(color: AppTheme.black_text, fontFamily:  AppTheme.rubik, fontSize: 12),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             height: 7,
                          //           ),
                          //           Row(
                          //             children: [
                          //               Expanded(
                          //                 child: Text(
                          //                   "Price :",
                          //                   style: AppTheme.subtitleopensans
                          //                       .copyWith(color: AppTheme.black),
                          //                 ),
                          //               ),
                          //               Expanded(
                          //                 child: Text(
                          //                   "\₹" + response.data.price,
                          //                   style: AppTheme.subtitleopensans.copyWith(
                          //                       fontSize: 14,
                          //                       color: AppTheme.primary),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             height: 5,
                          //           ),
                          //         ],
                          //       ),
                          //     ))
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 20),
                            padding:
                            EdgeInsets.only( top: 8, bottom: 8),
                            // color: AppTheme.black,
                            child: Text(
                              "Product Quality",

                              style: AppTheme.subtitleRubik.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.black_text_dark),
                            ),
                          ),
                          getBoxView(response),
                          SizedBox(
                            height: 15,
                          ),




                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 12),
                            padding:
                            EdgeInsets.only( top: 8, bottom: 8),
                            // color: AppTheme.black,
                            child: Text(
                              "Product Details",
                              style: AppTheme.subtitleRubik.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.black_text_dark),
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.only(top: 4),
                            // padding: EdgeInsets.all(12),
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(2),
                            //             border: Border.all(
                            //               width: 1,
                            //               color: AppTheme.off_White,
                            //             )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg
                                  ,child: Row(children: [

                                  Expanded(
                                    child: Text(
                                      "Availability ",
                                      style: AppTheme.subtitleopensans.copyWith(
                                          fontSize: 13,
                                          color: AppTheme.medium_text_color,
                                          fontWeight: FontWeight.w100),                          ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      response.data.sellingType.toUpperCase(),
                                      style: AppTheme.subtitleopensans.copyWith(
                                          fontSize: 13,
                                          color: AppTheme.black_text,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),

                                ],),
                                ),

                                // SizedBox(height: 12,),


                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg1,
                                  child: Row(children: [

                                    Expanded(
                                      child: Text(
                                        "Brand ",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.medium_text_color,
                                            fontWeight: FontWeight.w100),                                     ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        response.data.brand.toUpperCase(),
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],),
                                ),



                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg,
                                  child: Row(children: [

                                    Expanded(
                                      child: Text(
                                        "Product Type ",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.medium_text_color,
                                            fontWeight: FontWeight.w100),                                     ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        response.data.department.toUpperCase(),
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],),
                                ),


                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg1,
                                  child: Row(children: [

                                    Expanded(
                                      child: Text(
                                        "Design Length ",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.medium_text_color,
                                            fontWeight: FontWeight.w100),                                     ),
                                    ),
                                    Expanded(
                                      child:

                                      (response.data.length != null && response.data.length.isNotEmpty)
                                          ? Text(
                                        response.data.length.toUpperCase(),
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),                          )
                                          : Text(
                                        "NOT AVAILABLE",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      ),

                                    ),

                                  ],),
                                ),



                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg,
                                  child: Row(children: [

                                    Expanded(
                                      child: Text(
                                        "Design Width ",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.medium_text_color,
                                            fontWeight: FontWeight.w100),                                     ),
                                    ),
                                    Expanded(
                                      child:

                                      (response.data.width != null && response.data.width.isNotEmpty)
                                          ? Text(
                                        response.data.width.toUpperCase(),
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      )
                                          : Text(
                                        "NOT AVAILABLE",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      ),

                                    ),

                                  ],),
                                ),


                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg1,
                                  child: Row(children: [

                                    Expanded(
                                      child: Text(
                                        "Color ",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.medium_text_color,
                                            fontWeight: FontWeight.w100),                                     ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        response.data.colour.toUpperCase(),
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],),
                                ),


                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg,
                                  child: Row(children: [

                                    Expanded(
                                      child: Text(
                                        "Material ",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.medium_text_color,
                                            fontWeight: FontWeight.w100),                                     ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        response.data.material.toUpperCase(),
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],),
                                ),


                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg1,
                                  child: Row(children: [

                                    Expanded(
                                      child: Text(
                                        "Planting",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.medium_text_color,
                                            fontWeight: FontWeight.w100),                                     ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        response.data.plating.toUpperCase(),
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],),
                                ),


                                Container(
                                  padding: EdgeInsets.all(8),
                                  color: AppTheme.off_White_bg,
                                  child: Row(children: [

                                    Expanded(
                                      child: Text(
                                        "Stone Type ",
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.medium_text_color,
                                            fontWeight: FontWeight.w100),                                    ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        response.data.stoneType.toUpperCase(),
                                        style: AppTheme.subtitleopensans.copyWith(
                                            fontSize: 13,
                                            color: AppTheme.black_text,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],),
                                ),


                              ],
                            ),
                          ),




                        ],
                      ),
                    )
                  ],
                ),
              )),
          SafeArea(
            top: false,
            child: Container(

              margin: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          // color: AppTheme.primary,
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                        ),
                        //color: AppTheme.white,
                        padding: EdgeInsets.all(0),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                color: AppTheme.primarydark,
                                width: 1.0,
                              )),
                          onPressed: () {
                            if (validate(response)) {
                              FocusScope.of(context).unfocus();

                              addtocart(response);
                            } else {
                              _showInSnackBar("Please enter any one value");
                            }
                          },
                          child: Container(

                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon(Icons.shopping_cart,color: AppTheme.white,size: 25,),

                                Image.asset('assets/images/p_detail_cart.png',
                                    fit: BoxFit.fitHeight, height: 16,  color: AppTheme.primarydark),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Add To Cart",
                                  style: AppTheme.subtitle.copyWith(
                                      fontSize: 14,
                                      color: AppTheme.primarydark,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          // color: AppTheme.black_600,
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                        ),
                        //color: AppTheme.white,
                        padding: EdgeInsets.all(0),
                        child: MaterialButton(
                          color: AppTheme.black_800,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                color: AppTheme.black_800,
                                width: 1.0,
                              )),
                          onPressed: () {
                            if (response.data.wishlist == Constant.isWishlist) {
                              response.data.wishlist = "0";
                              addremoveWishlist(false, response.data.id.toString());
                            } else {
                              response.data.wishlist = "1";
                              addremoveWishlist(true, response.data.id.toString());
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: AppTheme.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  (response.data.wishlist != Constant.isWishlist)
                                      ? "Add To Wishlist"
                                      : "Remove",
                                  style: AppTheme.subtitle.copyWith(
                                      fontSize: 14,
                                      color: AppTheme.white,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.right,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getBoxView(ProductDetailsResponse response) {
    return Container(
      alignment: Alignment.centerLeft,
      // color: AppTheme.off_White_bg,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.light_grey, width: 0.5,),
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),

      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 35),
            child: Text(
              "BOX",
              style: AppTheme.subtitleopensans.copyWith(
                  fontSize: 11,
                  color: AppTheme.black_text,
                  fontWeight: FontWeight.w200),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: response.data.boxcontroller.length,
              padding: EdgeInsets.only(left: 0),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: (response.data.sizeList.length != 0)
                            ? Text(
                            response.data.sizeList[index].toUpperCase(),
                            style: AppTheme.subtitleopensans.copyWith(
                                fontSize: 11,
                                color: AppTheme.black_text,
                                fontWeight: FontWeight.w200)
                        )
                            : Text(
                            "Qty : ".toUpperCase(),
                            style: AppTheme.subtitleopensans.copyWith(
                                fontSize: 11,
                                color: AppTheme.black_text,
                                fontWeight: FontWeight.w200)
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 30,
                        decoration: new BoxDecoration(
                          border: Border.all(color: AppTheme.light_text_color, width: 0.5,),
                          borderRadius:
                          BorderRadius.circular(2),

                        ),
                        child: TextFormField(
                          //key:UniqueKey(),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5.0),
                              hintText: "No of Box",
                              labelStyle: AppTheme.subtitleopensans.copyWith(
                                  fontSize: 11,
                                  color: AppTheme.black_text_dark,
                                  fontWeight: FontWeight.w400),
                              hintStyle:  AppTheme.subtitleopensans.copyWith(
                                  fontSize: 11,
                                  color: AppTheme.black_text,
                                  fontWeight: FontWeight.w200),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            controller: response.data.boxcontroller[index],
                            onChanged: (value) {
                              // LogCustom.logd("xxxxxx ::"+response.data.boxcontroller[index].value.text[0]);

                              if (value.isNotEmpty &&
                                  response.data.boxcontroller[index].value.text
                                      .length ==
                                      2 &&
                                  response.data.boxcontroller[index].value
                                      .text[0] ==
                                      '0') {
                                //  String ss=response.data.boxcontroller[index].text;
                                // ss.replaceAll("0", "");

                                // LogCustom.logd("xxxxxx eeee:::"+ss);

                                //response.data.boxcontroller[index].text=ss;
                              }

                              setState(() {
                                if (value.isNotEmpty &&
                                    Validation.isNumeric(value) &&
                                    double.parse(value) > 0) {
                                  response.data.qty[index] = value.toString();
                                } else {
                                  response.data.qty[index] = "0";

                                  /* if (value.isNotEmpty && Validation.isNumeric(value) && double.parse(value) < 0.99) {
                                  response.data.boxcontroller[index].text = "";
                                  LogCustom.logd("xxxxxx dddd");
                                  FocusScope.of(context).unfocus();
                                }
*/
                                }
                              });
                            },
                            onFieldSubmitted: (term) {
                              // _boxFocus.unfocus();
                              //FocusScope.of(context).requestFocus(_pcsFocus);
                            },
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              // FilteringTextInputFormatter.allow(new RegExp('[\\.|]')),
                              //  new BlacklistingTextInputFormatter(new RegExp('[\\.|\\-|\\_|\\,]')),
                            ]),
                      ),
                      Text(
                        "  = ",
                        style: AppTheme.subtitleopensans.copyWith(fontSize: 18),
                      ),
                      (response.data.qty[index].isNotEmpty &&
                          Validation.isNumeric(response.data.qty[index]))
                          ? Text(
                        Utils.currencyText((int.parse(
                            response.data.packing) *
                            double.parse(
                                response.data.qty[index].toString()))
                            .toString()),
                        style: AppTheme.subtitleopensans.copyWith(
                            fontSize: 14,
                            color: AppTheme.black_text_dark,
                            fontWeight: FontWeight.w400),
                      )
                          : SizedBox.shrink(),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        _bloc.sizeType.toUpperCase(),
                        style: AppTheme.subtitleopensans.copyWith(
                            fontSize: 11,
                            color: AppTheme.black_text_dark,
                            fontWeight: FontWeight.w400),)
                    ],
                  ),
                );
              }),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10, right: 30),
            child: Text(
              "(1 BOX = " +
                  (response.data.packing).toString() +  " " +
                  (_bloc.sizeType.toUpperCase()) +
                  ")",
              style: AppTheme.subtitleopensans
                  .copyWith(fontSize: 11, color: AppTheme.black_text_dark, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }


  bool validate(ProductDetailsResponse response) {
    bool temp = false;

    // int cont=0;

    response.data.qty.forEach((element) {
      if (element != "" && element != "0") {
        temp = true;
      }
    });

    /* if(response.data.sellingType.toUpperCase().contains("PICES") && pcscontroller.value.text.isNotEmpty){
      temp=true;
      cont=cont+1;
    }

    if(response.data.sellingType.toUpperCase().contains("DOZEN") && dzonecontroller.value.text.isNotEmpty){
      temp=true;
      cont=cont+1;
    }

    if(cont!=1){
      return false;
    }
*/
    return temp;
  }

  addtocart(ProductDetailsResponse response) async {
    // final database = cart_database.openDB();

    if (Constant.count < Constant.max_count) {
      cart_database.deleteScore(response.data.id.toString(), database);

      List<String> sizeList = [];
      List<String> qtyList = [];

      LogCustom.logd("xxxxxx: size 1:" + response.data.qty.length.toString());

      for (int i = 0; i < response.data.qty.length; i++) {
        if (response.data.qty[i] != null &&
            response.data.qty[i] != "" &&
            response.data.qty[i] != "0") {
          sizeList.add(response.data.sizeList[i]);
          qtyList.add(response.data.qty[i]);
        }
      }

      LogCustom.logd("xxxxxx: size 2:" + response.data.qty.length.toString());

      cart_database.insertScore(
          response, qtyList.toString(), sizeList.toString(), database);

      List<CartConstants> db = await cart_database.cart(database);

      if (response.data.wishlist == Constant.isWishlist) {
        response.data.wishlist = "0";
        //addremoveWishlist(false, response.data.id.toString());

        Map<String, String> parms = new Map<String, String>();
        parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());
        parms.putIfAbsent("product_id", () => response.data.id.toString());

        await _bloc.addremoveWhislist(false, parms);
      }

      await callApi(response.data.id.toString());

      if (Constant.count != db.length) {
        setState(() {
          Constant.count = db.length;
        });
      }

      _showInSnackBar("Item added cart successfully");
    } else {
      Snack.showS(
          context,
          "Please place an order to cart item then you can add new item to the cart\nMax " +
              Constant.max_count.toString() +
              " item to add to cart");
    }
  }

  void callSerachApi(String msg) {
    // _bloc.getSearch(msg);
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

  share(String name, String url, String price) async {
    LogCustom.logd("xxxxxxxx name::" + name);
    // LogCustom.logd("xxxxxxxx url::"+url);

    Share.share(url + " \n " + name + "\n Price: " + price,
        subject: Constant.AppName);
  }

  void _showInSnackBar(String value) {
    LogCustom.logd("xxxxxx: network snackbar :");

    Snack.showInfo(context, value);
  }

  @override
  void dispose() {
    LogCustom.logd("xxxxxxxxxx  home page dispose");
    // WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
