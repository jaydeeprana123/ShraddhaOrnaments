import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:shradha_design/utils/utils.dart';
import 'package:shradha_design/utils/validation.dart';


class CartScreen extends StatefulWidget {
  @override
  CartScreenState createState() {
    return CartScreenState();
  }
}



class CartScreenState extends State<CartScreen>  with WidgetsBindingObserver  {




   CartListBloc _bloc ;//= HomeBloc();





  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }








  @override
  void initState() {


    WidgetsBinding.instance.addObserver(this);

    LogCustom.logd("xxxxxxxxxx  home page initState");



    _bloc = CartListBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );


   _bloc.comentcontroller = new TextEditingController();

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

    LogCustom.logd("xxxxxxxxx resume mycart ::state"+state.toString());

  }




  void callApi()async{


    if(mounted){
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
                //  height: screenHeight,
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 5,right: 5) ,


                    child: Column(
                      children: [


                        Expanded(
                          child:SingleChildScrollView(
                              child:Column(
                                children: [



                                  SizedBox(
                                    height: 10,
                                  ),

                                  Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Your Cart",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

                                        Image.asset('assets/images/home_line.png',height: 10,),

                                      ],
                                    ),
                                  ),


                                  SizedBox(
                                    height: 10,
                                  ),


                                  bannerBuild(),

                                  productTna(),





                                ],
                              )
                          ),
                        ),

                       SafeArea(
                         top: false,
                         child:  buttonView(),
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




  Widget bannerBuild() {
    return StreamBuilder(

      stream: _bloc.subject.stream,
      builder: (context, AsyncSnapshot<List<CartConstants>> snapshot) {

        if (snapshot.hasData && snapshot.data != null ) {


          return newArival(snapshot.data);


        }
        else if (snapshot.hasError ) {

          double  screenHeight = MediaQuery.of(context).size.height-250;

          return  Center(
            child: Container(
                alignment: Alignment.center,
                height: screenHeight,
                child: Text(snapshot.error ,style: TextStyle(fontSize: 22,color: AppTheme.gray_500),),),
          );
        }   else {
          return  CommonLoading();
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
                padding: EdgeInsets.all(5),
                child:  Container(
                  margin: EdgeInsets.only(top: 10,),
                  alignment: Alignment.center,
                  // color: AppTheme.edit_bg,

                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border.all(color: AppTheme.gray_400, width: 1,),
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: TextFormField(
                    //key:UniqueKey(),
                    style: AppTheme.subtitle,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 15),
                      border: InputBorder.none,
                      hintText: 'Remarks (Optional) Maximum 250 Character',


                    ),



                    controller:  _bloc.comentcontroller,
                    onFieldSubmitted: (term){
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

              Container(
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Text("Total : ",style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.black),),
                      Text("\₹"+Utils.currencyText(_bloc.grandtotal.toString()),style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.primary),),

                    ],
                  )
              ),
              Container(
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Text("TNA Total : ",style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.black),),
                      Text("\₹"+Utils.currencyText(_bloc.tnagrandtotal.toString()),style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.primary),),

                    ],
                  )
              ),

              SizedBox(height: 5,),


              Row(
                children: [


                  Expanded(child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      // color: AppTheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(1.0)),

                    ),
                    //color: AppTheme.white,
                    padding: EdgeInsets.all(0),
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      color: AppTheme.primary,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                          side: BorderSide(color: AppTheme.primary, width: 1.0,)),
                      onPressed: () {


                        placeOrder();



                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text("Place Order",style: AppTheme.subtitle.copyWith(fontSize: 16,color: AppTheme.white,fontWeight: FontWeight.w500) ,textAlign: TextAlign.right,)
                          ],
                        ),
                      ),

                    ),
                  )),



                  SizedBox(width: 3,),


                  Expanded(child: Container(
                    height: 45,

                    decoration: BoxDecoration(
                      // color: AppTheme.black_600,
                      borderRadius: const BorderRadius.all(Radius.circular(1.0)),

                    ),
                    //color: AppTheme.white,
                    padding: EdgeInsets.all(0),
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      color: AppTheme.black_800,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                          side: BorderSide(color: AppTheme.black_800, width: 1.0,)),

                      onPressed: () {


                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);



                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 5,),
                            Text( "Continue Shopping",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontWeight: FontWeight.w500,fontSize: 16) ,textAlign: TextAlign.right,)
                          ],
                        ),
                      ),

                    ),
                  )),


                ],
              ),


            ],
          );


        }

        return SizedBox.shrink();
      },
    );
  }







  Widget newArival(List<CartConstants> data){


  return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap : true,
      scrollDirection: Axis.vertical,
      itemCount: data.length,

      itemBuilder: (context,index){


        String sizeType="Pieces";

        if(data[index].boxtype!=null){

          List<String> saletype = data[index].boxtype.split(",");

          if(saletype.isNotEmpty ){
            if(saletype.length==2){
              sizeType=saletype[1];
            }else{
              sizeType=saletype[0];
            }
          }


        }



        return InkWell(

          onTap: (){

          //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: data[index].pid,)),);

          },
          child: Container(
              margin: EdgeInsets.only(bottom: 5),


              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                color: (data[index].tna=="0")?Colors.white:AppTheme.primaryblur,
                border: Border.all(color: AppTheme.gray_300, width: 1,),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: AppTheme.gray_300, offset: const Offset(1, 1), blurRadius: 2,),
                ],

              ),


              child:Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Stack(
                    children: [

                      Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(1)),
                          color: Colors.white,
                          border: Border.all(color: AppTheme.gray_300, width: 1,),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: AppTheme.gray_300, offset: const Offset(1, 1), blurRadius: 2,),
                          ],

                        ),
                        child: CachedNetworkImage(imageUrl:data[index].image,fit: BoxFit.contain,height: 80,width: 80,
                          errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg',height: 80,width: 80,),
                          placeholder: (context, url) => Image.asset('assets/images/loading_dots.gif',height: 80,width: 80,),
                        ),
                      ),

                      (data[index].tna=="1")? Positioned(
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
                        child: Text(data[index].title,style: AppTheme.subtitle.copyWith(fontSize: 15,fontWeight: FontWeight.w500),),
                      ),





                      ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap : true,
                          scrollDirection: Axis.vertical,
                          itemCount: data[index].sizeList.length,

                          itemBuilder: (context,index2){

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Container(
                                  margin: EdgeInsets.only(left:65),
                                  child: Text("Box",style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontSize: 12,fontWeight: FontWeight.w500),)
                                  ,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [



                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 40,
                                      child: (data[index].sizeList.length!=0)?Text(data[index].sizeList[index2].trimLeft(),style: AppTheme.subtitle,):Text("Qty : ",style: AppTheme.subtitle,),
                                    ),




                                    SizedBox(width: 2,),



                                    Container(
                                      color: AppTheme.gray_300,
                                      padding: EdgeInsets.all(1),
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
                                              height: 30,
                                              color: AppTheme.gray_300,
                                              child: Icon(Icons.add,size: 15,),
                                            ),
                                          ),



                                          Container(
                                            //margin: EdgeInsets.only(bottom: 14),
                                            width: 40,
                                            height: 30,
                                            color: AppTheme.white,
                                            child: TextFormField(
                                              //key:UniqueKey(),

                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.all(5.0),
                                                hintText: "Qty",

                                                border: OutlineInputBorder(borderRadius:  BorderRadius.circular(1.0),),

                                              ),

                                              controller: data[index].boxcontroller[index2],

                                              onChanged: (value){


                                                LogCustom.logd("xxxxxxx : change:"+value);

                                                setState(() {

                                                  if(value.isNotEmpty && Validation.isNumeric(value)){
                                                    data[index].qty[index2]=value.toString();

                                                  }else{
                                                    data[index].qty[index2]="0";
                                                  }


                                                  _bloc.updateqty(data[index].pid, data[index].qty.toString());

                                                });

                                              },
                                              onFieldSubmitted: (term){
                                                // _boxFocus.unfocus();
                                                //FocusScope.of(context).requestFocus(_pcsFocus);
                                              },

                                              enabled: false,
                                              obscureText: false,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction.done,

                                            ),
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
                                              height: 30,
                                              color: AppTheme.gray_300,
                                              child: Icon(Icons.remove,size: 15,),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),



                                    Text("  =  ",style: AppTheme.subtitleroboto.copyWith(fontSize: 18),),


                                    (data[index].boxcontroller[index2].text.isNotEmpty && Validation.isNumeric(data[index].boxcontroller[index2].text))? Text(Utils.currencyText((int.parse(data[index].packing)*double.parse(data[index].boxcontroller[index2].text.toString())).toString()),style: AppTheme.subtitleroboto.copyWith(color: AppTheme.primary,fontSize: 16),):SizedBox.shrink(),

                                    SizedBox(width: 5,),

                                    Text(sizeType,style: AppTheme.subtitleroboto.copyWith(color: AppTheme.primary,fontSize: 16),),



                                  ],
                                ),









                              ],
                            );

                          }),



                     /* StaggeredGridView.countBuilder(
                          physics:const NeverScrollableScrollPhysics(),
                          shrinkWrap : true,
                          scrollDirection: Axis.vertical,
                          itemCount: data[index].sizeList.length,
                          crossAxisCount: 6,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          padding: EdgeInsets.all(0),
                          staggeredTileBuilder: (index2) => new StaggeredTile.fit((3)),
                          itemBuilder: (context,index2){


                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Container(
                                    margin: EdgeInsets.only(left:65),
                                    child: Text("Box",style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontSize: 12,fontWeight: FontWeight.w500),)
                                  ,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [



                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 40,
                                      child: (data[index].sizeList.length!=0)?Text(data[index].sizeList[index2].trimLeft(),style: AppTheme.subtitle,):Text("Qty : ",style: AppTheme.subtitle,),
                                    ),




                                    SizedBox(width: 2,),



                                    Container(
                                      color: AppTheme.gray_300,
                                      padding: EdgeInsets.all(1),
                                      child: Row(
                                        children: [

                                          InkWell(
                                            onTap: (){

                                              setState(() {
                                                data[index].boxcontroller[index2].text=(double.parse(data[index].boxcontroller[index2].text)+1).toString();

                                                data[index].qty[index2]=data[index].boxcontroller[index2].text.toString();
                                                _bloc.updateqty(data[index].pid, data[index].qty.toString());

                                              });

                                            },
                                            child: Container(
                                              height: 30,
                                              color: AppTheme.gray_300,
                                              child: Icon(Icons.add,size: 15,),
                                            ),
                                          ),



                                          Container(
                                            //margin: EdgeInsets.only(bottom: 14),
                                            width: 40,
                                            height: 30,
                                            color: AppTheme.white,
                                            child: TextFormField(
                                              //key:UniqueKey(),

                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.all(5.0),
                                                hintText: "Qty",

                                                border: OutlineInputBorder(borderRadius:  BorderRadius.circular(1.0),),

                                              ),

                                              controller: data[index].boxcontroller[index2],

                                              onChanged: (value){


                                                LogCustom.logd("xxxxxxx : change:"+value);

                                                setState(() {

                                                  if(value.isNotEmpty && Validation.isNumeric(value)){
                                                    data[index].qty[index2]=value.toString();

                                                  }else{
                                                    data[index].qty[index2]="0";
                                                  }


                                                  _bloc.updateqty(data[index].pid, data[index].qty.toString());

                                                });

                                              },
                                              onFieldSubmitted: (term){
                                                // _boxFocus.unfocus();
                                                //FocusScope.of(context).requestFocus(_pcsFocus);
                                              },

                                              enabled: false,
                                              obscureText: false,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction.done,

                                            ),
                                          ),


                                          InkWell(
                                            onTap: (){
                                              if(double.parse(data[index].boxcontroller[index2].text)>1){
                                                setState(() {
                                                  data[index].boxcontroller[index2].text=(double.parse(data[index].boxcontroller[index2].text)-1).toString();

                                                  data[index].qty[index2]=data[index].boxcontroller[index2].text.toString();
                                                  _bloc.updateqty(data[index].pid, data[index].qty.toString());



                                                });
                                              }



                                            },
                                            child: Container(
                                              height: 30,
                                              color: AppTheme.gray_300,
                                              child: Icon(Icons.remove,size: 15,),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),



                                    Text("  =  ",style: AppTheme.subtitleroboto.copyWith(fontSize: 18),),


                                    (data[index].boxcontroller[index2].text.isNotEmpty && Validation.isNumeric(data[index].boxcontroller[index2].text))? Text((int.parse(data[index].packing)*double.parse(data[index].boxcontroller[index2].text.toString())).toString(),style: AppTheme.subtitleroboto.copyWith(color: AppTheme.primary,fontSize: 18),):SizedBox.shrink(),

                                    SizedBox(width: 5,),

                                    Text(sizeType,style: AppTheme.subtitleroboto.copyWith(color: AppTheme.primary,fontSize: 18),),



                                  ],
                                ),









                              ],
                            );

                          }),
*/




                      Row(
                        children: [

                          Container(
                           // padding: EdgeInsets.all(5),
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){

                                addremoveWishlist(true,data[index].pid.toString());

                              },
                              child: Image.asset('assets/images/cart_wishlist.png',height: 35,),
                            ),
                          ),


                          Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: (){

                                _bloc.deleteitem(data[index].pid);
                                callApi();


                              },
                              child: Image.asset('assets/images/cart_delete.png',height: 35,),
                            ),
                          ),



                          Expanded(child: Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Text("Total : ",style: AppTheme.subtitlerubicSemi.copyWith(color: AppTheme.black_text_dark,fontWeight: FontWeight.w600),),
                                Text("\₹"+Utils.currencyText(getTotal(data[index])),style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontWeight: FontWeight.w600),),
                              ],
                            ),

                          )),



                        ],
                      ),



                      Row(
                        children: [

                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 10),
                            child: Text("(1 BOX = "+data[index].packing+" "+sizeType.toUpperCase()+")",style: AppTheme.subtitleroboto.copyWith(fontSize: 12,color: AppTheme.black_800),),
                          ),

                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 10),
                            child: Text("(1 "+sizeType.toUpperCase()+" = "+Utils.currencyText(data[index].price)+" Price)",style: AppTheme.subtitleroboto.copyWith(fontSize: 12,color: AppTheme.black_800),),
                          ),

                        ],
                      ),


                    ]),
                  )),


                ],
              )



          ),
        );
      });

}





  Widget productTna() {
    return StreamBuilder(

      stream: _bloc.subjectTNA.stream,
      builder: (context, AsyncSnapshot<List<CartConstants>> snapshot) {

        if (snapshot.hasData && snapshot.data != null && snapshot.data.length!=0 ) {


          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10,),

              Text("TNA Products",style: AppTheme.subtitle.copyWith(color: AppTheme.black,fontSize: 18),),

              SizedBox(height: 10,),

              newArival(snapshot.data),
            ],
          );


        }
          else {
          return  SizedBox.shrink();
        }
      },
    );
  }




