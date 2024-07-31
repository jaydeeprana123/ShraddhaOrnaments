import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/constant/network_constant.dart';
import 'package:shradha_design/response/login/login_response.dart';
import 'package:shradha_design/ui/home/main_page.dart';
import 'package:shradha_design/ui/login/Login.dart';
import 'package:shradha_design/ui/productdetails/productDetails_scree.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/ui/widget/snack.dart';
import '../../app_theme.dart';
import 'loginBloc.dart';

class PasscodeScreen extends StatefulWidget {

  String productId;
   PasscodeScreen({Key key, this.productId}) : super(key: key);

  @override
  _PasscodeScreenState createState() => new _PasscodeScreenState();

}


class _PasscodeScreenState extends State<PasscodeScreen> with WidgetsBindingObserver{

 // final FocusNode _pswdFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";
  String _currentAddress;
  Position _currentPosition;

  String isLocationShowInRajkot = "0";

  int pascodeSize=5;

  TextEditingController _pswdcontroller;


  LoginBloc bloc;

  @override
  void initState() {

    // print("initState productId" +  widget.productId);

   // WidgetsBinding.instance.addObserver(this);

    bloc=LoginBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    if(bloc.apiProvider.pref.getUserId() == "0" || bloc.apiProvider.pref.getUserId().isEmpty){
      bloc.apiProvider.pref.logout();

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          LoginScreen()), (Route<dynamic> route) => false);
    }


    _pswdcontroller = new TextEditingController();

    print("xxxxxxx  islive::"+NetworkContastant.isLive.toString());

    super.initState();

   // NotificationHandler().notConfig(context);








  }









  @override
  Widget build(BuildContext context) {

    double  screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      //backgroundColor: AppTheme.white,
      body: Stack(


        children: [



          Container(

            margin: EdgeInsets.only(top:20),
            padding: EdgeInsets.only(top:10),
            // height: screenHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(

              // image: DecorationImage(
              //   image: const AssetImage("assets/images/bg.jpg"),
              //   fit: BoxFit.fill,
              //
              // ),

            ),


           /* child: Row(

              children: [

                InkWell(
                  onTap: (){

                    if(Navigator.canPop(context)){
                      Navigator.pop(context);
                    }else{
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    }


                  },
                  child: Container(

                    margin: EdgeInsets.only(top: 5,left:5),
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back,color: AppTheme.black,size: 25,),
                  ),
                ),


                Expanded(child: Container(
                  margin: EdgeInsets.only(right: 20,),
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.topCenter,
                  child: Image.asset(logo_home,fit: BoxFit.fitHeight,height:  40),
                )),

              ],
            ),*/



          ),


          Container(
            margin: EdgeInsets.only(top:30),
            padding: EdgeInsets.only(top:30),

            height: screenHeight,
            alignment: Alignment.center,
           /* decoration: BoxDecoration(

              image: DecorationImage(
                image: const AssetImage(login_bg),

                fit: BoxFit.fill,

              ),

            ),
*/

            child: SingleChildScrollView(

              child: Column(

                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[






                  Container(
                    padding: EdgeInsets.all(20),


                    child: Stack(
                      children: [


                        Column(
                          children: [



                            Image.asset('assets/images/lock.png',fit: BoxFit.fitHeight,height:  80),

                            SizedBox(
                              height: 30,
                            ),

                            Text("Enter Your 5 Digit Pincode",style: AppTheme.subtitle.copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: AppTheme.black),),

                            SizedBox(height: 15,),





                           /* Form(
                              key: formKey,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 25.0, horizontal: 40),
                                  child: PinCodeTextField(
                                    appContext: context,

                                    pastedTextStyle: TextStyle(
                                      color: Colors.green.shade600,
                                      fontWeight: FontWeight.bold,

                                    ),

                                    length: 5,
                                    obscureText: true,
                                    obscuringCharacter: '*',
                                    animationType: AnimationType.slide,



                                    validator: (v) {
                                      if (v.isEmpty) {
                                        return "Please enter pincode";
                                      }else if (v.length < 4) {
                                        return "Please enter valid pincode";
                                      } else {
                                        return null;
                                      }
                                    },

                                    pinTheme: PinTheme(

                                      shape: PinCodeFieldShape.box,
                                      //borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 35,
                                      fieldWidth: 35,

                                      activeFillColor: hasError ? Colors.white : Colors.white,
                                      activeColor: AppTheme.green,
                                      inactiveColor: AppTheme.gray_500,
                                      selectedColor: AppTheme.primary,

                                    ),
                                    //cursorColor: Colors.black,
                                    animationDuration: Duration(milliseconds:10),
                                    //textStyle: TextStyle(fontSize: 20, height: 1.6),
                                    backgroundColor: AppTheme.transparent,
                                    enableActiveFill: false,

                                    // errorAnimationController: errorController,
                                    controller: _pswdcontroller,
                                    keyboardType: TextInputType.number,

                                    onCompleted: (v) {
                                      print("Completed");
                                    },
                                    // onTap: () {
                                    //   print("Pressed");
                                    // },
                                    onChanged: (value) {
                                      print(value);

                                      setState(() {
                                        currentText = value;
                                      });
                                    },
                                    beforeTextPaste: (text) {
                                      print("Allowing to paste $text");
                                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                      return true;
                                    },
                                  )),
                            ),
*/




                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Icon((_pswdcontroller.text.isNotEmpty)?Icons.brightness_1_rounded:Icons.radio_button_off_sharp,
                                color: (_pswdcontroller.text.isNotEmpty)?AppTheme.primarydark:AppTheme.black_800,),
                                SizedBox(width: 10,),
                                Icon((_pswdcontroller.text.isNotEmpty&&_pswdcontroller.text.length>1)?Icons.brightness_1_rounded:Icons.radio_button_off_sharp,
                                  color: (_pswdcontroller.text.isNotEmpty&&_pswdcontroller.text.length>1)?AppTheme.primarydark:AppTheme.black_800,),
                                SizedBox(width: 10,),
                                Icon((_pswdcontroller.text.isNotEmpty&&_pswdcontroller.text.length>2)?Icons.brightness_1_rounded:Icons.radio_button_off_sharp,
                                  color: (_pswdcontroller.text.isNotEmpty&&_pswdcontroller.text.length>2)?AppTheme.primarydark:AppTheme.black_800,),
                                SizedBox(width: 10,),
                                Icon((_pswdcontroller.text.isNotEmpty&&_pswdcontroller.text.length>3)?Icons.brightness_1_rounded:Icons.radio_button_off_sharp,
                                  color: (_pswdcontroller.text.isNotEmpty&&_pswdcontroller.text.length>3)?AppTheme.primarydark:AppTheme.black_800,),
                                SizedBox(width: 10,),
                                Icon((_pswdcontroller.text.isNotEmpty&&_pswdcontroller.text.length>4)?Icons.brightness_1_rounded:Icons.radio_button_off_sharp,
                                  color: (_pswdcontroller.text.isNotEmpty&&_pswdcontroller.text.length>4)?AppTheme.primarydark:AppTheme.black_800,),





                              ],
                            ),


                            SizedBox(height: 20,),


                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [


                                    InkWell(
                                      onTap: (){

                                        clickButton("1");

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("1",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    InkWell(
                                      onTap: (){

                                        clickButton("2");

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("2",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    InkWell(
                                      onTap: (){
                                        clickButton("3");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("3",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),



                                  ],
                                ),


                                SizedBox(height: 15,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [


                                    InkWell(
                                      onTap: (){
                                        clickButton("4");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("4",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    InkWell(
                                      onTap: (){
                                        clickButton("5");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("5",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    InkWell(
                                      onTap: (){
                                        clickButton("6");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),

                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("6",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),



                                  ],
                                ),


                                SizedBox(height: 15,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [


                                    InkWell(
                                      onTap: (){
                                        clickButton("7");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),

                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("7",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    InkWell(
                                      onTap: (){
                                        clickButton("8");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("8",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    InkWell(
                                      onTap: (){
                                        clickButton("9");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("9",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),



                                  ],
                                ),



                                SizedBox(height: 15,),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [


                                    InkWell(
                                      onTap: (){



                                        if(_pswdcontroller.text.isNotEmpty && _pswdcontroller.text.length==5){

                                          login();

                                        }else{
                                          showInSnackBar("Please enter passcode");
                                        }

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,

                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(35.0),

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_enter.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                      ),
                                    ),

                                    SizedBox(height: 15,),

                                    InkWell(
                                      onTap: (){
                                        clickButton("0");
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),

                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_blank.png"),
                                            fit: BoxFit.fill,

                                          ),

                                          // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                          // color: AppTheme.white,
                                          // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                          // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(35.0),
                                          // padding: EdgeInsets.all(4),
                                          child: Text("0",style: AppTheme.subtitle.copyWith(fontSize: 30,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    InkWell(
                                      onTap: (){

                                        if(_pswdcontroller.text!=""){


                                          String str=_pswdcontroller.text;

                                          if (str != null && str.length > 0) {
                                            str = str.substring(0, str.length - 1);
                                          }

                                          _pswdcontroller.text=str;

                                        }

                                        setState(() {

                                        });



                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10,right:20),
                                        // padding: EdgeInsets.all(5),
                                        height:60,
                                        width: 60,
                                        decoration: BoxDecoration(

                                          image: DecorationImage(
                                            image: const AssetImage("assets/images/lock_remove.png"),
                                            fit: BoxFit.fill,

                                          ),

                                         // image: Image.asset('assets/images/lock_remove.png',fit: BoxFit.fitHeight,),
                                           // color: AppTheme.white,
                                           // border: Border.all(color: AppTheme.gray_400, width: 1,),
                                           // borderRadius: BorderRadius.circular(35.0)
                                        ),


                                      ),
                                    ),



                                  ],
                                ),







                              ],
                            ),











                            SizedBox(
                              height: 20,
                            ),


                           /* Row(
                              children: [
                                Expanded(child: Container(
                                  decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),

                                  ),
                                  //color: AppTheme.white,
                                  padding: EdgeInsets.all(2),
                                  child: MaterialButton(
                                    color: AppTheme.white,

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                        side: BorderSide(color: AppTheme.primarydark, width: 1.0,)),
                                    onPressed: () {



                                      if(formKey.currentState.validate()){

                                       *//* if(bloc.apiProvider.pref.getsecurityCode()){

                                        }
                                       *//*
                                        login();
                                      }





                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 25,right: 25,top:5,bottom: 5),
                                      padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                      child: Text("Submit",style: AppTheme.subtitle.copyWith(color: AppTheme.primarydark,fontWeight: FontWeight.w500) ,textAlign: TextAlign.right,),
                                    ),

                                  ),
                                )),

                              ],
                            ),
*/



                          /*  SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              child: InkWell(
                                onTap: (){

                                  //showForgotDialog(scaffoldKey,context,true);


                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotView(isForgotPassw: false,)),);


                                },
                                child: Center(
                                  child: Text("Forgot Password",style: AppTheme.subtitle.copyWith(color: AppTheme.primary,fontSize: 16,decoration: TextDecoration.underline,)),
                                ),
                              ),
                            ),
*/
                            SizedBox(
                              height: 10,
                            ),





                            Padding(
                              padding: EdgeInsets.only(top: 5,bottom: 5),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
                                },
                                child: Center(
                                  child: Text("Login",style: AppTheme.subtitle.copyWith(color: AppTheme.black_grey,fontSize: 16,decoration: TextDecoration.underline,)),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),





                          ],
                        ),

                      ],
                    ),
                  ),






                ],
              ),
            ),

          ),



        ],

      ),
    );
  }





  login()async{


    Pr.show(context);

      Map<String, String> parms = new Map<String,String>();

      parms.putIfAbsent("id",()=> bloc.apiProvider.pref.getUserId());
      parms.putIfAbsent("security_code",()=> _pswdcontroller.text.trim());

      LoginResponse response= await bloc.checkcode(parms);

    Pr.hide(context);


    if(response!=null){

        if(response.statusCode==Constant.API_CODE){
          await bloc.apiProvider.pref.setLogin(true);
          await bloc.apiProvider.pref.setToPriceShow(response.data.priceShow.toString());
          await bloc.apiProvider.pref.setLocationToShowInRajkot(response.data.isLocation.toString());

          if(response.data.isLocation.toString() == "0"){
            _getCurrentPosition();
          }else{

            print("not in rajkot");

            if(widget.productId != null && widget.productId.isNotEmpty){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: widget.productId,)),);
            }else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()),);
            }



          }

        }else{

          _pswdcontroller.text="";
          showInSnackBar(response.message[0]);

          setState(() {

          });

        }

      }



    }





    void clickButton(String sss){

      LogCustom.logd("xxxxxx: text click :"+sss);

      if( _pswdcontroller.text.length<pascodeSize){
        _pswdcontroller.text=_pswdcontroller.text+sss;
        LogCustom.logd("xxxxxx: text click :"+_pswdcontroller.text);

      }

      setState(() {

      });


      if(_pswdcontroller.text.length==5){
        login();
      }


    }



    void showInSnackBar(String value) {

      LogCustom.logd("xxxxxx: network snackbar :");
      Snack.showS(context, value);





    }


  @override
  void dispose() {

    LogCustom.logd("xxxxxxx dispose");

    PaintingBinding.instance.imageCache.clear();

    super.dispose();
  }



  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("LocationPermission.denied aayo");

        _showLocationPermissionAlertDialog(false, permission);

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("LocationPermission.deniedForever aayo");
      _showLocationPermissionAlertDialog(true, permission);

      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    print("_getCurrentPosition method call");

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print("position lat " + position.latitude.toString());
      print("position long " + position.longitude.toString());

      if (position != null) {
        _getAddressFromLatLng(position);
      }

      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {

    var distanceFromRajkot = (calculateDistance(22.30300969704739, 70.80069225873609, position.latitude, position.longitude));

    print("distanceFromRajkot - " +  distanceFromRajkot.toString());

    if(distanceFromRajkot <= 20){
      _showLocationAlertDialog();
    }else{
      if(widget.productId != null  && widget.productId.isNotEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: widget.productId,)),);

      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()),);

      }
    }


    // await placemarkFromCoordinates(position.latitude,position.longitude)
    //     .then((List<Placemark> placemarks) {
    //   Placemark place = placemarks[0];
    //   setState(() {
    //     _currentAddress =
    //     '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}';
    //
    //     String address ='${placemarks.first.name.isNotEmpty
    //         ? placemarks.first.name + 'first name , ' : ''}'
    //         '${placemarks.first.thoroughfare.isNotEmpty
    //         ? placemarks.first.thoroughfare + 'thoroughfare , ' : ''}'
    //         '${placemarks.first.subLocality.isNotEmpty
    //         ? placemarks.first.subLocality+ 'subLocality , ' : ''}'
    //         '${placemarks.first.locality.isNotEmpty
    //         ? placemarks.first.locality+ 'locality , ' : ''}'
    //         '${placemarks.first.subAdministrativeArea.isNotEmpty
    //         ? placemarks.first.subAdministrativeArea + ' subAdministrativeArea , ' : ''}'
    //         '${placemarks.first.postalCode.isNotEmpty
    //         ? placemarks.first.postalCode + ', ' : ''}'
    //         '${placemarks.first.administrativeArea.isNotEmpty
    //         ? placemarks.first.administrativeArea : ''}';
    //
    //     print("adreess"+address);
    //
    //     print("_currentAddress - " + _currentAddress);
    //
    //     if (placemarks.first.locality != null) {
    //       if (placemarks.first.locality.toLowerCase() == "rajkot") {
    //         _showLocationAlertDialog();
    //       } else {
    //
    //         if(widget.productId != null){
    //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: widget.productId,)),);
    //
    //         }else{
    //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()),);
    //
    //         }
    //
    //
    //       }
    //     }else{
    //       if(widget.productId != null){
    //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(pId: widget.productId,)),);
    //
    //       }else{
    //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()),);
    //
    //       }
    //     }
    //   });
    // }).catchError((e) {
    //   debugPrint(e);
    // });
  }

  Future<void> _showLocationAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Alert'),
          content: const SingleChildScrollView(
            child: Text(
                "Sorry!! You can not use this application in your location"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLocationPermissionAlertDialog(
      bool isPermanentDenied, LocationPermission permission) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Location Permission'),
          content:  SingleChildScrollView(
            child: Text((isPermanentDenied
                ? "Location permissions are permanently denied, we cannot request permissions. Sorry!! "
                : "Location permissions are denied. ") +
                "You can not use this application without giving location permission"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(isPermanentDenied ? 'Ok' : 'Give Permission'),
              onPressed: () async {
                Navigator.pop(context);

                if (isPermanentDenied) {
                  SystemNavigator.pop();
                } else {
                  _getCurrentPosition();
                }
              },
            ),
          ],
        );
      },
    );
  }


  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


}
