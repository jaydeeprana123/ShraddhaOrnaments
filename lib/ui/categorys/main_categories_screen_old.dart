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
import 'package:shradha_design/response/maincategory/main_category_response.dart';
import 'package:shradha_design/ui/categorys/CatBloc.dart';
import 'package:shradha_design/ui/categorys/sub_categories_screen.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';


class MainCategoriesScreen extends StatefulWidget {
  @override
  MainCategoriesScreenState createState() {
    return MainCategoriesScreenState();
  }
}

class MainCategoriesScreenState extends State<MainCategoriesScreen>  with TickerProviderStateMixin  {

  AnimationController _animationController;
  CatBloc _bloc ;//= HomeBloc();




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
    _bloc.getcategoryMain(false);
  }



  @override
  Widget build(BuildContext context) {

    LogCustom.logd("xxxxxxxxxx  home page build");
    return SingleChildScrollView(
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






                    newArival(),




                  ],
                )
            ) ;
          }
        },
      ),


    );

    return CommonScaffold(
      //scaffoldKey: _scaffoldKey,
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






                          newArival(),




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









Widget newArival(){


  return Column(

    children: [




      bannerBuild(),




    ],
  );

}





  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.categoryWithImage.stream,
      builder: (context, AsyncSnapshot<MainCategoryResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {

          return Column(

            children: [

              SizedBox(
                height: 10,
              ),

              Text("Shop by Category".toUpperCase(),style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

              Image.asset('assets/images/home_line.png',height: 10,),

              SizedBox(
                height: 10,
              ),




              StaggeredGridView.countBuilder(
                  physics:const NeverScrollableScrollPhysics(),
                  shrinkWrap : true,
                  scrollDirection: Axis.vertical,
                  //padding:const EdgeInsets.all(0),
                  padding: const EdgeInsets.only(left:4,right: 4,top: 0,bottom: 15),
                  itemCount: _bloc.categoryWithImage.value.data.length,
                  crossAxisCount: 6,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  staggeredTileBuilder: (index) => new StaggeredTile.fit((Constant.isIpad)?2:3),
                  itemBuilder: (context,index){


                    return InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoriesScreen(catId:_bloc.categoryWithImage.value.data[index].id.toString() ,)),);

                      },
                      child: Container(
                        // width: 120,
                        margin: EdgeInsets.all(4),

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

                        /* decoration: BoxDecoration(
                           // color: AppTheme.primarydark,
                            border: Border.all(
                              color: AppTheme.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(2.0)
                        ),
*/


                        child:Column(children: <Widget>[





                          Container(
                           // color:AppTheme.white,
                           // padding: EdgeInsets.all(5),
                            child: CachedNetworkImage(imageUrl:_bloc.categoryWithImage.value.data[index].image,fit: BoxFit.contain,height: 170,
                              errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',height: 150,),
                              placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: 150,),
                            ),
                          ),



                        /*  Container(
                            color: AppTheme.white,

                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(5),
                            child: Text(_bloc.categoryWithImage.value.data[index].title , style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black,fontSize: 12)),
                          ),
                        */


                          Container(
                            color: AppTheme.white,

                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(5),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: _bloc.categoryWithImage.value.data[index].title,
                                    style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black,fontSize: 12),

                                  ),
                                  TextSpan(
                                    text: " ("+_bloc.categoryWithImage.value.data[index].count.toString()+")",
                                    style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.primary,fontSize: 12),

                                  ),
                                ],
                              ),
                            )
                          ),




                        ]),



                      ),
                    );

                  }) ,





            ],
          );

        }else if (snapshot.hasError ) {
          return CommonError(error:snapshot.error);
        }  else {
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



