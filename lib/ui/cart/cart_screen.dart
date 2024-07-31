import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/CartConstants.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/placeorder/place_order_response.dart';
import 'package:shradha_design/ui/cart/CartListBloc.dart';
import 'package:shradha_design/ui/home/main_page.dart';
import 'package:shradha_design/ui/widget/common_loading.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/ui/widget/snack.dart';
import 'package:shradha_design/utils/my_icons.dart';
import 'package:shradha_design/utils/utils.dart';
import 'package:shradha_design/utils/validation.dart';

import '../../utils/my_colors.dart';


class CartScreen extends StatefulWidget {
  @override
  CartScreenState createState() {
    return CartScreenState();
  }
}


class CartScreenState extends State<CartScreen> with WidgetsBindingObserver {

  CartListBloc _bloc; //= HomeBloc();
  bool isPriceShow = false;

  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    LogCustom.logd("xxxxxxxxxx  home page initState");


    _bloc = CartListBloc(apiProvider: BlocProvider
        .of<AppBloc>(context)
        .appRepository
        .apiClient);


    _bloc.comentcontroller = new TextEditingController();

    if(_bloc.apiProvider.pref.getPriceToShow() == "1"){
      isPriceShow = true;
    }else{
      isPriceShow = false;
    }

    callApi();


