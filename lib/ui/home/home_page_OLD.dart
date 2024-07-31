import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:shradha_design/utils/pager/src/swiper.dart';
import 'package:shradha_design/utils/utils.dart';



class HomePageFragment extends StatefulWidget {
  @override
  HomePageFragmentState createState() {
    return HomePageFragmentState();
  }
}



class HomePageFragmentState extends State<HomePageFragment>  with TickerProviderStateMixin  {



  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;
   HomeBloc _bloc ;//= HomeBloc();


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

          _bloc = HomeBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );


    callApi();






    super.initState();



  }






  void callApi()async{
    _bloc.getBanner(false);



  }



  @override
  Widget build(BuildContext context) {

    LogCustom.logd("xxxxxxxxxx  home page build");

    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.bg,
        body: RefreshIndicator(
          onRefresh: (){
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
                  return  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 5,right: 5) ,
                      child: Column(
                        children: [


                          bannerBuild(),
                          //bannerView(),



                          CategoryView(bloc: _bloc,animationController: _animationController,),




                          newproductBuild(),


                          bestSaleBuild(),

                        ],
                      )
                  ) ;
                }
              },
            ),


          ),
        ),




      ),
    );


  }





  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<HomeSliderResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {


           return Container(
            height: Constant.isIpad?400:185,

            child: new Stack(
              alignment: AlignmentDirectional.topCenter,
              fit: StackFit.loose,
              children: <Widget>[

                Swiper(
                  itemCount: snapshot.data.data.length,
                  //  scale: 0.0,
                  // viewportFraction: 0.99,
                  autoplay: true,
                  itemBuilder: (BuildContext context,int index){
                    return  Container(

                    //  margin: EdgeInsets.all(2),
                       padding: EdgeInsets.all(1),
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
                          child: CachedNetworkImage(imageUrl:snapshot.data.data[index].image,fit: BoxFit.fill,errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',height: Constant.isIpad?150:100),
                          placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: Constant.isIpad?150:100),
                           )
                        ),
                      ),
                    );


                  },


                ),


              ],

            ),

          );


        } else if (snapshot.hasError ) {
          return SizedBox.shrink();
        }  else {
          return  CommonLoading();
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
                )*//*
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

        if (snapshot.hasData && snapshot.data != null ) {


          return newArival(snapshot.data.data);


        }  else {
          return  const SizedBox(
            height: 25.0,
            width: 25.0,

          );
        }
      },
    );
  }




  Widget newArival(List<ProductData> data){


  return Column(

    children: [

      SizedBox(
        height: 15,
      ),

      Text("NEW ARRIVAL",style: AppTheme.subtitlequicksand.copyWith(fontWeight: FontWeight.w500,fontSize: 16),),

      Image.asset('assets/images/home_line.png',height: 20,),

      SizedBox(
        height: 10,
      ),


      Container(
        height: 185,
        child: ListView.builder(
            shrinkWrap : true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,

            itemBuilder: (context,index){
              return InkWell(

                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: data[index].id.toString(),)),);

                },
                child: Stack(
                  children: [
                    Container(
                      width: 140,
                      margin: EdgeInsets.only(right: 5,left: 5),
                      padding: EdgeInsets.all(5),

                      decoration: BoxDecoration(color: AppTheme.white,
                          border: Border.all(color: AppTheme.gray_400, width: 1,),
                          borderRadius: BorderRadius.circular(2.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppTheme.gray_300,
                            offset: const Offset(0, 4),
                            blurRadius: 2,

                          ),

                        ],



                      ),



                      child:Column(children: <Widget>[


                        // Image.asset('assets/images/logo.png',height: 100),

                        CachedNetworkImage(imageUrl:data[index].imageName, fit: BoxFit.contain,width:150,
                          errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg') ,
                          placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',width: 150),

                        ),

                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: <Widget>[

                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("\₹"+Utils.currencyText(data[index].price) , style: AppTheme.subtitlequicksandsemibold.copyWith(color: AppTheme.primary)),
                              ),


                              const SizedBox(
                                height: 2,
                              ),

                              Text(data[index].title , style: AppTheme.subtitlequicksandsemibold.copyWith(),maxLines: 1,),




                            ],
                          ),

                        ),

                      ]),



                    ),

                    Positioned(
                      right: 4,
                      top: 1,
                      child: InkWell(
                        onTap: (){

                          if(data[index].wishlist==Constant.isWishlist){
                            data[index].wishlist="0";
                            addremoveWishlist(false, data[index].id.toString());
                          }else{
                            data[index].wishlist="1";
                            addremoveWishlist(true, data[index].id.toString());
                          }



                        },
                        child: Image.asset((data[index].wishlist==Constant.isWishlist)?'assets/images/like_active.png':'assets/images/like.png',height: 30,),
                      ),
                    ),



                    (data[index].tna=="1")? Positioned(
                      left: 5,
                      top: 2,
                      child: InkWell(
                        onTap: (){


                        },
                        child: Image.asset('assets/images/tna_icon.png',height: 25,),
                      ),
                    ):SizedBox.shrink(),




                  ],
                ),
              );
            }),
      ),






    ],
  );

}









  Widget bestSaleBuild() {
    return StreamBuilder(

      stream: _bloc.bestsaleproduct.stream,
      builder: (context, AsyncSnapshot<ProductListResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null && snapshot.data.data.isNotEmpty ) {


          return getbestsale(snapshot.data.data);


        }  else {
          return  const SizedBox(
            height: 25.0,
            width: 25.0,

          );
        }
      },
    );
  }



  Widget getbestsale(List<ProductData> data){


    return Column(

      children: [

        SizedBox(
          height: 20,
        ),

        Text("BEST SALE",style: AppTheme.subtitlequicksand.copyWith(fontWeight: FontWeight.w500,fontSize: 16),),

        Image.asset('assets/images/home_line.png',height: 20,),

        SizedBox(
          height: 10,
        ),


        Container(

          height: 185,
          child: ListView.builder(
              shrinkWrap : true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context,index){


                return Stack(
                  children: [

                    Container(
                      width: 140,
                      margin: EdgeInsets.only(right: 5,left: 2),


                      child: InkWell(

                          onTap: (){


                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: data[index].id.toString(),)),);

                          },
                          child: Container(
                            // width: 120,
                            // margin: EdgeInsets.only(right: 5,left: 5),
                            padding: EdgeInsets.all(5),

                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: AppTheme.gray_300,
                                    offset: const Offset(0, 4),
                                    blurRadius: 2,

                                  ),

                                ],

                                color: AppTheme.white,
                                border: Border.all(
                                  color: AppTheme.gray_400,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(2.0)
                            ),



                            child:Column(children: <Widget>[


                              // Image.asset('assets/images/logo.png',height: 100),

                              CachedNetworkImage(imageUrl:data[index].imageName, fit: BoxFit.contain,width:150,
                                errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg') ,
                                placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',width: 150),

                              ),

                              Padding(
                                padding: const EdgeInsets.all(1),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: <Widget>[

                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("\₹"+Utils.currencyText(data[index].price) , style: AppTheme.subtitlequicksandsemibold.copyWith(color: AppTheme.primary)),
                                    ),


                                    const SizedBox(
                                      height: 2,
                                    ),

                                    Text(data[index].title , style: AppTheme.subtitlequicksandsemibold.copyWith(),maxLines: 1,),




                                  ],
                                ),

                              ),

                            ]),



                          )

                      ),
                    ),



                    Positioned(
                      right: 4,
                      top: 1,
                      child: InkWell(
                        onTap: (){

                          if(data[index].wishlist==Constant.isWishlist){
                            data[index].wishlist="0";
                            addremoveWishlist(false, data[index].id.toString());
                          }else{
                            data[index].wishlist="1";
                            addremoveWishlist(true, data[index].id.toString());
                          }


                        },
                        child: Image.asset((data[index].wishlist==Constant.isWishlist)?'assets/images/like_active.png':'assets/images/like.png',height: 30,),
                      ),
                    ),


                    (data[index].tna=="1")? Positioned(
                      left: 5,
                      top: 2,

                      child: InkWell(
                        onTap: (){


                        },
                        child: Image.asset('assets/images/tna_icon.png',height: 25,),
                      ),
                    ):SizedBox.shrink(),


                  ],
                );
              }),
        ),


        SizedBox(
          height: 10,
        ),



      ],
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
            child: new Text('No'),
          ),
          new TextButton(
            onPressed: ()  {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                //Navigator.of(context).pop(true)
              },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
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














  addremoveWishlist(bool isAdd,String productId)async{



    await Pr.show(context);

      Map<String, String> parms = new Map<String,String>();
      parms.putIfAbsent("user_id",()=> _bloc.apiProvider.pref.getUserId());
      parms.putIfAbsent("product_id",()=> productId);

      await _bloc.addremoveWhislist(isAdd,parms);

    await Pr.hide(context);

      setState(() {});



  }








}


