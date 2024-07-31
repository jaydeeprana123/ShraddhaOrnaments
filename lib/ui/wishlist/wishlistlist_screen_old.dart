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


class WishListScreen extends StatefulWidget {



  @override
  WishListScreenState createState() {
    return WishListScreenState();
  }
}



class WishListScreenState extends State<WishListScreen>  with WidgetsBindingObserver  {



  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  WishListBloc _bloc ;//= HomeBloc();




  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }








  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    LogCustom.logd("xxxxxxxxxx  home page initState");



          _bloc = WishListBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );


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



  void callApi(){



    Map parms=new Map<String,String>();

    parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());

    _bloc.getwishlist(false, parms);

  }



  @override
  Widget build(BuildContext context) {

    LogCustom.logd("xxxxxxxxxx  home page build");

    return CommonScaffold(
      //scaffoldKey: _scaffoldKey,
      appTitle: "Wish List",
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
                      margin: EdgeInsets.only(left: 5,right: 5) ,
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


      SizedBox(
        height: 10,
      ),

      Stack(
        children: [





          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wish List",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

                Image.asset('assets/images/home_line.png',height: 10,),

              ],
            ),
          ),







        ],
      ),


      SizedBox(
        height: 10,
      ),

      bannerBuild(),




    ],
  );

}





  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<WishListResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {


          return Column(

            children: [




              StaggeredGridView.countBuilder(
                  physics:const NeverScrollableScrollPhysics(),
                  shrinkWrap : true,
                  scrollDirection: Axis.vertical,
                  //padding:const EdgeInsets.all(0),
                  padding: const EdgeInsets.only(left:4,right: 4,top: 0,bottom: 15),
                  itemCount: _bloc.subject.value.data.length,
                  crossAxisCount: 6,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  staggeredTileBuilder: (index) => new StaggeredTile.fit((Constant.isIpad)?2:3),
                  itemBuilder: (context,index){


                    return InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId:_bloc.subject.value.data[index].id.toString() ,)),).whenComplete(() {

                          callApi();

                        });

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
                                child: CachedNetworkImage(imageUrl:_bloc.subject.value.data[index].imageName,fit: BoxFit.contain,height: 170,
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

                                    Text("\₹"+_bloc.subject.value.data[index].price , style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.primary,fontSize: 12)),
                                    Text(_bloc.subject.value.data[index].title , style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black,fontSize: 12)),
                                  ],
                                )
                              ),

                            ]),



                          ),

                          Positioned(
                            right: 5,
                            top: 5,
                            child: InkWell(
                              onTap: (){

                               /* if(_bloc.subject.value.data[index].wishlist==Constant.isWishlist){
                                  _bloc.subject.value.data[index].wishlist="0";
                                  addremoveWishlist(false, _bloc.subject.value.data[index].id.toString());
                                }else{
                                  _bloc.subject.value.data[index].wishlist="1";
                                  addremoveWishlist(true, _bloc.subject.value.data[index].id.toString());
                                }
*/
                                addremoveWishlist(false, _bloc.subject.value.data[index].id.toString(),index);


                              },
                              child: Image.asset('assets/images/like_active.png',height: 30,),
                            ),
                          ),





                          (_bloc.subject.value.data[index].tna=="1")? Positioned(
                            left: 5,
                            top: 5,
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





            ],
          );


        }
        else if (snapshot.hasError ) {
          return CommonError(error:snapshot.error);
        }   else {
          return  CommonLoading();
        }
      },
    );
  }




  addremoveWishlist(bool isAdd,String productId,int index)async{



    await Pr.show(context);

    Map<String, String> parms = new Map<String,String>();
    parms.putIfAbsent("user_id",()=> _bloc.apiProvider.pref.getUserId());
    parms.putIfAbsent("product_id",()=> productId);

    await _bloc.addremoveWhislist(isAdd,parms);


    _bloc.subject.value.data.removeAt(index);

    await Pr.hide(context);

    callApi();


    setState(() {});




  }







  void callSerachApi(String msg){
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



