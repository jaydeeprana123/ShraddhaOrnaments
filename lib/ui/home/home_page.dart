import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/categoryproductlist/product_list_response.dart';
import 'package:shradha_design/response/homebanner/home_slider_response.dart';
import 'package:shradha_design/response/maincategory/main_category_response.dart';
import 'package:shradha_design/ui/categorys/sub_categories_screen.dart';
import 'package:shradha_design/ui/home/HomeBloc.dart';
import 'package:shradha_design/ui/productdetails/productDetails_scree.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/utils/my_icons.dart';
import 'package:shradha_design/utils/pager/src/swiper.dart';
import 'package:shradha_design/utils/utils.dart';

import '../../utils/my_colors.dart';
import '../widget/title_category_view.dart';

class HomePageFragment extends StatefulWidget {

  final VoidCallback onFlatButtonPressed;

  HomePageFragment({@required this.onFlatButtonPressed});

  @override
  HomePageFragmentState createState() {
    return HomePageFragmentState();
  }
}

class HomePageFragmentState extends State<HomePageFragment>
    with TickerProviderStateMixin {
  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;
  HomeBloc _bloc; //= HomeBloc();

  // List<String> data=["","","","",""];

  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  void initState() {
    LogCustom.logd("xxxxxxxxxx  home page initState");

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _bloc = HomeBloc(
        apiProvider: BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    callApi();

    super.initState();
  }

  void callApi() async {
    _bloc.getBanner(false);
  }

  @override
  Widget build(BuildContext context) {
    LogCustom.logd("xxxxxxxxxx  home page build");

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.bg,
        body: RefreshIndicator(
          onRefresh: () {
            LogCustom.logd("xxxxxxxxx refresh ");
            return _bloc.getBanner(true);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<bool>(
              future: _getDelayed(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                } else {
                  return Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          bannerBuild(),
                          //bannerView(),




                          StreamBuilder(
                            stream: _bloc.categoryWithImage.stream,
                            builder: (context,
                                AsyncSnapshot<MainCategoryResponse> snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                return Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(
                                        height: 24,
                                      ),

                                      Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [


                                            Text("Shop By Category"
                                                .toUpperCase(),
                                                style: AppTheme
                                                    .subtitlequicksand.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppTheme
                                                        .primarydark)),

                                            Image.asset(
                                              'assets/images/home_line.png',
                                              height: 10,
                                              color: AppTheme.primarydark,),

                                            SizedBox(height: 8,),

                                          ],
                                        ),
                                      ),


                                      // SizedBox(
                                      //   height: 4,
                                      // ),

                                      // Container(
                                      //     alignment: Alignment.center,
                                      //     child: Row(
                                      //       mainAxisAlignment: MainAxisAlignment.center,
                                      //       children: [
                                      //
                                      //         // Container(width: 100,
                                      //         // height: 1,
                                      //         // color: AppTheme.primarydark,),
                                      //
                                      //         Image.asset(
                                      //           'assets/images/home_line.png',
                                      //           height: 10,
                                      //           color: AppTheme.primarydark,
                                      //         ),
                                      //         //
                                      //         // Image.asset(
                                      //         //   'assets/images/home_line.png',
                                      //         //   height: 10,
                                      //         //   color: AppTheme.light_primarydark1,
                                      //         // ),
                                      //
                                      //         // Image.asset(
                                      //         //   'assets/images/home_line.png',
                                      //         //   height: 10,
                                      //         //   color: AppTheme.primarydark,
                                      //         // ),
                                      //
                                      //         // Image.asset(
                                      //         //   'assets/images/home_line.png',
                                      //         //   height: 10,
                                      //         //   color: AppTheme.light_primarydark1,
                                      //         // ),
                                      //
                                      //
                                      //         // Image.asset(
                                      //         //   'assets/images/home_line.png',
                                      //         //   height: 10,
                                      //         //   color: AppTheme.primarydark,
                                      //         // ),
                                      //       ],
                                      //     )),

                                      //  Text("SHOP BY CATEGORY",style: AppTheme.subtitlequicksand.copyWith(fontWeight: FontWeight.w500,fontSize: 16,color: AppTheme.medium_text_color),),

                                      SizedBox(
                                        height: 8,
                                      ),


                                      StaggeredGridView.countBuilder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          //padding:const EdgeInsets.all(0),
                                          padding: EdgeInsets.only(left: 4,
                                              right: 4,
                                              top: 0,
                                              bottom: 0),
                                          itemCount: snapshot.data.data.length,
                                          crossAxisCount: 6,
                                          mainAxisSpacing: 16.0,
                                          crossAxisSpacing: 16.0,
                                          staggeredTileBuilder: (index) =>
                                          new StaggeredTile.fit(
                                              (Constant.isIpad) ? 2 : 3),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SubCategoriesScreen(
                                                            catId: snapshot.data
                                                                .data[index].id
                                                                .toString(),
                                                            catName: snapshot
                                                                .data.data[index]
                                                                .title
                                                                .toString(),
                                                          )),
                                                )?.then((value) {


                                                  widget.onFlatButtonPressed();
                                                  print("Ayooo pachoo");
                                                  setState(() {

                                                  });
                                                });
                                              },
                                              child: TitleCategoryView(
                                                width: 120,
                                                height: 120,
                                                categoryData: snapshot.data
                                                    .data[index],
                                              ),
                                            );
                                          }),


                                      // Container(
                                      //   height: 175,
                                      //   child: ListView.builder(
                                      //       shrinkWrap: true,
                                      //       scrollDirection: Axis.horizontal,
                                      //       itemCount: snapshot.data.data.length,
                                      //       itemBuilder: (context, index) {
                                      //         animationController.duration =
                                      //             const Duration(milliseconds: 500);
                                      //
                                      //         final int count = snapshot.data.data.length > 10
                                      //             ? 10
                                      //             : snapshot.data.data.length;
                                      //
                                      //         Animation<double> animation =
                                      //             Tween<double>(begin: 0.0, end: 1.0).animate(
                                      //                 CurvedAnimation(
                                      //                     parent: animationController,
                                      //                     curve: Interval((1 / count) * index, 1.0,
                                      //                         curve: Curves.fastOutSlowIn)));
                                      //
                                      //         animationController.forward();
                                      //
                                      //         return AnimatedBuilder(
                                      //           animation: animationController,
                                      //           builder: (BuildContext context, Widget child) {
                                      //             return FadeTransition(
                                      //               opacity: animation,
                                      //               child: Transform(
                                      //                 /* transform: Matrix4.translationValues(
                                      //                         0.0, 50 * (1.0 - animation.value), 0.0),*/
                                      //                 transform: Matrix4.translationValues(
                                      //                     120 * (1.0 - animation.value), 0.0, 0.0),
                                      //                 child: TitleCategoryView(
                                      //                   width: 120,
                                      //                   height: 120,
                                      //                   categoryData: snapshot.data.data[index],
                                      //                 ),
                                      //               ),
                                      //             );
                                      //           },
                                      //         );
                                      //       }),
                                      // ),
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox(
                                  height: 25.0,
                                  width: 25.0,
                                );
                              }
                            },
                          ),
                          // newproductBuild(),
                          // bestSaleBuild(),
                        ],
                      ));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Banner on home page
  Widget bannerBuild() {
    return StreamBuilder(
      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<HomeSliderResponse> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Container(
            height: Constant.isIpad ? 400 : 195,
            child: Swiper(
              itemCount: snapshot.data.data.length,
              //  scale: 0.0,
              // viewportFraction: 0.99,
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: AppTheme.bg,
                  child: InkWell(
                      onTap: () {},
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data.data[index].image,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => Image.asset(
                            'assets/images/no_image.jpg',
                            height: Constant.isIpad ? 150 : 100),
                        placeholder: (context, url) => Image.asset(
                          logo_grey,
                          height: Constant.isIpad ? 150 : 100,
                          fit: BoxFit.cover,
                        ),
                      )),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return SizedBox.shrink();
        } else {
          return CommonLoading();
        }
      },
    );
  }

