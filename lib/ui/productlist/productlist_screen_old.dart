import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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


class ProductListScreen extends StatefulWidget {

  final String catId;


  const ProductListScreen({Key key, this.catId}) : super(key: key);


  @override
  ProductListScreenState createState() {
    return ProductListScreenState();
  }
}



class ProductListScreenState extends State<ProductListScreen>  with TickerProviderStateMixin  {



  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;
  ProductListBloc _bloc ;//= HomeBloc();




  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }








  @override
  void initState() {

    LogCustom.logd("xxxxxxxxxx  home page initState");


    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

          _bloc = ProductListBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );


    callApi();






    super.initState();



  }






  void callApi(){



    Map parms=new Map<String,String>();

    parms.putIfAbsent("id", () => widget.catId.toString());





    if(selectedSortBy==4){

      _bloc.getProductList(false, parms,Api.category_new_products);

    }else{
      parms.addAll(getFilter());
      _bloc.getProductList(false, parms,Api.category_products);

    }

  }



  @override
  Widget build(BuildContext context) {

    LogCustom.logd("xxxxxxxxxx  home page build");

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


      bannerBuild(),




    ],
  );

}





  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<ProductListResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null &&  snapshot.data.data != null &&  snapshot.data.data.length != 0) {


          return Column(

            children: [


              Stack(
                children: [





                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Product List",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

                        Image.asset('assets/images/home_line.png',height: 10,),

                      ],
                    ),
                  ),



                  Positioned(
                      right: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 5,right: 5 ),
                        //width: 100,
                        alignment: Alignment.topRight,
                        //color: AppTheme.white,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(1)),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppTheme.gray_300,
                              offset: const Offset(1, 1),
                              blurRadius: 2,

                            ),

                          ],

                        ),

                        child: InkWell(
                          onTap: (){

                            sortbyView();

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Image.asset('assets/images/filter.png',height: 20,),
                              SizedBox(width: 5,),
                              Text("Sort By",style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black_text,fontSize: 12)  ,),
                            ],
                          ),
                        ),
                      )
                  ),




                ],
              ),


              SizedBox(
                height: 10,
              ),


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

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId:_bloc.subject.value.data[index].id.toString() ,)),);

                      },
                      child: Stack(
                        children: [

                          Container(
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
                            right: 3,
                            top: 3,
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
                              child: Image.asset((_bloc.subject.value.data[index].wishlist==Constant.isWishlist)?'assets/images/like_active.png':'assets/images/like.png',height: 32,),
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




  addremoveWishlist(bool isAdd,String productId)async{



    await Pr.show(context);

    Map<String, String> parms = new Map<String,String>();
    parms.putIfAbsent("user_id",()=> _bloc.apiProvider.pref.getUserId());
    parms.putIfAbsent("product_id",()=> productId);

    await _bloc.addremoveWhislist(isAdd,parms);

    await Pr.hide(context);

    setState(() {});




  }







  void callSerachApi(String msg){
     // _bloc.getSearch(msg);
  }








  int selectedSortBy=4;


  sortbyView(){

    int selectedSortByTemp;

    selectedSortByTemp=selectedSortBy;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 4,
      context: context,

      builder: (context) {


        return StatefulBuilder(

          builder: (context, state) {

            return Container(
                color: Colors.transparent,
                height: 345,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),

                  child: Container(
                    color: AppTheme.primary,
                    child: Column(

                      children: <Widget>[

                        const SizedBox(
                          height: 8,
                        ),


                        Center(
                          child: Text("Sort By" ,style: TextStyle(color: AppTheme.white,fontSize: 18),
                          ),
                        ),


                        Divider(color: AppTheme.nearlyWhite,),



                        Container(
                          margin: EdgeInsets.all(8),
                          child: Column(
                            children: [

                              Row(
                                children: [

                                  Expanded(child: InkWell(
                                    onTap: (){
                                      state(() {
                                        selectedSortByTemp=4;
                                        // _selectedSortBy = "lowPrice";
                                      });
                                    },
                                    child: Text("Newest First",style: TextStyle(fontSize: 14,color: AppTheme.white,),),
                                  )),



                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,

                                    child: Radio(
                                      value: 4,
                                      activeColor: AppTheme.white,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {

                                        state(() {

                                          selectedSortByTemp=4;

                                        });

                                      },
                                    ),
                                  ),

                                ],
                              ),



                              Divider(),


                              Row(
                                children: [




                                  Expanded(child: InkWell(
                                    onTap: (){
                                      state(() {
                                        selectedSortByTemp=0;
                                        // _selectedSortBy = "lowPrice";
                                      });
                                    },
                                    child: Text("Name: A TO Z",style: TextStyle(fontSize: 14,color: AppTheme.white,),),
                                  )),

                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,

                                    child: Radio(
                                      value: 0,
                                      activeColor: AppTheme.white,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {

                                        state(() {

                                          selectedSortByTemp=0;

                                        });

                                      },
                                    ),
                                  ),

                                ],
                              ),



                              Divider(),


                              Row(
                                children: [

                                  Expanded(child: InkWell(
                                    onTap: (){
                                      state(() {
                                        selectedSortByTemp=1;

                                      });
                                    },
                                    child: Text("Name: Z TO A",style: TextStyle(fontSize: 14,color: AppTheme.white,),),
                                  )),

                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,

                                    child: Radio(
                                      value: 1,
                                      activeColor: AppTheme.white,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {

                                        state(() {

                                          selectedSortByTemp=1;

                                        });

                                      },
                                    ),
                                  ),

                                ],
                              ),


                              Divider(),


                              Row(
                                children: [

                                  Expanded(child: InkWell(
                                    onTap: (){
                                      state(() {
                                        selectedSortByTemp=2;

                                      });
                                    },
                                    child: Text("Price: HIGH TO LOW",style: TextStyle(fontSize: 14,color: AppTheme.white,),),
                                  )),

                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,

                                    child: Radio(
                                      value: 2,
                                      activeColor: AppTheme.white,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {

                                        state(() {

                                          selectedSortByTemp=2;

                                        });

                                      },
                                    ),
                                  ),

                                ],
                              ),


                              Divider(),


                              Row(
                                children: [

                                  Expanded(child: InkWell(
                                    onTap: (){
                                      state(() {
                                        selectedSortByTemp=3;

                                      });
                                    },
                                    child: Text("Price: LOW TO HIGH",style: TextStyle(fontSize: 14,color: AppTheme.white,),),
                                  )),

                                  Container(
                                    height: 28,
                                    alignment: Alignment.topRight,

                                    child: Radio(
                                      value: 3,
                                      activeColor: AppTheme.white,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selectedSortByTemp,
                                      onChanged: (int value) {

                                        state(() {

                                          selectedSortByTemp=3;

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

                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0, top: 4),
                              child: Container(
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
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
                                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {

                                      Navigator.pop(context);

                                    },
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: AppTheme.primarydark),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),

                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0, top: 4),
                              child: Container(
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
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
                                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {


                                      if(selectedSortBy!=selectedSortByTemp){
                                        selectedSortBy=selectedSortByTemp;


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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: AppTheme.primarydark),
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
                )

            );

          },
        );



      }  ,
    );


  }




  Map getFilter(){

    Map parms=new Map<String,String>();






    if(selectedSortBy==4){

     // parms.putIfAbsent("column", () => "title");
     // parms.putIfAbsent("order", () => "asc");

    }else if(selectedSortBy==0){

      parms.putIfAbsent("column", () => "title");
      parms.putIfAbsent("order", () => "asc");

    }else  if(selectedSortBy==1){

      parms.putIfAbsent("column", () => "title");
      parms.putIfAbsent("order", () => "desc");

    }else  if(selectedSortBy==2){
      parms.putIfAbsent("column", () => "price");
      parms.putIfAbsent("order", () => "desc");


    }else  if(selectedSortBy==3){

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



