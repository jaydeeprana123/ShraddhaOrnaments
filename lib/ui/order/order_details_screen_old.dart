import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/CartConstants.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/orderlist/order_list_response.dart';
import 'package:shradha_design/response/placeorder/place_order_response.dart';
import 'package:shradha_design/ui/home/main_page.dart';
import 'package:shradha_design/ui/order/OrderBloc.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/ui/widget/snack.dart';
import 'package:shradha_design/utils/utils.dart';
import 'package:shradha_design/utils/cart_db.dart' as cart_database;

import '../../response/orderlist/order_details_response.dart';


class OrderDetailsScreen extends StatefulWidget {


  final OrderData orderData;

  const OrderDetailsScreen({Key key, this.orderData}) : super(key: key);

  @override
  OrderDetailsScreenState createState() {
    return OrderDetailsScreenState();
  }
}



class OrderDetailsScreenState extends State<OrderDetailsScreen>  with TickerProviderStateMixin  {

  final database = cart_database.openDB();


  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();

  AnimationController _animationController;
   OrderBloc _bloc ;//= HomeBloc();


//  List<String> data=["","","","",""];


  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }








  @override
  void initState() {

    LogCustom.logd("xxxxxxxxxx  home page initState");


    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

          _bloc = OrderBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );


    callApi();






    super.initState();



  }






  void callApi(){

  //  _bloc.getOrder(false);

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
          body: FutureBuilder<bool>(
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


                        Expanded(
                          child: newArival(),
                        ),





                        Container(
                           padding: EdgeInsets.all(4),
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Text("Total : ",style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.black),),
                              Text("\₹"+Utils.currencyText(widget.orderData.totalPrice),style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.primary),),

                            ],
                          )
                        ),

                        Divider(color: AppTheme.gray_400,),

                        Container(
                          padding: EdgeInsets.all(4),
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("TNA Total : ",style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.black),),

                              Text("\₹"+Utils.currencyText(widget.orderData.totalTnaPrice),style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.primary),),

                            ],
                          )
                        ),


                        SizedBox(height: 5,),


                        SafeArea(
                            top: false,
                            child: Row(
                          children: [

                            Expanded(
                                child: Container(

                                  height: 45,
                                  decoration: BoxDecoration(
                                    // color: AppTheme.primary,
                                    borderRadius: const BorderRadius.all(Radius.circular(1.0)),

                                  ),
                                  //color: AppTheme.white,
                                  padding: EdgeInsets.all(0),
                                  child: MaterialButton(
                                    color: AppTheme.primary,

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        side: BorderSide(color: AppTheme.primary, width: 1.0,)),
                                    onPressed: () {

                                      //addtocart();
                                      placeOrder();

                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text("Repeat Order",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontWeight: FontWeight.w500,fontSize: 16) ,textAlign: TextAlign.right,)
                                        ],
                                      ),
                                    ),

                                  ),
                                )),

                          ],
                        )),


                        SizedBox(height: 10,),


                      ],
                    )
                ) ;
              }
            },
          ),




        ),
    );


  }