/*


  Widget bannerView() {

    return Container(
      height: Constant.isIpad?40:140,

      child: new Stack(
        alignment: AlignmentDirectional.topCenter,
        fit: StackFit.loose,
        children: <Widget>[

          Swiper(
            itemCount: 3,
          //  scale: 0.0,
           // viewportFraction: 0.99,
            autoplay: true,
            itemBuilder: (BuildContext context,int index){
              return  Container(

                margin: EdgeInsets.all(2),
               // padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border.all(
                      color: AppTheme.gray_400,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4.0)
                ),
                child: Container(
                  margin: EdgeInsets.all(1),
                  color: AppTheme.bg,
                  child: InkWell(
                    onTap: (){



                    },

                    child: */
/*CachedNetworkImage(imageUrl:homebannerImages[index].bannerimage,fit: BoxFit.fill,errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',height: Constant.isIpad?150:100),
                  placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: Constant.isIpad?150:100),
                )*/ /*
Image.asset(logo_home,height: Constant.isIpad?150:100),
                  ),
                ),
              );


            },


          ),


        ],

      ),

    );
  }

*/

  Widget newproductBuild() {
    return StreamBuilder(
      stream: _bloc.newproduct.stream,
      builder: (context, AsyncSnapshot<ProductListResponse> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return newArival(snapshot.data.data);
        } else {
          return const SizedBox(
            height: 25.0,
            width: 25.0,
          );
        }
      },
    );
  }

  Widget newArival(List<ProductData> data) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),

          Align(
            alignment: Alignment.center,
            child: Text("New Arrival".toUpperCase(),
                style: AppTheme.subtitlequicksand.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primarydark)),
          ),

          // SizedBox(
          //   height: 2,
          // ),

          // Container(
          //     alignment: Alignment.center,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //
          //         Image.asset(
          //           'assets/images/home_line.png',
          //           height: 10,
          //           color: AppTheme.primarydark,
          //         ),
          //         // Image.asset(
          //         //   'assets/images/home_line.png',
          //         //   height: 10,
          //         //   color: AppTheme.primarydark,
          //         // ),
          //       ],
          //     )),

          //  Text("NEW ARRIVAL",style: AppTheme.subtitlequicksand.copyWith(fontWeight: FontWeight.w500,fontSize: 16,color: AppTheme.medium_text_color),),
          //  Image.asset('assets/images/home_line.png',height: 20,),

          SizedBox(
            height: 8,
          ),

          Container(
            height: 280,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                  pId: data[index].id.toString(),
                                )),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        shadowColor: AppTheme.light_primarydark,
                        child: Stack(
                          children: [
                            Container(
                              width: 180,

                              // decoration: BoxDecoration(
                              //     border: Border.all(color: AppTheme.light_grey, width: 0.5,),
                              //     borderRadius: BorderRadius.circular(6.0),
                              //   // boxShadow: <BoxShadow>[
                              //   //   BoxShadow(
                              //   //     color: AppTheme.gray_300,
                              //   //     offset: const Offset(0, 2),
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
                                      topRight: Radius.circular(6),
                                      topLeft: Radius.circular(6)),
                                  child: CachedNetworkImage(
                                    imageUrl: data[index].imageName,
                                    fit: BoxFit.cover,
                                    width: 180,
                                    height: 180,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/images/no_image.jpg',
                                            width: 180,
                                            height: 180),
                                    placeholder: (context, url) => Image.asset(
                                        'assets/images/loading_dots.gif',
                                        width: 180,
                                        height: 180),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "\₹" +
                                                      Utils.currencyText(
                                                          data[index].price),
                                                  style: AppTheme
                                                      .subtitleopensanssemibold
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: AppTheme
                                                              .black_text_dark,
                                                          fontWeight: FontWeight
                                                              .w700))),
                                          InkWell(
                                            onTap: () {
                                              if (data[index].wishlist ==
                                                  Constant.isWishlist) {
                                                data[index].wishlist = "0";
                                                addremoveWishlist(false,
                                                    data[index].id.toString());
                                              } else {
                                                data[index].wishlist = "1";
                                                addremoveWishlist(true,
                                                    data[index].id.toString());
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              (data[index].wishlist ==
                                                      Constant.isWishlist)
                                                  ? favourite
                                                  : favourite,
                                              height: 20,
                                              color: (data[index].wishlist ==
                                                      Constant.isWishlist)
                                                  ? AppTheme.primary
                                                  : AppTheme.light_grey,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        data[index].title,
                                        style: AppTheme.subtitleopensans
                                            .copyWith(
                                                fontSize: 12,
                                                color: AppTheme.black_text,
                                                fontWeight: FontWeight.w100),
                                        maxLines: 2,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                style: TextStyle(
                                                    color: AppTheme
                                                        .hint_txt_798281,
                                                    fontFamily:
                                                        AppTheme.poppinsRegular,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 10,
                                                    height: 1.2),
                                                text: "Code : "),
                                            TextSpan(
                                                style: TextStyle(
                                                    color: AppTheme.primarydark,
                                                    fontFamily:
                                                        AppTheme.poppinsRegular,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10,
                                                    height: 1.5),
                                                text: data[index].productCode)
                                          ]))
                                    ],
                                  ),
                                ),
                              ]),
                            ),

                            // Positioned(
                            //   right: 28,
                            //   top: 12,
                            //   child: InkWell(
                            //     onTap: (){
                            //
                            //       if(data[index].wishlist==Constant.isWishlist){
                            //         data[index].wishlist="0";
                            //         addremoveWishlist(false, data[index].id.toString());
                            //       }else{
                            //         data[index].wishlist="1";
                            //         addremoveWishlist(true, data[index].id.toString());
                            //       }
                            //
                            //
                            //
                            //     },
                            //     child: SvgPicture.asset((data[index].wishlist==Constant.isWishlist)?favourite:favourite,height: 20,color: (data[index].wishlist==Constant.isWishlist)?AppTheme.primary:AppTheme.off_white,),
                            //   ),
                            // ),

                            (data[index].tna == "1")
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
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget bestSaleBuild() {
    return StreamBuilder(
      stream: _bloc.bestsaleproduct.stream,
      builder: (context, AsyncSnapshot<ProductListResponse> snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data.data.isNotEmpty) {
          return getbestsale(snapshot.data.data);
        } else {
          return const SizedBox(
            height: 25.0,
            width: 25.0,
          );
        }
      },
    );
  }

  Widget getbestsale(List<ProductData> data) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),

          Align(
            alignment: Alignment.center,
            child: Text("Best Seller".toUpperCase(),
                style: AppTheme.subtitlequicksand.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primarydark)),
          ),

          // SizedBox(
          //   height: 2,
          // ),

          // Container(
          //     alignment: Alignment.center,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           'assets/images/home_line.png',
          //           height: 10,
          //           color: AppTheme.primarydark,
          //         ),
          //         // Image.asset(
          //         //   'assets/images/home_line.png',
          //         //   height: 10,
          //         //   color: AppTheme.primarydark,
          //         // ),
          //       ],
          //     )),

          //  Text("BEST SALE",style: AppTheme.subtitlequicksand.copyWith(fontWeight: FontWeight.w500,fontSize: 16,color: AppTheme.medium_text_color),),

          //  Text("BEST SALE",style: AppTheme.subtitlequicksand.copyWith(fontWeight: FontWeight.w500,fontSize: 16),),

          //     Image.asset('assets/images/home_line.png',height: 20,),

          SizedBox(
            height: 8,
          ),

          ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    shadowColor: AppTheme.light_primarydark,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    print("data[index].id   " +
                                        data[index].id.toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailsScreen(
                                                pId: data[index].id.toString(),
                                              )),
                                    );
                                  },
                                  child: Container(
                                    // decoration: BoxDecoration(
                                    //   border: Border.all(
                                    //     color: AppTheme.off_White,
                                    //     width: 0.5,
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(6.0),
                                    //   // boxShadow: <BoxShadow>[
                                    //   //   BoxShadow(
                                    //   //     color: AppTheme.off_White,
                                    //   //     offset: const Offset(0, 2),
                                    //   //     blurRadius: 2,
                                    //   //
                                    //   //   ),
                                    //   //
                                    //   // ],
                                    // ),

                                    // width: 120,
                                    // margin: EdgeInsets.only(right: 5,left: 5),
                                    // padding: EdgeInsets.all(5),
                                    //
                                    // decoration: BoxDecoration(
                                    //     boxShadow: <BoxShadow>[
                                    //       BoxShadow(
                                    //         color: AppTheme.gray_300,
                                    //         offset: const Offset(0, 4),
                                    //         blurRadius: 2,
                                    //
                                    //       ),
                                    //
                                    //     ],
                                    //
                                    //     color: AppTheme.white,
                                    //     border: Border.all(
                                    //       color: AppTheme.gray_400,
                                    //       width: 1,
                                    //     ),
                                    //     borderRadius: BorderRadius.circular(2.0)
                                    // ),

                                    child: Row(children: <Widget>[
                                      // Image.asset('assets/images/logo.png',height: 100),

                                      Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(6),
                                              topLeft: Radius.circular(6)),

                                          // padding: EdgeInsets.all(4),
                                          child: CachedNetworkImage(
                                            imageUrl: data[index].imageName,
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.fill,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/no_image.jpg',
                                              width: 150,
                                              height: 150,
                                            ),
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/images/loading_dots.gif',
                                              height: 150,
                                              width: 150,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "\₹" +
                                                      Utils.currencyText(
                                                          data[index].price),
                                                  style: AppTheme
                                                      .subtitleopensanssemibold
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: AppTheme
                                                              .black_text_dark,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              data[index].title,
                                              style: AppTheme.subtitleopensans
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color:
                                                          AppTheme.black_text,
                                                      fontWeight:
                                                          FontWeight.w100),
                                              maxLines: 2,
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .hint_txt_798281,
                                                          fontFamily: AppTheme
                                                              .poppinsRegular,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 11,
                                                          height: 1.2),
                                                      text: "Code : "),
                                                  TextSpan(
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .primarydark,
                                                          fontFamily: AppTheme
                                                              .poppinsRegular,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 11,
                                                          height: 1.5),
                                                      text: data[index]
                                                          .productCode)
                                                ]))
                                          ],
                                        ),
                                      ),
                                    ]),
                                  )),

                              //   Container(margin: EdgeInsets.only(top: 16),height: 0.5, width: double.infinity, color: AppTheme.light_grey,)
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              if (data[index].wishlist == Constant.isWishlist) {
                                data[index].wishlist = "0";
                                addremoveWishlist(
                                    false, data[index].id.toString());
                              } else {
                                data[index].wishlist = "1";
                                addremoveWishlist(
                                    true, data[index].id.toString());
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  (data[index].wishlist == Constant.isWishlist)
                                      ? favourite
                                      : favourite,
                                  height: 20,
                                  color: (data[index].wishlist ==
                                          Constant.isWishlist)
                                      ? AppTheme.primary
                                      : AppTheme.light_grey,
                                )),
                          ),
                        ),
                        (data[index].tna == "1")
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

          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new CupertinoAlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No',style: AppTheme.subtitlequicksand.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.black_text)),
              ),
              new TextButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  //Navigator.of(context).pop(true)
                },
                child: new Text('Yes',style: AppTheme.subtitlequicksand.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppTheme.black_text)),
              ),
            ],
          ),
        )) ??
        false;
  }

  void callSerachApi(String msg) {
    // _bloc.getSearch(msg);
  }

  @override
  void dispose() {
    LogCustom.logd("xxxxxxxxxx  home page dispose");
    // WidgetsBinding.instance.removeObserver(this);

    _bloc?.dispose();
    _animationController.dispose();
    super.dispose();
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
}

