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
import 'package:shradha_design/response/subcategory/sub_category_response.dart';
import 'package:shradha_design/ui/categorys/CatBloc.dart';
import 'package:shradha_design/ui/productlist/productlist_screen.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';


class SubSubCategoriesScreen extends StatefulWidget {

  final String catId;
  final String catName;

  const SubSubCategoriesScreen({Key key, this.catId, this.catName}) : super(key: key);

  @override
  SubSubCategoriesScreenState createState() {
    return SubSubCategoriesScreenState();
  }
}



class SubSubCategoriesScreenState extends State<SubSubCategoriesScreen>  with TickerProviderStateMixin  {



  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;
  CatBloc _bloc ;//= HomeBloc();


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

          _bloc = CatBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );


    callApi();






    super.initState();



  }






  void callApi(){

    Map parms=new Map<String,String>();
    parms.putIfAbsent("id", () => widget.catId);

    _bloc.getsub_subcat(false, parms);


  }



  @override
  Widget build(BuildContext context) {

    LogCustom.logd("xxxxxxxxxx  home page build");

    return CommonScaffold(
      onFlatButtonPressed: (){
        setState(() {

        });
      },
      //scaffoldKey: _scaffoldKey,
      appTitle: widget.catName,
      backGroundColor: AppTheme.bg,
      showDrawer: false,
        showFAB: false,
        bodyData: Scaffold(
          backgroundColor: AppTheme.bg,
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),

            child: FutureBuilder<bool>(
              future: _getDelayed(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                } else {
                  return  Container(
                      alignment: Alignment.center,
                     // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10,right: 10) ,
                      child: Column(
                        children: [


                        /*  SizedBox(
                            height: 5,
                          ),

                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                              *//*  Text("Sub Category",style: AppTheme.subtitle.copyWith(fontSize: 20,fontWeight: FontWeight.w700,color: AppTheme.primarydark),),

                                SizedBox(width: 5,),

                                Container(
                                  padding: EdgeInsets.only(top:4),
                                  // alignment: Alignment.centerLeft,
                                  child: Container(height: 1,width: 100,alignment: Alignment.centerLeft,color: AppTheme.primarydark,),

                                )
*//*

                              ],
                            ),
                          ),
*/





                          bannerBuild(),




                        ],
                      )
                  ) ;
                }
              },
            ),


          ),




        ),
    );


  }




  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<SubCategoryResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null && snapshot.data.data != null &&  snapshot.data.data.length != 0 ) {


          return Container(
            margin: EdgeInsets.only(left: 16, right: 16,top: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   "Shop by Category".toUpperCase(),
                //   style:
                //       AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),
                // ),
                // Image.asset(
                //   'assets/images/home_line.png',
                //   height: 10,
                // ),

                SizedBox(height: 8,),

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
                          text: "(" +  snapshot.data.data.length.toString() + ")")
                    ])),




                ListView.builder(
                    primary: false,
                    shrinkWrap : true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context,index){


                      return Column(
                        children: [
                          InkWell(

                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductListScreen(
                                        catId: snapshot.data.data[index].id
                                            .toString(),

                                        catName: snapshot.data.data[index].title
                                            .toString(),

                                        isList: false,

                                      )),
                                )?.then((value) {
                                  setState(() {

                                  });
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 8, bottom: 8)
                                ,child:Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[


                                // Image.asset('assets/images/logo.png',height: 100),

                                Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),

                                  child:ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    // padding: EdgeInsets.all(4),
                                    child: CachedNetworkImage(imageUrl: snapshot.data.data[index].image,height: 100,width: 100,fit: BoxFit.fill,
                                      errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',width: 100,height: 100,),
                                      placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: 100, width: 100,),
                                    ),
                                  ),

                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      color: AppTheme.black_text_dark,
                                                      fontFamily: AppTheme.poppinsRegular,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 15,
                                                      height: 1.2),
                                                  text: snapshot.data.data[index].title),
                                              // TextSpan(
                                              //     style: TextStyle(
                                              //         fontWeight: FontWeight.w700,
                                              //         color: AppTheme.primarydark,
                                              //         fontFamily: AppTheme.opensans,
                                              //         fontStyle: FontStyle.normal,
                                              //         fontSize: 13,
                                              //         height: 1.5),
                                              //     text: "  (" +
                                              //         _bloc
                                              //             .category.value.data[index].count
                                              //             .toString() +
                                              //         ")")
                                            ])),



                                        Container(
                                          margin: EdgeInsets.only(top: 8),
                                          padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
                                          decoration: BoxDecoration(color: AppTheme.light_primarydark,
                                            border: Border.all(color: AppTheme.light_primarydark, width: 0.25,),
                                            borderRadius: BorderRadius.circular(2.0),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: AppTheme.light_pink,
                                                offset: const Offset(0, 4),
                                                blurRadius: 6,

                                              ),

                                            ],



                                          ),

                                          child: Text(snapshot.data.data[index].count.toString() + ((snapshot.data.data[index].count == 1)?" Item Available":" Items Available") , style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppTheme.black_text,
                                              fontFamily: AppTheme.poppinsRegular,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12,
                                              height: 1.5)),
                                        )
                                      ],
                                    ),

                                  ),
                                ),

                                // Icon(Icons.chevron_right_sharp,color: AppTheme.light_text_color,),
                                //
                                // SizedBox(width: 6,)

                              ]),



                              )

                          ),

                          Container(color: AppTheme.off_White_bg,width: double.infinity, height: 1,margin: EdgeInsets.only(top: 16, bottom: 12),),

                        ],
                      );
                    }),


