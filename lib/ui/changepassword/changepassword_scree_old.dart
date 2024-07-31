import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/login/login_response.dart';
import 'package:shradha_design/ui/login/loginBloc.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/app_theme.dart';
import 'package:shradha_design/ui/widget/snack.dart';


class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordScreenState createState() {
    return ChangePasswordScreenState();
  }
}



class ChangePasswordScreenState extends State<ChangePasswordScreen>  with TickerProviderStateMixin  {



  //final GlobalKey<ScaffoldState> _scaffoldKey  = new GlobalKey<ScaffoldState>();


  TextEditingController oldPswdcontroller;
  TextEditingController pswdcontroller;
  TextEditingController confirmPswdcontroller;

  final FocusNode _oldPswdFocus = FocusNode();
  final FocusNode _pswdFocus = FocusNode();
  final FocusNode _pswdCFocus = FocusNode();

  LoginBloc bloc;

  final formGlobalKey = GlobalKey < FormState > ();


  Future<bool> _getDelayed() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 10));
    return true;
  }








  @override
  void initState() {

    LogCustom.logd("xxxxxxxxxx  home page initState");

    bloc=LoginBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient);


    oldPswdcontroller = new TextEditingController();
    pswdcontroller = new TextEditingController();
    confirmPswdcontroller = new TextEditingController();


    callApi();






    super.initState();



  }






  void callApi(){

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

                   /* decoration: BoxDecoration(

                      image: DecorationImage(
                        image: const AssetImage("assets/images/bg.jpg"),
                        fit: BoxFit.fill,

                      ),

                    ),
*/
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
          )



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
              Text("Change Password",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

              Image.asset('assets/images/home_line.png',height: 10,),

            ],
          ),
        ),

        SizedBox(
          height: 15,
        ),


        Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [


               /* Center(
                  child: Text("Make sure you remember your existing Password and enter new password",style: AppTheme.subtitle.copyWith(color: AppTheme.black,fontSize: 18),),
                ),
*/

                SizedBox(
                  height: 20,
                ),




              Theme(
                data: new ThemeData(
                 // primaryColor: Colors.grey,
                 // primaryColorDark: Colors.red,
                ),
                child: Container(
                  // color: AppTheme.white,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border.all(color: AppTheme.gray_400, width: 1,),
                      borderRadius: BorderRadius.circular(24.0)
                  ),


                  child: TextFormField(
                    //key:UniqueKey(),
                    decoration: InputDecoration(

                      prefixIcon: Container(
                        padding: EdgeInsets.all(4),
                        child: Image.asset('assets/images/p_lock_new.png',height: 10,),
                      ),

                      contentPadding: const EdgeInsets.only(left: 25.0,right: 5,top: 15),
                     // border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),

                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                     // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),
                      hintText: 'Enter Old Password',


                    ),

                    controller: oldPswdcontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        // FocusScope.of(context).requestFocus(_oldPswdFocus);
                        return 'Please enter old password';
                        // return 'Please enter old password';
                      }
                      return null;
                    },

                    focusNode: _oldPswdFocus,
                    onFieldSubmitted: (term){
                      _oldPswdFocus.unfocus();
                      FocusScope.of(context).requestFocus(_pswdFocus);
                    },

                    obscureText: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,

                  ),
                ),
              ),





                const SizedBox(
                  height: 10,
                ),




                Theme(
                  data: new ThemeData(
                    // primaryColor: Colors.grey,
                    // primaryColorDark: Colors.red,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        border: Border.all(color: AppTheme.gray_400, width: 1,),
                        borderRadius: BorderRadius.circular(24.0)
                    ),

                    child: TextFormField(
                      //key:UniqueKey(),
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: EdgeInsets.all(4),
                          child: Image.asset('assets/images/p_lock_new.png',height: 10,),
                        ),

                        contentPadding: const EdgeInsets.only(left: 25.0,right: 5,top: 15),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                        // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                        //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                        /* border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),*/
                        hintText: 'Enter New Password',


                      ),

                      //initialValue: root.minHeight,
                      controller: pswdcontroller,

                      validator: (value) {
                        if (value.isEmpty) {
                          //  FocusScope.of(context).requestFocus(_pswdFocus);
                          return 'Please enter password';
                        }
                        return null;
                      },

                      focusNode: _pswdFocus,
                      onFieldSubmitted: (term){
                        _pswdFocus.unfocus();
                        FocusScope.of(context).requestFocus(_pswdCFocus);
                      },

                      obscureText: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,

                    ) ,
                  ),
                ),





                const SizedBox(
                  height: 10,
                ),




                Theme(
                  data: new ThemeData(
                    // primaryColor: Colors.grey,
                    // primaryColorDark: Colors.red,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        border: Border.all(color: AppTheme.gray_400, width: 1,),
                        borderRadius: BorderRadius.circular(24.0)
                    ),

                    child: TextFormField(
                      //key:UniqueKey(),
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: EdgeInsets.all(4),
                          child: Image.asset('assets/images/p_lock_new.png',height: 10,),
                        ),

                        contentPadding: const EdgeInsets.only(left: 25.0,right: 5,top: 15),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                        // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                        //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),
                        // hintText: "Confirm Password",
                        hintText: 'Confirm Password',


                      ),

                      //initialValue: root.minHeight,
                      controller: confirmPswdcontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          // FocusScope.of(context).requestFocus(_pswdCFocus);
                          return 'Please enter confirm password';
                        }else if(pswdcontroller.text!=value){

                          //FocusScope.of(context).requestFocus(_pswdCFocus);
                          return 'Password do not match!';
                        }
                        return null;
                      },


                      focusNode: _pswdCFocus,
                      onFieldSubmitted: (term){
                        _pswdCFocus.unfocus();
                        // FocusScope.of(context).requestFocus(_pswdCFocus);
                      },

                      obscureText: true,
                      //keyboardType: TextInputType.number,
                      keyboardType: TextInputType.text,
                      // inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[ -]'))],
                      textInputAction: TextInputAction.next,

                    ),

                  ),
                ),










                SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(1.0)),

                      ),
                      //color: AppTheme.white,
                      padding: EdgeInsets.all(2),
                      child: MaterialButton(
                        color: AppTheme.primary,

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                            //side: BorderSide(color: AppTheme.white, width: 1.0,)
                        ),
                        onPressed: () {


                         // formGlobalKey.currentState.validate();

                          if(validate()){

                            login();
                          }

                          //  login();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageFragment()),);



                        },
                        child: Container(
                          //margin: EdgeInsets.only(left: 25,right: 25,top:5,bottom: 5),
                          padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Text("Change Password",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontWeight: FontWeight.w500,fontSize: 16)),
                        ),

                      ),
                    )),

                  ],
                ),




              ],
            ),
          )
        ),



      ],
    ),
  );

}