class CategoryView extends StatelessWidget{

  final HomeBloc bloc ;
  final AnimationController animationController;
 // final List<String> data=["","","","",""];


   CategoryView({Key key, @required this.bloc, @required this.animationController}) : super(key: key);//= HomeBloc();

  @override
  Widget build(BuildContext context) {


    return StreamBuilder(

      stream: bloc.categoryWithImage.stream,
      builder: (context, AsyncSnapshot<MainCategoryResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {


          return Column(


            children: [


              SizedBox(
                height: 15,
              ),

              Text("SHOP BY CATEGORY",style: AppTheme.subtitlequicksand.copyWith(fontWeight: FontWeight.w500,fontSize: 16),),

              Image.asset('assets/images/home_line.png',height: 20,),

              SizedBox(
                height: 10,
              ),



              Container(
                height: 130,
                child: ListView.builder(
                    shrinkWrap : true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.data.length,

                    itemBuilder: (context,index){

                      animationController.duration=const Duration(milliseconds: 500);

                      final int count =
                      snapshot.data.data.length > 10 ? 10 : snapshot.data.data.length;

                      Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 /count ) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));

                      animationController.forward();

                      return AnimatedBuilder(
                        animation: animationController,
                        builder: (BuildContext context, Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child: Transform(
                              /* transform: Matrix4.translationValues(
                                      0.0, 50 * (1.0 - animation.value), 0.0),*/
                              transform: Matrix4.translationValues(
                                  100 * (1.0 - animation.value), 0.0, 0.0),
                              child:InkWell(

                                onTap: (){


                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoriesScreen(catId: snapshot.data.data[index].id.toString(),)),);




                                },
                                child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      Container(
                                        margin: const EdgeInsets.only(left: 10,right:10),
                                        // padding: EdgeInsets.all(5),
                                        height:78,
                                        //width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(35)),
                                          // color: Colors.white,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: AppTheme.gray_300,
                                              offset: const Offset(0, 4),
                                              blurRadius: 2,

                                            ),

                                          ],

                                        ),



                                        child: Card(
                                          elevation: 2.0,

                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),

                                          child:ClipRRect(
                                            borderRadius: BorderRadius.circular(35.0),
                                           // padding: EdgeInsets.all(4),
                                            child: CachedNetworkImage(imageUrl:snapshot.data.data[index].image,height: 70,width: 70,fit: BoxFit.fill,
                                              errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',width: 70,height: 70,),
                                              placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: 70, width: 70,),
                                            ),
                                          ),

                                        ),
                                      ),



                                      Expanded(
                                        child: Container(
                                          //color: AppTheme.primarydark,
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(left:5,right: 5,top:4),
                                          width: 100,
                                          child: Text(snapshot.data.data[index].title,style: AppTheme.subtitleopensans.copyWith(fontSize: 12,color: AppTheme.black,fontWeight: FontWeight.w600),textAlign: TextAlign.center,maxLines: 3, ),

                                        ),
                                      ),


                                    ]
                                ),
                              ),

                            ),
                          );
                        },
                      );
                    }),
              ),

            ],
          );


        }  else {
          return  const SizedBox(
            height: 25.0,
            width: 25.0,

          );
        }
      },
    );


  }











}



