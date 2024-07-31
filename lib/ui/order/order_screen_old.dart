import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

          return ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap : true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.data.length,

              itemBuilder: (context,index){
                return InkWell(

                  onTap: (){




                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10),

                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        color: Colors.white,
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


                      child:Column(
                        children: [

                          Container(
                           // padding: EdgeInsets.all(5),

                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>[



                                  Row(
                                    children: [
                                      Container(
                                       // padding: EdgeInsets.all(4),
                                        alignment: Alignment.centerLeft,
                                        child: Text("Order No : "+snapshot.data.data[index].orderCode,style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500),),
                                      ),

                                      Expanded(
                                        child:Container(
                                          padding: EdgeInsets.all(4),
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [

                                              (snapshot.data.data[index].totalPrice!=null || snapshot.data.data[index].totalTnaPrice!=null )?  Text("\₹"+Utils.currencyText((double.parse(snapshot.data.data[index].totalPrice)+double.parse(snapshot.data.data[index].totalTnaPrice)).toString()),style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 16,color: AppTheme.primary),):SizedBox.shrink(),

                                              //(snapshot.data.data[index].totalPrice!=null && snapshot.data.data[index].totalPrice.toString()!="0")? Text("\₹"+Utils.currencyText(snapshot.data.data[index].totalPrice),style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 16,color: AppTheme.primary),):SizedBox.shrink(),

                                              //(snapshot.data.data[index].totalTnaPrice!=null && snapshot.data.data[index].totalTnaPrice.toString()!="0")? Text("\₹"+Utils.currencyText(snapshot.data.data[index].totalTnaPrice),style: AppTheme.subtitlerubicSemi.copyWith(fontSize: 16,color: AppTheme.primary),):SizedBox.shrink(),

                                            ],
                                          )
                                        ),
                                      ),

                                    ],
                                  ),




                                  Row(
                                    children: [

                                      Text(Utils().getsheduletime(snapshot.data.data[index].createdAt),style: AppTheme.subtitle.copyWith(fontSize: 12),),
                                      //SizedBox(width: 10,),
                                      Text("  |  ",style: AppTheme.subtitle,),
                                      //SizedBox(width: 10,),

                                      Text(snapshot.data.data[index].city+","+snapshot.data.data[index].state+","+snapshot.data.data[index].country,style: AppTheme.subtitle.copyWith(fontSize: 12,color: AppTheme.black),),


                                      Expanded(
                                        child: Container(
                                         // child: getstatas(snapshot.data.data[index].status),
                                        ),
                                      ),


                                      getstatas(snapshot.data.data[index].status),

                                    ],
                                  ),

                                ]),
                          ),





                          Row(
                            children: [

                              Container(
                                //margin: EdgeInsets.only(left: 15),
                                padding: EdgeInsets.all(0),
                                child: MaterialButton(
                                  color: AppTheme.primary,

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                      side: BorderSide(color: AppTheme.primary, width: 1.0,)),
                                  onPressed: () {


                                    PageTransition.createRoutedata(context,"OrderDetailsScreen",snapshot.data.data[index]);


                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text("Order Details",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontWeight: FontWeight.w500) ,textAlign: TextAlign.right,)
                                  ),

                                ),
                              ),





                              (snapshot.data.data[index].status!="" && snapshot.data.data[index].status!="0")? Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: (){

                                    deleteOrder(snapshot.data.data[index].id.toString());

                                   // callApi();


                                  },
                                  child: Image.asset('assets/images/cart_delete.png',height: 35,),
                                ),
                              ):SizedBox.shrink(),




                            ],
                          ),



                        ],
                      )



                  ),
                );
              });

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
        decoration: BoxDecoration(
            //border: Border.all(color: AppTheme.white, width: 1,),
            borderRadius: BorderRadius.circular(15.0),
          color: AppTheme.pending,
        ),
        padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
        alignment: Alignment.center,
        child: Text("Pending",style: AppTheme.subtitle.copyWith(fontSize: 13),),
      );


    }else if(status=="1"){
      return  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppTheme.green,
        ),
        padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),

        //color: AppTheme.green,
        //padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Text("Delivered",style: AppTheme.subtitle.copyWith(fontSize: 13),),
      );

    }else{

      return  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppTheme.cancle,
        ),
        padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
        //color: AppTheme.gray_300,
        //padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Text("Cancel",style: AppTheme.subtitle.copyWith(fontSize: 13),),
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