bool validate(){


    if(oldPswdcontroller.text.isNotEmpty){

      if(pswdcontroller.text.isNotEmpty){

       if(confirmPswdcontroller.text.isNotEmpty){

           if(confirmPswdcontroller.text.toString()==pswdcontroller.text.toString()){

             return true;

           }else{

             _pswdCFocus.requestFocus();
             showInSnackBar("Password dose not match");
             return false;
           }

         }else{

         _pswdCFocus.requestFocus();

         showInSnackBar("Enter confirm password");
         return false;
       }

      }else{

        _pswdFocus.requestFocus();
        showInSnackBar("Enter new password");
        return false;
      }
      }else{

      _oldPswdFocus.requestFocus();
      showInSnackBar("Enter old password");
      return false;
    }

}





  void callSerachApi(String msg){
     // _bloc.getSearch(msg);
  }







  login()async{



      Map<String, String> parms = new Map<String,String>();

      //parms.putIfAbsent("app_id",()=> "1");
      parms.putIfAbsent("id",()=> bloc.apiProvider.pref.getUserId());
      parms.putIfAbsent("old_password",()=> oldPswdcontroller.text.trim());
      parms.putIfAbsent("password",()=> pswdcontroller.text.trim());
      parms.putIfAbsent("password_confirmation",()=> confirmPswdcontroller.text.trim());





      LoginResponse response= await bloc.changePassword(parms);


      if(response!=null){

        if(response.statusCode==Constant.API_CODE){

          await bloc.apiProvider.pref.login(response);

          showInSnackBar("Password changed successfully!");

          Navigator.pop(context);



        }else{
          showInSnackBar(response.message[0]);
        }

      }





  }






  void showInSnackBar(String value) {

    LogCustom.logd("xxxxxx: network snackbar :");
    Snack.showS(context, value);





  }







  @override
  void dispose() {
    LogCustom.logd("xxxxxxxxxx  home page dispose");
    // WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }






















}