class CategoryView extends StatelessWidget {
  final HomeBloc bloc;

  final AnimationController animationController;

  // final List<String> data=["","","","",""];

  CategoryView(
      {Key key, @required this.bloc, @required this.animationController})
      : super(key: key); //= HomeBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.categoryWithImage.stream,
      builder: (context, AsyncSnapshot<MainCategoryResponse> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [


                      Text("Shop By Category".toUpperCase(),
                          style: AppTheme.subtitlequicksand.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.primarydark)),

                      Image.asset('assets/images/home_line.png',height: 10,color: AppTheme.primarydark,),

                      SizedBox(height: 8,),

                    ],
                  ),
                ),


                // SizedBox(
                //   height: 4,
                // ),

                // Container(
                //     alignment: Alignment.center,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //
                //         // Container(width: 100,
                //         // height: 1,
                //         // color: AppTheme.primarydark,),
                //
                //         Image.asset(
                //           'assets/images/home_line.png',
                //           height: 10,
                //           color: AppTheme.primarydark,
                //         ),
                //         //
                //         // Image.asset(
                //         //   'assets/images/home_line.png',
                //         //   height: 10,
                //         //   color: AppTheme.light_primarydark1,
                //         // ),
                //
                //         // Image.asset(
                //         //   'assets/images/home_line.png',
                //         //   height: 10,
                //         //   color: AppTheme.primarydark,
                //         // ),
                //
                //         // Image.asset(
                //         //   'assets/images/home_line.png',
                //         //   height: 10,
                //         //   color: AppTheme.light_primarydark1,
                //         // ),
                //
                //
                //         // Image.asset(
                //         //   'assets/images/home_line.png',
                //         //   height: 10,
                //         //   color: AppTheme.primarydark,
                //         // ),
                //       ],
                //     )),

                //  Text("SHOP BY CATEGORY",style: AppTheme.subtitlequicksand.copyWith(fontWeight: FontWeight.w500,fontSize: 16,color: AppTheme.medium_text_color),),

                SizedBox(
                  height: 8,
                ),


                StaggeredGridView.countBuilder(
                    physics:const NeverScrollableScrollPhysics(),
                    shrinkWrap : true,
                    scrollDirection: Axis.vertical,
                    //padding:const EdgeInsets.all(0),
                    padding:  EdgeInsets.only(left:4,right: 4,top: 0,bottom: 0),
                    itemCount: snapshot.data.data.length,
                    crossAxisCount:6,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing:16.0,
                    staggeredTileBuilder: (index) => new StaggeredTile.fit((Constant.isIpad)?2:3),
                    itemBuilder: (context,index){


                      return TitleCategoryView(
                          width: 120,
                          height: 120,
                          categoryData: snapshot.data.data[index],
                        );

                    }) ,



                // Container(
                //   height: 175,
                //   child: ListView.builder(
                //       shrinkWrap: true,
                //       scrollDirection: Axis.horizontal,
                //       itemCount: snapshot.data.data.length,
                //       itemBuilder: (context, index) {
                //         animationController.duration =
                //             const Duration(milliseconds: 500);
                //
                //         final int count = snapshot.data.data.length > 10
                //             ? 10
                //             : snapshot.data.data.length;
                //
                //         Animation<double> animation =
                //             Tween<double>(begin: 0.0, end: 1.0).animate(
                //                 CurvedAnimation(
                //                     parent: animationController,
                //                     curve: Interval((1 / count) * index, 1.0,
                //                         curve: Curves.fastOutSlowIn)));
                //
                //         animationController.forward();
                //
                //         return AnimatedBuilder(
                //           animation: animationController,
                //           builder: (BuildContext context, Widget child) {
                //             return FadeTransition(
                //               opacity: animation,
                //               child: Transform(
                //                 /* transform: Matrix4.translationValues(
                //                         0.0, 50 * (1.0 - animation.value), 0.0),*/
                //                 transform: Matrix4.translationValues(
                //                     120 * (1.0 - animation.value), 0.0, 0.0),
                //                 child: TitleCategoryView(
                //                   width: 120,
                //                   height: 120,
                //                   categoryData: snapshot.data.data[index],
                //                 ),
                //               ),
                //             );
                //           },
                //         );
                //       }),
                // ),
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 25.0,
            width: 25.0,
          );
        }
      },
    );
  }
}
