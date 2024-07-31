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
import '../../utils/my_colors.dart';
import '../widget/common_error.dart';
import '../widget/common_loading.dart';


class OrderDetailsScreen extends StatefulWidget {


  final String orderId;

  const OrderDetailsScreen({Key key, this.orderId}) : super(key: key);

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

    _bloc.getOrderDetails(false,widget.orderId);

  }



  @override
  Widget build(BuildContext context) {

    LogCustom.logd("xxxxxxxxxx  home page build");

    return CommonScaffold(
      onFlatButtonPressed: (){
        setState(() {

        });
      },
      appTitle: "Order Details",
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
                return  newArival1() ;
              }
            },
          ),




        ),
    );


  }











Widget newArival1() {
    return StreamBuilder(

      stream: _bloc.subjectOrderDetails.stream,
      builder: (context, AsyncSnapshot<OrderDetailsResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {

          return Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(16) ,

              child: Column(
                children: [


                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8,right: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(children: [
                                  TextSpan(
                                      style: TextStyle(
                                          color: black_354356,
                                          fontFamily: AppTheme.poppinsRegular,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 13,
                                          height: 1.2),
                                      text: "Order No :  " ),
                                  TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.black_text_dark,
                                          fontFamily: AppTheme.poppinsRegular,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 15,
                                          height: 1.5),
                                      text: snapshot.data.data.orderCode
                                  )])),

                            // Container(
                            //   // padding: EdgeInsets.all(4),
                            //   alignment: Alignment.centerLeft,
                            //   child: Text("Order No : "+widget.orderData.orderCode,style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500),),
                            // ),

                            SizedBox(
                              height: 12,
                            ),



                            bannerBuild(snapshot.data.data),




                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(top: 12),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    style: TextStyle(
                                        color: black_354356,
                                        fontFamily: AppTheme.poppinsRegular,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        height: 1.2),
                                    text: "Total :   "),
                                TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.primarydark,
                                        fontFamily: AppTheme.poppinsRegular,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                        height: 1.5),
                                    text:  "\₹"+Utils.currencyText(snapshot.data.data.totalPrice)
                                )])),

                          // Text("Total : ",style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.black),),
                          // Text("\₹"+Utils.currencyText(_bloc.grandtotal.toString()),style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.primary),),

                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2, bottom: 12),
                    alignment: Alignment.centerRight,
                    child:

                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              style: TextStyle(
                                  color: black_354356,
                                  fontFamily: AppTheme.poppinsRegular,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  height: 1.2),
                              text: "TNA Total:   "),
                          TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primarydark,
                                  fontFamily: AppTheme.poppinsRegular,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  height: 1.5),
                              text:  "\₹"+Utils.currencyText(snapshot.data.data.totalTnaPrice)
                          )])),

                  ),

                  //
                  // Container(
                  //    padding: EdgeInsets.all(4),
                  //   alignment: Alignment.centerRight,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //
                  //       Text("Total : ",style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.black),),
                  //       Text("\₹"+Utils.currencyText(widget.orderData.totalPrice),style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.primary),),
                  //
                  //     ],
                  //   )
                  // ),
                  //
                  // Divider(color: AppTheme.gray_400,),
                  //
                  // Container(
                  //   padding: EdgeInsets.all(4),
                  //   alignment: Alignment.centerRight,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text("TNA Total : ",style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.black),),
                  //
                  //       Text("\₹"+Utils.currencyText(widget.orderData.totalTnaPrice),style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.primary),),
                  //
                  //     ],
                  //   )
                  // ),


                  SizedBox(height: 5,),


                  // SafeArea(
                  //     top: false,
                  //     child: Row(
                  //       children: [
                  //
                  //         Expanded(
                  //             child: Container(
                  //
                  //               margin: EdgeInsets.only(left: 50, right: 50),
                  //               height: 40,
                  //               decoration: BoxDecoration(
                  //                 // color: AppTheme.primary,
                  //                 borderRadius: const BorderRadius.all(Radius.circular(1.0)),
                  //
                  //               ),
                  //               //color: AppTheme.white,
                  //               padding: EdgeInsets.all(0),
                  //               child: MaterialButton(
                  //                 color: AppTheme.black_grey,
                  //
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(1),
                  //                     side: BorderSide(color: AppTheme.black_grey, width: 1.0,)),
                  //                 onPressed: () {
                  //
                  //                   //addtocart();
                  //                   placeOrder(snapshot.data.data);
                  //
                  //                 },
                  //                 child: Container(
                  //                   alignment: Alignment.center,
                  //
                  //                   child: Row(
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     children: [
                  //
                  //                       Text("Repeat Order",style: AppTheme.subtitleopensans.copyWith(color: AppTheme.white,fontWeight: FontWeight.w200,fontSize: 14) ,textAlign: TextAlign.right,)
                  //                     ],
                  //                   ),
                  //                 ),
                  //
                  //               ),
                  //             )),
                  //
                  //       ],
                  //     )),


                  SizedBox(height: 10,),


                ],
              )
          );

        }else if (snapshot.hasError ) {
          return Center(child: CommonError(error:snapshot.error));
        }  else {
          return  Center(child: CommonLoading());
        }
      },
    );
  }