Widget newArival(){


  return SingleChildScrollView(
    child: Column(

      children: [

        SizedBox(
          height: 10,
        ),

        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your Order",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

              Image.asset('assets/images/home_line.png',height: 10,),

            ],
          ),
        ),

        SizedBox(
          height: 10,
        ),



        Container(
          // padding: EdgeInsets.all(4),
          alignment: Alignment.centerLeft,
          child: Text("Order No : "+widget.orderData.orderCode,style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500),),
        ),

        SizedBox(
          height: 5,
        ),



        bannerBuild(),




      ],
    ),
  );

}



  Widget bannerBuild() {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap : true,
        scrollDirection: Axis.vertical,
        itemCount: widget.orderData.orderDetail.length,

        itemBuilder: (context,index){
          return Container(

              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
               // color: Colors.white,
                color: (widget.orderData.orderDetail[index].tna=="0")?Colors.white:AppTheme.primaryblur,
                border: Border.all(color: AppTheme.gray_300, width: 1,),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: AppTheme.gray_300, offset: const Offset(1, 1), blurRadius: 2,),
                ],

              ),

             /* decoration: BoxDecoration(
                  color: AppTheme.white,
                  border: Border.all(
                    color: AppTheme.gray_400,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4.0)
              ),
*/


              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Stack(
                    children: [

                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(0)),
                          color: Colors.white,
                          border: Border.all(color: AppTheme.gray_300, width: 1,),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: AppTheme.gray_300, offset: const Offset(1, 1), blurRadius: 2,),
                          ],

                        ),

                        child: CachedNetworkImage(imageUrl:widget.orderData.orderDetail[index].imageName,fit: BoxFit.contain,height: 70,width: 70,
                          errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',height: 70,width: 70,),
                          placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: 70,width: 70,),
                        ),
                      ),

                      (widget.orderData.orderDetail[index].tna=="1")? Positioned(
                        left: 5,
                        top: 5,
                        child: Image.asset('assets/images/tna_icon.png',height: 25,),
                      ):SizedBox.shrink(),

                    ],
                  ),




                  Expanded(child: Container(
                    padding: EdgeInsets.all(5),

                    child: Column(children: <Widget>[


                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.orderData.orderDetail[index].productTitle,style: AppTheme.subtitle.copyWith(fontSize: 15,fontWeight: FontWeight.w500),),
                      ),


                      SizedBox(
                        height: 5,
                      ),



                      (widget.orderData.orderDetail[index].quantityType!=null && widget.orderData.orderDetail[index].quantityType.length!=0)? StaggeredGridView.countBuilder(
                          physics:const NeverScrollableScrollPhysics(),
                          shrinkWrap : true,
                          scrollDirection: Axis.vertical,
                          //padding:const EdgeInsets.all(0),
                          // padding: const EdgeInsets.only(left:4,right: 4,top: 0,bottom: 15),
                          itemCount: widget.orderData.orderDetail[index].quantityType.length,
                          crossAxisCount: 6,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          padding: EdgeInsets.all(0),
                          staggeredTileBuilder: (index2) => new StaggeredTile.fit((3)),
                          itemBuilder: (context,index2){


                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [



                                    Text("Box:"+widget.orderData.orderDetail[index].quantityType[index2].type,style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.w500),),


                                    Text(" - Qty:"+widget.orderData.orderDetail[index].quantityType[index2].value,style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.w500),),


                                  ],
                                ),


                              ],
                            );

                          }):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [



                          Text("Box:",style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.w500),),


                          Text("Qty "+widget.orderData.orderDetail[index].quantity,style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.w500),),


                        ],
                      ),



                      SizedBox(
                        height: 5,
                      ),


                      Container(
                        //padding: EdgeInsets.all(5),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Total : ",style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontWeight: FontWeight.w500),),
                            Text("\₹"+Utils.currencyText(widget.orderData.orderDetail[index].price),style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontWeight: FontWeight.w500),),
                          ],
                        ),

                      ),




                    ]),
                  )),


                ],
              )



          );


        });
  }













  void callSerachApi(String msg){
     // _bloc.getSearch(msg);
  }






  addtocart()async{

    final database = cart_database.openDB();

    widget.orderData.orderDetail.forEach((element) async{

     await cart_database.insertOrderData(element,database);

    });


    List<CartConstants> db=await cart_database.cart(database);




    Constant.count=db.length;
    setState(() {
    });


  }





  placeOrder()async{


    Pr.show(context);

    Map parms=new Map<String,dynamic>();

    parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());


    List<Map> productlist= [];



    for (int i=0 ;i<widget.orderData.orderDetail.length;i++){


      Map product=new Map<String,String>();



    //  parms.putIfAbsent("product["+i.toString()+"][id]", () => widget.orderData.orderDetail[i].product_id);


      product.putIfAbsent("id", () => widget.orderData.orderDetail[i].productId);



      if(widget.orderData.orderDetail[i].quantityType!=null && widget.orderData.orderDetail[i].quantityType.length!=0){

        int qnty=0;
        List<String> size=[];

        for(int j=0;j<widget.orderData.orderDetail[i].quantityType.length;j++){

          qnty=int.parse(widget.orderData.orderDetail[i].quantityType[j].value)+qnty;
          size.add(widget.orderData.orderDetail[i].quantityType[j].type+":"+widget.orderData.orderDetail[i].quantityType[j].value);

        }

      //  parms.putIfAbsent("product["+i.toString()+"][quantity]", () => qnty.toString());

      //  parms.putIfAbsent("product["+i.toString()+"][quantity_type]", () => size.toString().replaceAll('[', '').replaceAll(']',''));



        product.putIfAbsent("quantity", () => qnty.toString());
        product.putIfAbsent("quantity_type", () => size.toString().replaceAll('[', '').replaceAll(']',''));


      }else{

       // parms.putIfAbsent("product["+i.toString()+"][quantity]", () => widget.orderData.orderDetail[i].quantity);
        //parms.putIfAbsent("product["+i.toString()+"][quantity_type]", () => "N/A");


        product.putIfAbsent("quantity", () => widget.orderData.orderDetail[i].quantity);
        product.putIfAbsent("quantity_type", () => "N/A");


      }



      productlist.add(product);


    }


    parms.putIfAbsent("product", () => productlist);

    LogCustom.logd("xxxxxx :: "+parms.toString());


    PlaceOrderResponse placeOrder=await _bloc.placeOrder(false, parms);

    Pr.hide(context);


    if(placeOrder!=null ){

      Snack.showS(context,placeOrder.message);

      if(placeOrder.statusCode==Constant.API_CODE){

        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);
      }

    }




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