//               StaggeredGridView.countBuilder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   //padding:const EdgeInsets.all(0),
//                   padding: const EdgeInsets.only(
//                       left: 4, right: 4, top: 0, bottom: 15),
//                   itemCount: snapshot.data.data.length,
//                   crossAxisCount: 6,
//                   mainAxisSpacing: 4.0,
//                   crossAxisSpacing: 4.0,
//                   staggeredTileBuilder: (index) =>
//                       new StaggeredTile.fit((Constant.isIpad) ? 2 : 3),
//                   itemBuilder: (context, index) {
//                     return Stack(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SubSubCategoriesScreen(
//                                         catId: snapshot.data.data[index].id
//                                             .toString(),
//                                       )),
//                             );
//                           },
//                           child: Container(
//                             // width: 100,
//                             margin: EdgeInsets.all(4),
//
//                             //padding: EdgeInsets.all(5),
//
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(2)),
//                               color: Colors.white,
//                               boxShadow: <BoxShadow>[
//                                 BoxShadow(
//                                   color: AppTheme.gray_300,
//                                   offset: const Offset(1, 1),
//                                   blurRadius: 2,
//                                 ),
//                               ],
//                             ),
//
//                             child: Column(children: <Widget>[
//                               Container(
//                                 // color:AppTheme.white,
//                                 padding: EdgeInsets.all(5),
//                                 child: CachedNetworkImage(
//                                   imageUrl:
//                                       snapshot.data.data[index].image,
//                                   fit: BoxFit.contain,
//                                   height: 170,
//                                   errorWidget: (context, url, error) =>
//                                       Image.asset(
//                                     'assets/images/no_image.jpg',
//                                     height: 150,
//                                   ),
//                                   placeholder: (context, url) => Image.asset(
//                                     'assets/images/loading_dots.gif',
//                                     height: 150,
//                                   ),
//                                 ),
//                               ),
//
//                               /* Container(
//                                 color: AppTheme.white,
//                                 alignment: Alignment.centerLeft,
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(snapshot.data.data[index].title , style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black,fontSize: 12)),
//                               ),
// */
//
//                               Container(
//                                   color: AppTheme.white,
//                                   alignment: Alignment.centerLeft,
//                                   padding: EdgeInsets.all(5),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text: _bloc
//                                               .category.value.data[index].title,
//                                           style: AppTheme.subtitlerubicSemi
//                                               .copyWith(
//                                                   color: AppTheme.black,
//                                                   fontSize: 12),
//                                         ),
//                                         TextSpan(
//                                           text: " (" +
//                                               snapshot.data.data[index]
//                                                   .count
//                                                   .toString() +
//                                               ")",
//                                           style: AppTheme.subtitlerubicSemi
//                                               .copyWith(
//                                                   color: AppTheme.primary,
//                                                   fontSize: 12),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ]),
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
              ],
            ),
          );


        } else if (snapshot.hasError ) {
          return CommonError(error:snapshot.error);
        }   else {
          return  CommonLoading();
        }
      },
    );
  }




















  void callSerachApi(String msg){
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






















}