// Widget newArival(){
//
//
//   return SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//
//       children: [
//
//         RichText(
//             textAlign: TextAlign.left,
//             text: TextSpan(children: [
//               TextSpan(
//                   style: TextStyle(
//                       color: black_354356,
//                       fontFamily: AppTheme.poppinsRegular,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 13,
//                       height: 1.2),
//                   text: "Order No :  " ),
//               TextSpan(
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: AppTheme.black_text_dark,
//                       fontFamily: AppTheme.poppinsRegular,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 15,
//                       height: 1.5),
//                   text: widget.orderData.orderCode
//               )])),
//
//         // Container(
//         //   // padding: EdgeInsets.all(4),
//         //   alignment: Alignment.centerLeft,
//         //   child: Text("Order No : "+widget.orderData.orderCode,style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500),),
//         // ),
//
//         SizedBox(
//           height: 12,
//         ),
//
//
//
//         bannerBuild(),
//
//
//
//
//       ],
//     ),
//   );
//
// }



  Widget bannerBuild(OrderData orderData) {
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap : true,
        scrollDirection: Axis.vertical,
        itemCount: orderData.orderDetail.length,

        itemBuilder: (context,index){
          return Container(

              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                border: Border.all(color: AppTheme.off_White, width: 0.5,),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start
                ,children: [


                  Stack(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(2), topRight: Radius.circular(2), bottomLeft: Radius.circular(2), bottomRight:  Radius.circular(2) ),
                        child: CachedNetworkImage(imageUrl:orderData.orderDetail[index].imageName,fit: BoxFit.contain,height: 80,width: 80,
                          errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',height: 80,width: 80,),
                          placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: 80,width: 80,),
                        ),
                      ),

                      (orderData.orderDetail[index].tna=="1")? Positioned(
                        left: 5,
                        top: 5,
                        child: Image.asset('assets/images/tna_icon.png',height: 25,),
                      ):SizedBox.shrink(),

                    ],
                  ),




                  Expanded(child: Container(
                    padding: EdgeInsets.only(left: 12),

                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                      Text(orderData.orderDetail[index].productTitle,style: AppTheme.subtitleopensans.copyWith(fontSize: 11,fontWeight: FontWeight.w100, color: AppTheme.black_text),),

                      SizedBox(height: 4,),

                      Text("\₹"+Utils.currencyText(orderData.orderDetail[index].price),style: AppTheme.subtitleopensanssemibold.copyWith(fontSize:15,color: AppTheme.black_text_dark,fontWeight: FontWeight.w600)),



                      SizedBox(
                        height: 2,
                      ),



                      (orderData.orderDetail[index].quantityType!=null && orderData.orderDetail[index].quantityType.length!=0)? StaggeredGridView.countBuilder(
                          physics:const NeverScrollableScrollPhysics(),
                          shrinkWrap : true,
                          scrollDirection: Axis.vertical,
                          //padding:const EdgeInsets.all(0),
                          // padding: const EdgeInsets.only(left:4,right: 4,top: 0,bottom: 15),
                          itemCount: orderData.orderDetail[index].quantityType.length,
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



                                    Text("Box:"+orderData.orderDetail[index].quantityType[index2].type,style: AppTheme.subtitleopensans.copyWith(fontWeight: FontWeight.w100, color: AppTheme.medium_text_color, fontSize: 10),),


                                    Text(" - Qty:"+orderData.orderDetail[index].quantityType[index2].value,style: AppTheme.subtitleopensans.copyWith(fontWeight: FontWeight.w100, color: AppTheme.hint_txt_798281, fontSize: 10),),


                                  ],
                                ),


                              ],
                            );

                          }):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text("Box: ",style: AppTheme.subtitleopensans.copyWith(fontWeight: FontWeight.w100,color: AppTheme.medium_text_color, fontSize: 10),),



                          Text(orderData.orderDetail[index].quantity,style: AppTheme.subtitleopensans.copyWith(fontWeight: FontWeight.w600,color: AppTheme.hint_txt_798281, fontSize: 12),),

                          SizedBox(width: 2,),
                          Text("Qty ",style: AppTheme.subtitleopensans.copyWith(fontWeight: FontWeight.w300,color: AppTheme.hint_txt_798281, fontSize: 10),),

                        ],
                      ),



                      // SizedBox(
                      //   height: 5,
                      // ),


                      // Container(
                      //   //padding: EdgeInsets.all(5),
                      //   alignment: Alignment.centerLeft,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //
                      //       Text("Total : ",style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontWeight: FontWeight.w500),),
                      //       Text("\₹"+Utils.currencyText(widget.orderData.orderDetail[index].price),style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontWeight: FontWeight.w500),),
                      //     ],
                      //   ),
                      //
                      // ),




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






  addtocart(OrderData orderData)async{

    final database = cart_database.openDB();

    orderData.orderDetail.forEach((element) async{

     await cart_database.insertOrderData(element,database);

    });


    List<CartConstants> db=await cart_database.cart(database);




    Constant.count=db.length;
    setState(() {
    });


  }





  placeOrder(OrderData orderData)async{


    Pr.show(context);

    Map parms=new Map<String,dynamic>();

    parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());


    List<Map> productlist= [];



    for (int i=0 ;i<orderData.orderDetail.length;i++){


      Map product=new Map<String,String>();



    //  parms.putIfAbsent("product["+i.toString()+"][id]", () => orderData.orderDetail[i].product_id);


      product.putIfAbsent("id", () => orderData.orderDetail[i].productId);



      if(orderData.orderDetail[i].quantityType!=null && orderData.orderDetail[i].quantityType.length!=0){

        int qnty=0;
        List<String> size=[];

        for(int j=0;j<orderData.orderDetail[i].quantityType.length;j++){

          qnty=int.parse(orderData.orderDetail[i].quantityType[j].value)+qnty;
          size.add(orderData.orderDetail[i].quantityType[j].type+":"+orderData.orderDetail[i].quantityType[j].value);

        }

      //  parms.putIfAbsent("product["+i.toString()+"][quantity]", () => qnty.toString());

      //  parms.putIfAbsent("product["+i.toString()+"][quantity_type]", () => size.toString().replaceAll('[', '').replaceAll(']',''));



        product.putIfAbsent("quantity", () => qnty.toString());
        product.putIfAbsent("quantity_type", () => size.toString().replaceAll('[', '').replaceAll(']',''));


      }else{

       // parms.putIfAbsent("product["+i.toString()+"][quantity]", () => orderData.orderDetail[i].quantity);
        //parms.putIfAbsent("product["+i.toString()+"][quantity_type]", () => "N/A");


        product.putIfAbsent("quantity", () => orderData.orderDetail[i].quantity);
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



