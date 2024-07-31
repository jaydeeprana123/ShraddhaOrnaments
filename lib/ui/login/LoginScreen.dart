
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../app_theme.dart';
import '../../utils/common_blue_button.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_icons.dart';



class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key key}) : super(key: key);

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {



  @override
  Widget build(BuildContext context) {
    final _EmailController = TextEditingController();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor:AppTheme.primary, // navigation bar color
      statusBarColor:bg_f3f5f9, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
      Brightness.light, //navigation bar icons' color
    ));
    return  SafeArea(

        child: Scaffold(
          backgroundColor: bg_f3f5f9,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding:  EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 12),
                        child: Image.asset(back_button),
                      ),

                      SizedBox(height: 26,),
                      // Log In
                      Text(
                          "Login",
                          style:  TextStyle(
                              color:  black_354356,
                              fontFamily: AppTheme.rubik,
                              fontStyle:  FontStyle.normal,
                              fontSize: 28
                          ),
                          textAlign: TextAlign.left
                      ),

                      SizedBox(height: 24,),
                      // Title
                      Text(
                          "Email",
                          style:  TextStyle(
                              color:  black_354356,
                              fontStyle:  FontStyle.normal,
                              fontSize: 14,
                            fontFamily: AppTheme.rubik
                          ),
                          textAlign: TextAlign.left
                      ),

                      SizedBox(height: 6,),

                      TextFormField(
                        style: AppTheme.subtitle.copyWith(color: AppTheme.white),
                        key:UniqueKey(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 15),
                          border: InputBorder.none,

                          // focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(18.0),borderSide: BorderSide(color: AppTheme.white, width: 1.0,)),
                          // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(18.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                          //  border: OutlineInputBorder(borderRadius:  BorderRadius.circular(18.0),borderSide: BorderSide(color: AppTheme.white, width: 1.0,)),
                          hintText: 'Email',
                          hintStyle: AppTheme.normalText.copyWith(color: AppTheme.white),

                          prefixIcon: Container(
                            height: 8,

                            child: Image.asset(user_login,),
                          ),


                        ),



                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,

                      ) ,

                      SizedBox(height: 20,),

                      // Title
                      Text(
                          "Password",
                          style:  TextStyle(
                              color:  black_354356,
                              fontStyle:  FontStyle.normal,
                              fontSize: 14,
                              fontFamily: AppTheme.rubik
                          ),
                          textAlign: TextAlign.left
                      ),

                      SizedBox(height: 6,),

                      TextFormField(
                        style: AppTheme.subtitle.copyWith(color: AppTheme.white),
                        key:UniqueKey(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 15),
                          border: InputBorder.none,

                          // focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(18.0),borderSide: BorderSide(color: AppTheme.white, width: 1.0,)),
                          // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(18.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                          //  border: OutlineInputBorder(borderRadius:  BorderRadius.circular(18.0),borderSide: BorderSide(color: AppTheme.white, width: 1.0,)),
                          hintText: 'Password',
                          hintStyle: AppTheme.subtitle.copyWith(color: AppTheme.white),

                          prefixIcon: Container(
                            height: 8,

                            child: Image.asset(user_login,),
                          ),


                        ),



                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,

                      ) ,
                      // SizedBox(height: 14,),
                      // // Hint text
                      // GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => const ForgotPasswordScreen(),
                      //         ));
                      //   },
                      //   child: Align(
                      //     alignment: Alignment.topRight,
                      //     child: Text(
                      //         "Forgot Password?",
                      //         style:  TextStyle(
                      //             color:  grey_969da8,
                      //             fontFamily: fontMavenProMedium,
                      //             fontSize: 14
                      //         ),
                      //         textAlign: TextAlign.right
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: 40,),

                      CommonBlueButton(
                          "Login",(){
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const LatestBottomNavigationScreen(),
                        //     ));
                      },blue_3653f6
                      ),
                      SizedBox(height: 40,),

                      // Don’t have an account? Register
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const RegisterScreen(),
                            //     ));
                          },
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        style:  TextStyle(
                                            color:  black_354356,
                                            fontFamily: AppTheme.rubik,
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 15,
                                          height: 1.2
                                        ),
                                        text: "Don’t have an account?"),
                                    TextSpan(
                                        style:  TextStyle(
                                            color:  Blue_5468ff,
                                            fontFamily:AppTheme.rubik,
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 15,
                                            height: 1.5
                                        ),
                                        text: "\nRegister")
                                  ]
                              )
                          ),
                        ),
                      ),



                    ],
                  ),
                ),




// This app is for restaurants, If you are customer Go to Customer App
                Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          children: [
                            TextSpan(
                                style:  TextStyle(
                                    color:  black_354356,
                                    fontFamily: AppTheme.rubik,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 14
                                ),
                                text: "This app is for restaurants, If you are customer"),
                            TextSpan(
                                style:  TextStyle(
                                    color:  sky_00d9cd,
                                    fontFamily: AppTheme.rubik,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 15,
                                  height: 1.5
                                ),
                                text: "\nGo to Customer App")
                          ]
                      )
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