String getTotal(CartConstants data){



  double qnty=0;


    data.qty.forEach((element) {

      qnty=double.parse(element)+qnty;

    });


    double price;


    if(data.packing!=null && data.packing!=""){
      price=double.parse(data.price)*qnty*int.parse(data.packing.toString());
    }else{
      price=double.parse(data.price)*qnty;
    }



    //_bloc.getGrand();

    return price.toString();

}








  Future<bool> addremoveWishlist(bool isAdd,String productId)async{



    await Pr.show(context);

    Map<String, String> parms = new Map<String,String>();
    parms.putIfAbsent("user_id",()=> _bloc.apiProvider.pref.getUserId());
    parms.putIfAbsent("product_id",()=> productId);

    await _bloc.addremoveWhislist(isAdd,parms);



   // _bloc.deleteitem(productId);

    callApi();

    await Pr.hide(context);


    return true;



  }







placeOrder()async{


    Pr.show(context);

  Map parms=new Map<String,dynamic>();

  parms.putIfAbsent("user_id", () => _bloc.apiProvider.pref.getUserId());

  if(_bloc.comentcontroller.text.isNotEmpty){
    parms.putIfAbsent("remarks", () => _bloc.comentcontroller.text);
  }


    List<Map> productlist= [];


    for (int i=0 ;i<_bloc.data.length;i++){

      Map product=new Map<String,String>();

     // parms.putIfAbsent("product["+i.toString()+"][id]", () => _bloc.data[i].pid);
      product.putIfAbsent("id", () => _bloc.data[i].pid);





      
      
      if(_bloc.data[i].qty.length==1){
      //  parms.putIfAbsent("product["+i.toString()+"][quantity]", () => _bloc.data[i].qty[0]);
       // parms.putIfAbsent("product["+i.toString()+"][quantity_type]", () => "N/A");

        product.putIfAbsent("quantity", () => _bloc.data[i].qty[0]);
        product.putIfAbsent("quantity_type", () => "N/A");


      }else{

        int qnty=0;
        List<String> size=[];

        for(int j=0;j<_bloc.data[i].qty.length;j++){

          qnty=int.parse(_bloc.data[i].qty[j])+qnty;
          size.add(_bloc.data[i].sizeList[j]+":"+_bloc.data[i].qty[j]);

        }
      //  parms.putIfAbsent("product["+i.toString()+"][quantity]", () => qnty.toString());

        //parms.putIfAbsent("product["+i.toString()+"][quantity_type]", () => size.toString().replaceAll('[', '').replaceAll(']',''));


        product.putIfAbsent("quantity", () => qnty.toString());
        product.putIfAbsent("quantity_type", () => size.toString().replaceAll('[', '').replaceAll(']',''));



      }


      //LogCustom.logd("xxxxxx :product: "+product.toString());

      productlist.add(product);

  }

    parms.putIfAbsent("product", () => productlist);


    var params =  {
      "user_id": _bloc.apiProvider.pref.getUserId(),
      "remarks": _bloc.comentcontroller.text,
      "product": productlist,
    };



    LogCustom.logd("xxxxxx :productlist: "+params.toString());


  PlaceOrderResponse placeOrder=await _bloc.placeOrder(false, params);

    Pr.hide(context);


  if(placeOrder!=null ){


    if(placeOrder.statusCode==Constant.API_CODE){
      Constant.count=0;

      _showInSnackBar(placeOrder.message);


      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);
    }else{

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



