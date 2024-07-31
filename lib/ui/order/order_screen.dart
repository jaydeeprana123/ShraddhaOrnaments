import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/orderlist/order_list_response.dart';
import 'package:shradha_design/ui/order/OrderBloc.dart';
import 'package:shradha_design/ui/widget/common_error.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/utils/page_transition.dart';
import 'package:shradha_design/utils/utils.dart';

import '../../utils/my_colors.dart';


class OrderScreen extends StatefulWidget {
  @override
  OrderScreenState createState() {
    return OrderScreenState();
  }
}



class OrderScreenState extends State<OrderScreen>  with TickerProviderStateMixin  {



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

    _bloc.getOrder(false);

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
      appTitle: "Order List",
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

        // Center(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text("Your Order",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),
        //
        //       Image.asset('assets/images/home_line.png',height: 10,),
        //
        //     ],
        //   ),
        // ),

        // SizedBox(
        //   height: 10,
        // ),




        bannerBuild(),




      ],
    ),
  );

}



  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<OrderListResponse> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {

          return Container(
            padding: EdgeInsets.only(left: 8,right: 8),
            child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap : true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.data.length,

                itemBuilder: (context,index){
                  return InkWell(

                    onTap: (){
                      PageTransition.createRoutedata(context,"OrderDetailsScreen",snapshot.data.data[index].id.toString());
                    },
                    child: Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 16, top: 4),

                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          // color: Colors.white,
                          border: Border.all(color: AppTheme.light_grey, width: 0.5,),

                        ),

                        /* decoration: BoxDecoration(
                            color: AppTheme.white,
                            border: Border.all(
                              color: AppTheme.gray_400,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(4.0)
                        ),
*/


                        child:Column(
                          children: [

                            Container(
                             // padding: EdgeInsets.all(5),

                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: <Widget>[



                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start
                                      ,children: [

                                        Expanded(
                                          child: RichText(
                                              textAlign: TextAlign.left,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    style: TextStyle(
                                                        color: black_354356,
                                                        fontFamily: AppTheme.poppinsRegular,
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: 12,
                                                        height: 1.2),
                                                    text: "Order No : " ),
                                                TextSpan(
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: AppTheme.black_text_dark,
                                                        fontFamily: AppTheme.poppinsRegular,
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: 12,
                                                        height: 1.5),
                                                    text: snapshot.data.data[index].orderCode
                                                )])),
                                        ),


                                        getstatas(snapshot.data.data[index].status),


                                      ],
                                    ),

                                    SizedBox(height: 4,),

                                    (snapshot.data.data[index].totalPrice!=null || snapshot.data.data[index].totalTnaPrice!=null )?  Text("\₹"+Utils.currencyText((double.parse(snapshot.data.data[index].totalPrice)+double.parse(snapshot.data.data[index].totalTnaPrice)).toString()),style: AppTheme.subtitleopensans.copyWith(fontSize: 16,color: AppTheme.black_text_dark, fontWeight: FontWeight.w600),):SizedBox.shrink(),

                                    SizedBox(height: 4,),


                                    Row(
                                      children: [

                                        Text(Utils().getsheduletime(snapshot.data.data[index].createdAt),style: AppTheme.subtitleopensans.copyWith(fontSize: 11, color: AppTheme.medium_text_color),),
                                        //SizedBox(width: 10,),
                                        Text("  |  ",style: AppTheme.subtitle,),
                                        //SizedBox(width: 10,),

                                        Text(snapshot.data.data[index].city+", "+snapshot.data.data[index].state+", "+snapshot.data.data[index].country,style: AppTheme.subtitleopensans.copyWith(fontSize: 12,color: AppTheme.black_text, fontWeight: FontWeight.w600),),


                                        Expanded(
                                          child: Container(
                                           // child: getstatas(snapshot.data.data[index].status),
                                          ),
                                        ),


                                     

                                      ],
                                    ),

                                  ]),
                            ),

                            Container(

                              child: Row(
                                children: [

                                  // Container(
                                  //   padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                                  //     decoration: BoxDecoration(
                                  //       border: Border.all(color: AppTheme.black_grey, width: 0.5,),
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //       // color: AppTheme.black_grey,
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //     child: Row(
                                  //       children: [
                                  //
                                  //         SvgPicture.asset('assets/images/delete.svg',height: 13,),
                                  //
                                  //         SizedBox(width: 4,),
                                  //
                                  //         Text("Cancel Order",style: AppTheme.subtitleopensans.copyWith(color: AppTheme.black_grey,fontWeight: FontWeight.w700, fontSize: 11) ,textAlign: TextAlign.right,),
                                  //       ],
                                  //     )
                                  // ),




                                  (snapshot.data.data[index].status!="" && snapshot.data.data[index].status!="0")? Container(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: (){

                                        deleteOrder(snapshot.data.data[index].id.toString());

                                       // callApi();


                                      },
                                      child:   Container(
                                          margin: EdgeInsets.only(top: 12),
                                          padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppTheme.black_grey, width: 0.5,),
                                            borderRadius: BorderRadius.circular(8.0),
                                            // color: AppTheme.black_grey,
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: [

                                              SvgPicture.asset('assets/images/delete.svg',height: 13,),

                                              SizedBox(width: 4,),

                                              Text("Cancel Order",style: AppTheme.subtitleopensans.copyWith(color: AppTheme.black_grey,fontWeight: FontWeight.w700, fontSize: 11) ,textAlign: TextAlign.right,),
                                            ],
                                          )
                                      ),
                                    ),
                                  ):SizedBox.shrink(),




                                ],
                              ),
                            ),



                          ],
                        )



                    ),
                  );
                }),
          );

        }else if (snapshot.hasError ) {
          return CommonError(error:snapshot.error);
        }  else {
          return  CommonLoading();
        }
      },
    );
  }






 Widget getstatas(String status){


    if(status=="0"){

      return  Container(
        // decoration: BoxDecoration(
        //     border: Border.all(color: AppTheme.light_grey, width: 0.5,),
        //     borderRadius: BorderRadius.circular(4.0),
        //   color: AppTheme.pending,
        // ),
        alignment: Alignment.center,
        child: Text("Pending",style: AppTheme.subtitleopensans.copyWith(fontSize: 12, color: AppTheme.orange, fontWeight: FontWeight.w600),),
      );


    }else if(status=="1"){
      return  Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(4.0),
        //   color: AppTheme.green400,
        // ),
        // padding: EdgeInsets.only(left: 12,right: 12,top: 3,bottom: 3),

        //color: AppTheme.green,
        //padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Text("Delivered",style: AppTheme.subtitleopensans.copyWith(fontSize: 12, color: AppTheme.green400, fontWeight: FontWeight.w600),),
      );

    }else{

      return  Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(4.0),
        //   color: AppTheme.cancle,
        // ),
        // padding: EdgeInsets.only(left: 12,right: 12,top: 3,bottom: 3),
        //color: AppTheme.light_grey,
        //padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Text("Cancel",style: AppTheme.subtitleopensans.copyWith(fontSize: 12, color: AppTheme.white),),
      );

    }





  }





  Future<bool> deleteOrder(String orderId)async{



    await Pr.show(context);

    Map<String, String> parms = new Map<String,String>();
    //parms.putIfAbsent("user_id",()=> _bloc.apiProvider.pref.getUserId());
    parms.putIfAbsent("order_id",()=> orderId);

    await _bloc.deleteOrder(false,parms);


    callApi();

    await Pr.hide(context);


    return true;



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



