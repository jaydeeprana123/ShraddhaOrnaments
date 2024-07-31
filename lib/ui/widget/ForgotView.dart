import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/forgotpassword/for_got_password_response.dart';
import 'package:shradha_design/ui/login/loginBloc.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/ui/widget/snack.dart';
import 'package:shradha_design/utils/validation.dart';
import '../../app_theme.dart';
import '../../utils/my_icons.dart';







/*

showForgotDialog(GlobalKey<ScaffoldState> scaffoldKey,BuildContext context,bool isforgotPassword)async{


  var sheetController = scaffoldKey.currentState
      .showBottomSheet((context) => ForgotView(isForgotPassw: isforgotPassword));
  sheetController.closed.then((value) {
    print("closed");
  });
  
  
 */
/* showBottomSheet(
      //isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 4,
      context: context,
      builder: (context) {

        return ForgotView(isForgotPassw: isforgotPassword);

      }
    );
*//*

  

}
*/





class ForgotView extends StatefulWidget {


  final bool isForgotPassw;



  const ForgotView({Key key, this.isForgotPassw}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return ForgotViewState();
  }}


class ForgotViewState extends State<ForgotView> {



  TextEditingController _emailtroller;
  final FocusNode _emailFocus = FocusNode();


  LoginBloc _loginBloc ;


    @override
  void initState() {
    super.initState();

     _loginBloc = LoginBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient );

    _emailtroller = new TextEditingController();



    }


   


    @override
    Widget build(BuildContext context) {

      double  screenHeight = MediaQuery.of(context).size.height;

      return Scaffold(
        body: Stack(
          children: [

            Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: const AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.fill,

                ),

              ),


              //child: ,



            ),

            Container(
              alignment: Alignment.topCenter,
              height: 170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                     margin: EdgeInsets.only(top: 30),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/p_detail4.png',fit: BoxFit.fitHeight,height:  40),
                        ),
                      ),
                    ),
                  ),

                  Expanded(child: Container(
                    margin: EdgeInsets.only(right: 30,top: 65),

                    alignment: Alignment.topRight,
                    child: Image.asset(logo_home,fit: BoxFit.contain,height:  55),
                  )),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 80),
               // color: Colors.transparent,

                decoration: BoxDecoration(

                  image: DecorationImage(
                    image: const AssetImage(login_bg),

                    fit: BoxFit.fill,

                  ),

                ),


                //height: 250,
                child: ClipRRect(
                  //borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),

                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(30),
                    //color: AppTheme.primary,
                    child: Column(

                      children: <Widget>[


                       // _getAppBarUI(),

                        const SizedBox(
                          height: 20,
                        ),




                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [


                               /* Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                  children: [


                                    Text(widget.isForgotPassw?"Forgot Password":"Forgot Passcode",style: AppTheme.subtitle.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: AppTheme.white),),

                                    SizedBox(width: 5,),

                                    Container(height: 1,width: 100,color: AppTheme.white,)
                                  ],
                                ),
                                ),
*/
                                Text(widget.isForgotPassw?"Forgot Password":"Forgot Passcode",style: AppTheme.subtitle.copyWith(fontSize: 18,fontWeight: FontWeight.w500,color: AppTheme.white),),
                                SizedBox(height: 5,),

                                Image.asset(line_white,height: 15,),

                                SizedBox(height: 5,),



                                Theme(
                                    data: new ThemeData(
                                      // primaryColor: Colors.grey,
                                      // primaryColorDark: Colors.red,
                                    ),
                                    child:Container(
                                      margin: EdgeInsets.only(top: 15,left: 10,right: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppTheme.white.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),

                                      ),

                                      child: TextFormField(
                                        style: AppTheme.subtitle.copyWith(color: AppTheme.white),
                                        //key:UniqueKey(),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 15),
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                          // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                          //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),
                                          hintText: 'Enter Your Email',
                                          hintStyle: AppTheme.subtitle.copyWith(color: AppTheme.white),
                                          /*
                            labelStyle: AppTheme.subtitle.copyWith(color: AppTheme.white),
*/
                                          suffixIcon: Container(
                                            height: 15,
                                            child: Image.asset('assets/images/sign_up_icon_3.png',),
                                          ),


                                        ),


                                        validator: (value) {
                                          if (value.isEmpty) {
                                            // FocusScope.of(context).requestFocus(_emailFocus);
                                            return 'Please enter email';
                                          }
                                          return null;
                                        },
/*
                      onChanged: (String value) {
                        _shFnamecontroller.text = value;

                      },*/
                                        controller:  _emailtroller,
                                        focusNode: _emailFocus,
                                        onFieldSubmitted: (term){
                                          _emailFocus.unfocus();
                                          // FocusScope.of(context).requestFocus(_pswdFocus);
                                        },
                                        obscureText: false,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,

                                      ),
                                    ),
                                ),







                                const SizedBox(
                                  height: 10,
                                ),






                                Container(
                                  height: 45,
                                  margin: EdgeInsets.all(10),
                                  // padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                                  child: Row(
                                    children: [
                                      Expanded(child: Container(

                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(24.0)),


                                        ),
                                        //color: AppTheme.white,
                                        padding: EdgeInsets.all(4),
                                        child: MaterialButton(
                                          color: AppTheme.white,

                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(24),
                                              side: BorderSide(color: AppTheme.primarydark, width: 2.0,)),
                                          onPressed: () {



                                            login();




                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 25,right: 25,top:5,bottom: 5),
                                            padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                                            child: Text("Submit",style: AppTheme.subtitle.copyWith(color: AppTheme.primarydark,fontWeight: FontWeight.w600,fontSize: 16) ,textAlign: TextAlign.right,),
                                          ),

                                        ),
                                      )),

                                    ],
                                  ),
                                ),





                              ],
                            ))



                      ],
                    ),


                  ),
                )

            ),






          ],

        ),
      );




    }




    /*Widget _getAppBarUI() {
      return Container(
        decoration: BoxDecoration(
          color: AppTheme.primary,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 4.0),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 8, right: 8),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: AppBar().preferredSize.height + 40,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.close, color: Colors.white,),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(widget.isForgotPassw?"Forgot Password":"Forgot Passcode" ,style: TextStyle(fontFamily: AppTheme.fontName2,color: AppTheme.white,fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                width: AppBar().preferredSize.height + 40,
                height: AppBar().preferredSize.height,
              )
            ],
          ),
        ),
      );
    }
*/


   
    
    














    void _showInSnackBar(String value) {

      LogCustom.logd("xxxxxx: network snackbar :");
      Snack.showS(context, value);




    }




  bool validdata(){

    if(_emailtroller.text!=""){
      if(Validation.validateEmail(_emailtroller.text.trim())){
          return true;

      }else{
        showInSnackBar("Please enter valid email ");
        return false;
      }

    }else{
      showInSnackBar("Please enter email ");
      return false;
    }



  }




  login()async{



    if(validdata()) {



      Pr.show(context);

      Map<String, String> parms = new Map<String,String>();

      parms.putIfAbsent("email",()=> _emailtroller.text.trim());

      ForGotPasswordResponse response= await _loginBloc.forgotPassw(parms,widget.isForgotPassw);

      Pr.hide(context);


      if(response!=null){

        if(response.statusCode==Constant.API_CODE){
          showInSnackBar("Please check your email inbox");
        }else{
          showInSnackBar("Invalid email address");
        }

      }

      Navigator.pop(context);


    }


  }





  void showInSnackBar(String value) {

    LogCustom.logd("xxxxxx: network snackbar :");
    Snack.showS(context, value);

  }





  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();


    // WidgetsBinding.instance.removeObserver(this);
    PaintingBinding.instance.imageCache.clear();

  }








}