    super.initState();
  }


  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        LogCustom.logd("xxxxxxxxx resume checkout");


        //loadingCallbck(true);
        callApi();


        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        LogCustom.logd("xxxxxxxxx resume mycart ::state" + state.toString());

        break;
    }

    LogCustom.logd("xxxxxxxxx resume mycart ::state" + state.toString());
  }


  void callApi() async {
    if (mounted) {
      await _bloc.getcartData();


      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    LogCustom.logd("xxxxxxxxxx  home page build");


    return CommonScaffold(
      //scaffoldKey: _scaffoldKey,
      appTitle: "My Cart",
      backGroundColor: AppTheme.bg,
      isCartRemove: true,
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
              return Container(
                //  height: screenHeight,

                // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                              children: [
                                bannerBuild(),

                                productTna(),


                                buttonView()


                              ],
                            )
                        ),
                      ),

                      Row(
                        children: [


                          Expanded(child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              // color: AppTheme.primary,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(4.0)),

                            ),
                            //color: AppTheme.white,
                            padding: EdgeInsets.all(0),
                            child: MaterialButton(
                              padding: EdgeInsets.all(0),

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: AppTheme.primary, width: 1.0,)),
                              onPressed: () {
                                placeOrder();
                              },
                              child: Container(
                                alignment: Alignment.center,

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    SvgPicture.asset(
                                        order,
                                        height: 18,
                                        color: AppTheme.primarydark

                                    ),

                                    SizedBox(width: 5,),

                                    Text("Place Order",
                                      style: AppTheme.subtitle.copyWith(
                                          fontSize: 14,
                                          color: AppTheme.primarydark,
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.right,)
                                  ],
                                ),
                              ),

                            ),
                          )),


                          SizedBox(
                            width: 12,
                          ),


                          Expanded(child: Container(
                            height: 45,

                            decoration: BoxDecoration(
                              // color: AppTheme.black_600,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(4.0)),

                            ),
                            //color: AppTheme.white,
                            padding: EdgeInsets.all(0),
                            child: MaterialButton(
                              padding: EdgeInsets.all(0),
                              color: AppTheme.black_800,

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: AppTheme.black_800, width: 1.0,)),

                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MainPage()),);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        shopping,
                                        height: 16,
                                        color: AppTheme.white

                                    ),

                                    SizedBox(width: 5,),
                                    Text("Continue Shopping",
                                        style: AppTheme.subtitle.copyWith(
                                            fontSize: 14,
                                            color: AppTheme.white,
                                            fontWeight: FontWeight.w300)),
                                  ],
                                ),
                              ),

                            ),
                          )),


                        ],
                      ),
                    ],
                  )

              );
            }
          },
        ),


      ),
    );
  }


  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<List<CartConstants>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return newArival(snapshot.data);
        }
        else if (snapshot.hasError) {
          double screenHeight = MediaQuery
              .of(context)
              .size
              .height - 250;

          return Center(
            child: Container(
              alignment: Alignment.center,
              height: screenHeight,
              child: Text(snapshot.error,
                style: TextStyle(fontSize: 22, color: AppTheme.gray_500),),),
          );
        } else {
          return CommonLoading();
        }
      },
    );
  }


  Widget buttonView() {
    return StreamBuilder(

      stream: _bloc.visibleButton.stream,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data != null && snapshot.data) {
          return Column(
            children: [


              Container(

                child: Container(
                  alignment: Alignment.topCenter,
                  height: 70,
                  padding: EdgeInsets.only(bottom: 4),
                  // color: AppTheme.edit_bg,

                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border.all(color: AppTheme.off_White, width: 1,),
                      borderRadius: BorderRadius.circular(2.0)
                  ),
                  child: TextFormField(
                    //key:UniqueKey(),
                    maxLength: 250,
                    style: AppTheme.subtitleopensans.copyWith(
                        fontSize: 13,
                        color: AppTheme.black_text_dark,
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 8, right: 8, top: 8, bottom: 8),
                      border: InputBorder.none,
                      hintText: 'Remarks (Optional) Maximum 250 Character',
                      hintStyle: AppTheme.subtitleopensans.copyWith(
                          fontSize: 13,
                          color: AppTheme.hint_txt_798281,
                          fontWeight: FontWeight.w400),
                      labelStyle: AppTheme.subtitleopensans.copyWith(
                          fontSize: 13,
                          color: AppTheme.black_text_dark,
                          fontWeight: FontWeight.w400),


                    ),


                    controller: _bloc.comentcontroller,
                    onFieldSubmitted: (term) {
                      // _cityFocus.unfocus();
                      //FocusScope.of(context).requestFocus(_stateFocus);
                    },

                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 3,

                  ),
                ),
              ),

            isPriceShow? Container(
                  margin: EdgeInsets.only(top: 12),
                  alignment: Alignment.centerRight,
                  child: RichText(
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
                            text: "\₹" + Utils.currencyText(
                                _bloc.grandtotal.toString())
                        )
                      ]))
              ):SizedBox(),
              isPriceShow? Container(
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
                          text: "\₹" + Utils.currencyText(_bloc.tnagrandtotal
                              .toString())
                      )
                    ])),

              ):SizedBox(),

              SizedBox(height: 5,),


            ],
          );
        }

        return SizedBox.shrink();
      },
    );
  }


  Widget newArival(List<CartConstants> data) {
    return Column(
      children: [

        Row(
          children: [
            Expanded(
              child: RichText(
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
                        text: "(" + data.length.toString() + ")")
                  ])),
            ),

            isPriceShow? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      style: TextStyle(
                          color: AppTheme.black_text_dark,
                          fontFamily: AppTheme.poppinsRegular,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          height: 1.2),
                      text: "Total  "),
                  TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primarydark,
                          fontFamily: AppTheme.poppinsRegular,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          height: 1.5),
                      text: "\₹" +
                          Utils.currencyText(_bloc.grandtotal.toString()))
                ])):SizedBox(),
          ],
        ),


        SizedBox(height: 12,),

        ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data.length,

            itemBuilder: (context, index) {
              String sizeType = "Pieces";

              if (data[index].boxtype != null) {
                List<String> saletype = data[index].boxtype.split(",");

                if (saletype.isNotEmpty) {
                  if (saletype.length == 2) {
                    sizeType = saletype[1];
                  } else {
                    sizeType = saletype[0];
                  }
                }
              }


              return InkWell(

                onTap: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: data[index].pid,)),);

                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                      border: Border.all(color: AppTheme.off_White, width: 1,),
                    ),


                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [

                                Container(
                                  margin: EdgeInsets.all(12),
                                  // padding: EdgeInsets.all(2),
                                  // decoration: BoxDecoration(
                                  //   borderRadius: const BorderRadius.all(Radius.circular(1)),
                                  //   color: Colors.white,
                                  //   border: Border.all(color: AppTheme.gray_300, width: 1,),
                                  //   boxShadow: <BoxShadow>[
                                  //     BoxShadow(color: AppTheme.gray_300, offset: const Offset(1, 1), blurRadius: 2,),
                                  //   ],
                                  //
                                  // ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        topRight: Radius.circular(2),
                                        bottomLeft: Radius.circular(2),
                                        bottomRight: Radius.circular(2)),
                                    child: CachedNetworkImage(
                                      imageUrl: data[index].image,
                                      fit: BoxFit.contain,
                                      height: 80,
                                      width: 80,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            'assets/images/no_image.jpg',
                                            height: 80, width: 80,),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                            'assets/images/loading_dots.gif',
                                            height: 80, width: 80,),
                                    ),
                                  ),
                                ),

                                (data[index].tna == "1") ? Positioned(
                                  left: 10,
                                  top: 10,
                                  child: Image.asset(
                                    'assets/images/tna_icon.png', height: 25,),
                                ) : SizedBox.shrink(),

                              ],
                            ),


                            Expanded(child: Container(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, right: 12),

                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(data[index].title,
                                      style: AppTheme.subtitleopensans.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w100,
                                          color: AppTheme.black_text),),

                                    SizedBox(height: 4,),

                                   isPriceShow? Text("\₹" + Utils.currencyText(
                                        getTotal(data[index])),
                                        style: AppTheme.subtitleopensanssemibold
                                            .copyWith(fontSize: 16,
                                            color: AppTheme.black_text_dark,
                                            fontWeight: FontWeight.w600)):SizedBox(),


                                    ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: data[index].sizeList.length,

                                        itemBuilder: (context, index2) {
                                          return Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [


                                          Container(
                                          margin: EdgeInsets.only(left:68,
                                              bottom: 4),
                                          child: Text("BOX",style: AppTheme.subtitle.copyWith(color: AppTheme.black_text,fontSize: 10,fontWeight: FontWeight.w100),)
                                          ,),


                                          Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [


                                          Container(
                                          child: (data[index].sizeList.length!=0)?Text(data[index].sizeList[index2].trimLeft().toUpperCase(),style: AppTheme.subtitle.copyWith(color: AppTheme.medium_text_color,fontSize: 11,fontWeight: FontWeight.w400),):Text("QTY : ",style: AppTheme.subtitle.copyWith(color: AppTheme.medium_text_color,fontSize: 12,fontWeight: FontWeight.w400),),
                                          ),


                                          SizedBox(width: 8,),

                                          Container(
                                          color: AppTheme.gray_300,
                                          child: Row(
                                          children: [

                                          InkWell(
                                          onTap: (){

                                          setState(() {
                                          data[index].boxcontroller[index2].text=Utils.currencyText((double.parse(data[index].boxcontroller[index2].text)+1).toString());

                                          data[index].qty[index2]=data[index].boxcontroller[index2].text.toString();
                                          _bloc.updateqty(data[index].pid, data[index].qty.toString());

                                          });

                                          },
                                          child: Container(
                                          height: 28,
                                          padding: EdgeInsets.only(left: 4, right: 4),
                                          color: AppTheme.gray_300,
                                          child: Icon(Icons.add,size: 15,),
                                          ),
                                          ),


                                          Container(
                                          //margin: EdgeInsets.only(bottom: 14),
                                          width: 35,
                                          height: 28,
                                          color: AppTheme.off_White_bg,
                                          alignment: Alignment.center,child: Text(data[index].boxcontroller[index2].text
                                          ,style: AppTheme.subtitle.copyWith(color: AppTheme.medium_text_color,fontSize: 13,fontWeight: FontWeight.w400,


                                          )),


                                          // TextFormField(
                                          //     //key:UniqueKey(),
                                          //
                                          //     decoration: InputDecoration(
                                          //       hintText: "Qty",
                                          //       border: OutlineInputBorder(borderRadius:  BorderRadius.circular(1.0),),
                                          //
                                          //     ),
                                          //
                                          //     controller: data[index].boxcontroller[index2],
                                          //
                                          //     onChanged: (value){
                                          //
                                          //
                                          //       LogCustom.logd("xxxxxxx : change:"+value);
                                          //
                                          //       setState(() {
                                          //
                                          //         if(value.isNotEmpty && Validation.isNumeric(value)){
                                          //           data[index].qty[index2]=value.toString();
                                          //
                                          //         }else{
                                          //           data[index].qty[index2]="0";
                                          //         }
                                          //
                                          //
                                          //         _bloc.updateqty(data[index].pid, data[index].qty.toString());
                                          //
                                          //       });
                                          //
                                          //     },
                                          //     onFieldSubmitted: (term){
                                          //       // _boxFocus.unfocus();
                                          //       //FocusScope.of(context).requestFocus(_pcsFocus);
                                          //     },
                                          //
                                          //     enabled: false,
                                          //     obscureText: false,
                                          //     textAlign: TextAlign.center,
                                          //     keyboardType: TextInputType.text,
                                          //     textInputAction: TextInputAction.done,
                                          //
                                          //   ),
                                          ),


                                          InkWell(
                                          onTap: (){
                                          if(double.parse(data[index].boxcontroller[index2].text)>1){
                                          setState(() {

                                          data[index].boxcontroller[index2].text=Utils.currencyText((double.parse(data[index].boxcontroller[index2].text)-1).toString());

                                          data[index].qty[index2]=data[index].boxcontroller[index2].text.toString();
                                          _bloc.updateqty(data[index].pid, data[index].qty.toString());


                                          });
                                          }


                                          },
                                          child: Container(
                                          height: 28,
                                          padding: EdgeInsets.only(left: 4, right: 4),
                                          color: AppTheme.gray_300,
                                          child: Icon(Icons.remove,size: 15,),
                                          ),
                                          ),

                                          ],
                                          ),
                                          ),


                                          Text("  =  ",style: AppTheme.subtitle.copyWith(fontSize: 14, color: AppTheme.black_text, fontWeight: FontWeight.w500),),


                                          (data[index].boxcontroller[index2].text.isNotEmpty && Validation.isNumeric(data[index].boxcontroller[index2].text))? Text(Utils.currencyText((int.parse(data[index].packing)*double.parse(data[index].boxcontroller[index2].text.toString())).toString()),style: AppTheme.subtitle.copyWith(color: AppTheme.medium_text_color,fontSize: 12, fontWeight: FontWeight.w400),):SizedBox.shrink(),

                                          SizedBox(width: 4,),

                                          Text(sizeType.toUpperCase(),style: AppTheme.subtitle.copyWith(color: AppTheme.medium_text_color,fontSize: 11,fontWeight: FontWeight.w400),),


                                          ],
                                          ),


                                          ],
                                          );

                                        }),


                                    Row(
                                      children: [

                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 16),
                                          child: Text(
                                            "(1 BOX = " + data[index].packing +
                                                " " + sizeType.toUpperCase() +
                                                ")",
                                            style: AppTheme.subtitleroboto
                                                .copyWith(fontSize: 10,
                                                color: AppTheme.black_800),),
                                        ),

                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                top: 16, left: 4),
                                            child: Text(
                                              "(1 " + sizeType.toUpperCase() +
                                                  " = " + Utils.currencyText(
                                                  data[index].price) +
                                                  " Price)",
                                              style: AppTheme.subtitleroboto
                                                  .copyWith(fontSize: 10,
                                                  color: AppTheme.black_800),),
                                          ),
                                        ),

                                      ],
                                    ),


                                  ]),
                            )),


                          ],
                        ),


                        Container(height: 0.5,
                          color: AppTheme.light_grey,
                          width: double.infinity,),

                        Container(
                          // decoration: BoxDecoration(
                          //   borderRadius: const BorderRadius.all(Radius.circular(2)),
                          //   border: Border.all(color: AppTheme.off_White, width: 0.5,),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: InkWell(onTap: () {
                                _bloc.deleteitem(data[index].pid);
                                callApi();
                              },
                                  child: Container(height: 34,
                                      alignment: Alignment.center,
                                      color: AppTheme.off_White_bg,
                                      child: Text("REMOVE", style: TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.black_text,
                                          fontFamily: AppTheme
                                              .poppinsRegular))))),
                              Container(height: 34, width: 1, color: AppTheme
                                  .light_grey,),
                              Expanded(child: InkWell(onTap: () {
                                addremoveWishlist(
                                    true, data[index].pid.toString());
                              },
                                  child: Container(alignment: Alignment.center,
                                      height: 34,
                                      color: AppTheme.off_White_bg,
                                      child: Text("ADD TO WISHLIST",
                                          style: TextStyle(fontSize: 12,
                                              color: AppTheme.black_text,
                                              fontFamily: AppTheme
                                                  .poppinsRegular)))))
                            ],),
                        )
                      ],
                    )
                ),
              );
            }),
      ],
    );
  }


  Widget productTna() {
    return StreamBuilder(

      stream: _bloc.subjectTNA.stream,
      builder: (context, AsyncSnapshot<List<CartConstants>> snapshot) {
        if (snapshot.hasData && snapshot.data != null &&
            snapshot.data.length != 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10,),

              Text("TNA Products", style: AppTheme.subtitle.copyWith(
                  color: AppTheme.black, fontSize: 18),),

              SizedBox(height: 10,),

              newArival(snapshot.data),
            ],
          );
        }
        else {
          return SizedBox.shrink();
        }
      },
    );
  }


  String getTotal(CartConstants data) {
    double qnty = 0;


    data.qty.forEach((element) {
      qnty = double.parse(element) + qnty;
    });


    double price;


    if (data.packing != null && data.packing != "") {
      price =
          double.parse(data.price) * qnty * int.parse(data.packing.toString());
    } else {
      price = double.parse(data.price) * qnty;
    }


    //_bloc.getGrand();

    return price.toString();
  }


  Future<bool> addremoveWishlist(bool isAdd, String productId) async {
    await Pr.show(context);

    Map<String, String> parms = new Map<String, String>();
    parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());
    parms.putIfAbsent("product_id", () => productId);

    await _bloc.addremoveWhislist(isAdd, parms);


    // _bloc.deleteitem(productId);

    callApi();

    await Pr.hide(context);


    return true;
  }


  placeOrder() async {
    Pr.show(context);

    Map parms = new Map<String, dynamic>();

    parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());

    if (_bloc.comentcontroller.text.isNotEmpty) {
      parms.putIfAbsent("remarks", () => _bloc.comentcontroller.text);
    }


    List<Map> productlist = [];


    for (int i = 0; i < _bloc.data.length; i++) {
      Map product = new Map<String, String>();

      // parms.putIfAbsent("product["+i.toString()+"][id]", () => _bloc.data[i].pid);
      product.putIfAbsent("id", () => _bloc.data[i].pid);


      if (_bloc.data[i].qty.length == 1) {
        //  parms.putIfAbsent("product["+i.toString()+"][quantity]", () => _bloc.data[i].qty[0]);
        // parms.putIfAbsent("product["+i.toString()+"][quantity_type]", () => "N/A");

        product.putIfAbsent("quantity", () => _bloc.data[i].qty[0]);
        product.putIfAbsent("quantity_type", () => "N/A");
      } else {
        int qnty = 0;
        List<String> size = [];

        for (int j = 0; j < _bloc.data[i].qty.length; j++) {
          qnty = int.parse(_bloc.data[i].qty[j]) + qnty;
          size.add(_bloc.data[i].sizeList[j] + ":" + _bloc.data[i].qty[j]);
        }
        //  parms.putIfAbsent("product["+i.toString()+"][quantity]", () => qnty.toString());

        //parms.putIfAbsent("product["+i.toString()+"][quantity_type]", () => size.toString().replaceAll('[', '').replaceAll(']',''));


        product.putIfAbsent("quantity", () => qnty.toString());
        product.putIfAbsent("quantity_type", () =>
            size.toString().replaceAll('[', '').replaceAll(']', ''));
      }


      //LogCustom.logd("xxxxxx :product: "+product.toString());

      productlist.add(product);
    }

    parms.putIfAbsent("product", () => productlist);


    var params = {
      "user_id": _bloc.apiProvider.pref.getUserId(),
      "remarks": _bloc.comentcontroller.text,
      "product": productlist,
    };


    LogCustom.logd("xxxxxx :productlist: " + params.toString());


    PlaceOrderResponse placeOrder = await _bloc.placeOrder(false, params);

    Pr.hide(context);


    if (placeOrder != null) {
      if (placeOrder.statusCode == Constant.API_CODE) {
        Constant.count = 0;

        _showInSnackBar(placeOrder.message);


        Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()),);
      } else {
        _showInSnackBar(placeOrder.message);
      }
    }
  }


  void _showInSnackBar(String value) {
    LogCustom.logd("xxxxxx: network snackbar :");

    Snack.showS(context, value);
  }


  @override
  void dispose() {
    LogCustom.logd("xxxxxxxxxx  home page dispose");
    // WidgetsBinding.instance.removeObserver(this);

    _bloc?.dispose();

    super.dispose();
  }


}



