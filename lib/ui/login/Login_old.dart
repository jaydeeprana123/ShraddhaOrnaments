import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/constant/network_constant.dart';
import 'package:shradha_design/fcm/firebase.dart';
import 'package:shradha_design/response/login/login_response.dart';
import 'package:shradha_design/ui/login/PassCode.dart';
import 'package:shradha_design/ui/widget/ForgotView.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/ui/widget/snack.dart';
import 'package:shradha_design/utils/page_transition.dart';
import 'package:shradha_design/utils/validation.dart';
import '../../app_theme.dart';
import '../../utils/my_icons.dart';
import 'loginBloc.dart';




class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();

}




class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver{

  final GlobalKey<ScaffoldState> scaffoldKey  = new GlobalKey<ScaffoldState>();


  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pswdFocus = FocusNode();


  TextEditingController _emailtroller;
  TextEditingController _pswdcontroller;


  LoginBloc bloc;

  @override
  void initState() {

   // WidgetsBinding.instance.addObserver(this);

    bloc=LoginBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    _emailtroller = new TextEditingController();
    _pswdcontroller = new TextEditingController();




    print("xxxxxxx  islive::"+NetworkContastant.isLive.toString());

    super.initState();

   // NotificationHandler().notConfig(context);






  }









  @override
  Widget build(BuildContext context) {

    double  screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      //backgroundColor: AppTheme.white,
      body: Stack(


        children: [



          Container(


            height: screenHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(

              image: DecorationImage(
                image: const AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.fill,

              ),

            ),


            child: Container(
              margin: EdgeInsets.only(right: 30,top: 65),

              alignment: Alignment.topRight,
              child: Image.asset(logo_home,fit: BoxFit.contain,height:  55),
            ),



          ),


          Container(
           // margin: EdgeInsets.only(top:40),
            padding: EdgeInsets.only(top:35),

           // height: screenHeight,
            alignment: Alignment.center,


            child: SingleChildScrollView(

              child: Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                    image: const AssetImage(login_bg),

                    fit: BoxFit.fill,

                  ),

                ),
                height: screenHeight-35,

                child: Column(

                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    SizedBox(
                      height: 50,
                      /*child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage("assets/images/curve.png"),
                        fit: BoxFit.fill,

                      ),

                    ),),*/

                    ),





                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(30),
                      //color: AppTheme.primary,

                      /*decoration: BoxDecoration(

                    image: DecorationImage(
                      image: const AssetImage("assets/images/curve.png"),
                      fit: BoxFit.fill,

                    ),

                  ),
*/


                      child: Stack(
                        children: [


                          Column(
                            children: [
                              SizedBox(height: 5,),
                              Text("Login",style: AppTheme.subtitle.copyWith(fontSize: 18,fontWeight: FontWeight.w500,color: AppTheme.white),),
                              SizedBox(height: 5,),

                              Image.asset(line_white,height: 15,),

                              SizedBox(height: 5,),

                              Theme(
                                data: new ThemeData(
                                  // primaryColor: Colors.grey,
                                  // primaryColorDark: Colors.red,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(top: 15,),
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
                                      hintText: 'Email',
                                      hintStyle: AppTheme.subtitle.copyWith(color: AppTheme.white),

                                      suffixIcon: Container(
                                        height: 15,
                                        child: Image.asset(user_login,),
                                      ),


                                    ),


                                    validator: (value) {
                                      if (value.isEmpty) {
                                        FocusScope.of(context).requestFocus(_emailFocus);
                                        return 'Please enter email';
                                      }
                                      return null;
                                    },
                                    controller:  _emailtroller,
                                    focusNode: _emailFocus,
                                    onFieldSubmitted: (term){
                                      _emailFocus.unfocus();
                                      FocusScope.of(context).requestFocus(_pswdFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,

                                  ),
                                ),
                              ),





                              const SizedBox(
                                height: 5,
                              ),



                              Theme(
                                data: new ThemeData(
                                  // primaryColor: Colors.grey,
                                  // primaryColorDark: Colors.red,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10,),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    color: AppTheme.white.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),

                                  ),

                                  child: TextFormField(
                                    style:  AppTheme.subtitle.copyWith(color: AppTheme.white),

                                    textAlign: TextAlign.start,

                                    obscureText: true,

                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 15),
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                      hintText: 'Password',
                                      hintStyle: AppTheme.subtitle.copyWith(color: AppTheme.white),
                                      suffixIcon: Container(
                                        height: 10,
                                        child: Image.asset(pasw_login),
                                      ),


                                    ),


                                    controller: _pswdcontroller,

                                    focusNode: _pswdFocus,
                                    onFieldSubmitted: (term){
                                      _pswdFocus.unfocus();
                                      //FocusScope.of(context).requestFocus(_pswdCFocus);
                                    },


                                    keyboardType: TextInputType.text,

                                    //inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[\\,|\\-|\\ ]'))],
                                    // inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[ -]'))],

                                    textInputAction: TextInputAction.next,
                                    //keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),

                                  ),
                                ),
                              ),






                              SizedBox(
                                height: 15,
                              ),


                              Row(
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
                                          side: BorderSide(color: AppTheme.primarydark, width: 2.0,)),
                                      onPressed: () {



                                        login();




                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 25,right: 25,top:5,bottom: 5),
                                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                        child: Text("LOGIN",style: AppTheme.subtitle.copyWith(fontSize: 18,color: AppTheme.primarydark,fontWeight: FontWeight.w600) ,textAlign: TextAlign.right,),
                                      ),

                                    ),
                                  )),

                                ],
                              ),




                              SizedBox(
                                height: 10,
                              ),


                              Padding(
                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                child: InkWell(
                                  onTap: (){

                                    //showForgotDialog(scaffoldKey,context,true);


                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotView(isForgotPassw: true,)),);
                                    //PageTransition.createRoutedata(context,"RegisterScreen",null);


                                  },
                                  child: Center(
                                    child: Text("Forgot Password",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontSize: 16,decoration: TextDecoration.underline,)),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 5,bottom: 5),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text("Don't have account ",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontSize: 16,)),


                                      InkWell(
                                        onTap: (){
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()),);
                                          PageTransition.createRoutedata(context,"RegisterScreen",null);

                                        },
                                        child: Text("Sign Up",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontSize: 16,decoration: TextDecoration.underline,)),
                                      ),





                                    ],
                                  ),
                                ),
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

          ),





        ],

      ),
    );
  }



  bool validdata(){

    if(_emailtroller.text!=""){
      if(Validation.validateEmail(_emailtroller.text.trim() )){
        if(_pswdcontroller.text!=""){
          return true;
        }else{

          _pswdFocus.requestFocus();
          showInSnackBar("Please enter password");
          return false;
        }
      }else{

        _emailFocus.requestFocus();
        showInSnackBar("Please enter valid email ");
        return false;
      }

    }else{
      _emailFocus.requestFocus();
      showInSnackBar("Please enter email ");
      return false;
    }



  }


  login()async{



    if(validdata()) {



      Pr.show(context);

      Map<String, String> parms = new Map<String,String>();

      //parms.putIfAbsent("app_id",()=> "1");
      parms.putIfAbsent("email",()=> _emailtroller.text.trim());
      parms.putIfAbsent("password",()=> _pswdcontroller.text.trim());
      print('emailll' +   _emailtroller.text.toString());


      if(bloc.apiProvider.pref.getFCMToken()=="") {
        bloc.apiProvider.pref.setFcmTocken(await fcm.getToken());
      }

      parms.putIfAbsent("device_token",()=> bloc.apiProvider.pref.getFCMToken());

      LoginResponse response= await bloc.login(parms);


      Pr.hide(context);



      if(response!=null){

        if(response.statusCode==Constant.API_CODE){

          await bloc.apiProvider.pref.login(response);



          Navigator.push(context, MaterialPageRoute(builder: (context) => PasscodeScreen()),);



        }else{
          showInSnackBar(response.message[0]);
        }

      }



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








}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = AppTheme.primary;
    // create a path

   /* Path path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.height, size.height * 0.75, size.width, size.width * 0.30);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
*/


    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

