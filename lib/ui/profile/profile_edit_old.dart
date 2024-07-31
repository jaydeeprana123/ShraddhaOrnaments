import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/constant/network_constant.dart';
import 'package:shradha_design/response/login/login_response.dart';
import 'package:shradha_design/ui/profile/profileBloc.dart';
import 'package:shradha_design/ui/widget/common_scaffold.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/ui/widget/snack.dart';
import 'package:shradha_design/utils/utils.dart';
import 'package:shradha_design/utils/validation.dart';
import '../../app_theme.dart';
import 'package:http_parser/http_parser.dart';




class RegisterUpdateScreen extends StatefulWidget {
  @override
  _RegisterUpdateScreenState createState() => new _RegisterUpdateScreenState();

}




class _RegisterUpdateScreenState extends State<RegisterUpdateScreen> with WidgetsBindingObserver{



  final FocusNode _fNmaeFocus = FocusNode();
  final FocusNode _lNmaeFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  final FocusNode _companyFocus = FocusNode();
  final FocusNode _gstFocus = FocusNode();
  final FocusNode _add1Focus = FocusNode();
  final FocusNode _add2Focus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();



  final formGlobalKey = GlobalKey < FormState > ();

  ProfileBloc bloc;



  @override
  void initState() {

   // WidgetsBinding.instance.addObserver(this);
    bloc=ProfileBloc(apiProvider:BlocProvider.of<AppBloc>(context).appRepository.apiClient);



    bloc.fNamecontroller = new TextEditingController();
    bloc.lNamecontroller = new TextEditingController();
    bloc.emailtroller = new TextEditingController();
    bloc.phonetroller = new TextEditingController();
   // bloc.pswdcontroller = new TextEditingController();
    bloc.datecontrolar = new TextEditingController();


    bloc.companycontroller = new TextEditingController();
    bloc.gstcontroller = new TextEditingController();
    bloc.address1controller = new TextEditingController();
    bloc.address2controller = new TextEditingController();
    bloc.citycontroller = new TextEditingController();
    bloc.statecontroller = new TextEditingController();
    bloc.countrycontroller = new TextEditingController();




    print("xxxxxxx  islive::"+NetworkContastant.isLive.toString());

    super.initState();

    callApi();



  }




callApi()async{


  await bloc.getuser();

  setState(() {

  });

}




  @override
  Widget build(BuildContext context) {

    double  screenHeight = MediaQuery.of(context).size.height;



    if(imagesLoad!=null)LogCustom.logd("xxxxxxx image loaded build :"+imagesLoad.path);



    return CommonScaffold(
      //scaffoldKey: _scaffoldKey,
      backGroundColor: AppTheme.bg,
      showDrawer: false,
      showFAB: false,
      bodyData: Scaffold(
        backgroundColor: AppTheme.bg,
        body: Stack(


          children: [







            Container(
             // margin: EdgeInsets.only(top:40),
              //padding: EdgeInsets.only(top:50),

              height: screenHeight,
              alignment: Alignment.center,

              child: SingleChildScrollView(

                child: Column(

                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[








                    Container(
                      padding: EdgeInsets.all(10),



                      child: Stack(
                        children: [

                          Form(
                            key: formGlobalKey,
                            child: Column(
                              children: [



                                Container(
                                  // padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(left:10,right:10),

                                  child: Column(
                                    children: [




                                      Center(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Edit Profile",style: AppTheme.subtitlequicksandsemibold.copyWith(fontSize: 18),),

                                            Image.asset('assets/images/home_line.png',height: 10,),

                                          ],
                                        ),
                                      ),



                                      SizedBox(
                                        height: 20,
                                      ),



                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.all(5),
                                        child: Text("Personal Information",style: AppTheme.subtitle.copyWith(color: AppTheme.black,fontSize: 18,fontWeight: FontWeight.w500),),
                                      ),


                                      Row(
                                        children: [


                                          Expanded(
                                            child: Column(
                                              children: [



                                                Theme(
                                                  data: new ThemeData(
                                                    // primaryColor: Colors.grey,
                                                    // primaryColorDark: Colors.red,
                                                  ),
                                                  child: Container(
                                                    height: 45,
                                                    margin: EdgeInsets.only(top: 10,),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: AppTheme.white,
                                                        border: Border.all(color: AppTheme.gray_400, width: 1,),
                                                        borderRadius: BorderRadius.circular(24.0)
                                                    ),

                                                    child: TextFormField(
                                                      //key:UniqueKey(),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                                        // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                                        //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                                        hintText: 'First Name',
                                                        contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                                        prefixIcon: Container(
                                                          padding: EdgeInsets.all(5),
                                                          //height: 4,
                                                          width: 5,
                                                          child: Image.asset('assets/images/p_user.png',),
                                                        ),


                                                      ),

                                                      validator: (value) {
                                                        if (value.isEmpty) {

                                                          return 'Please enter first name';
                                                        }
                                                        return null;
                                                      },



                                                      controller:  bloc.fNamecontroller,
                                                      focusNode: _fNmaeFocus,
                                                      onFieldSubmitted: (term){
                                                        _fNmaeFocus.unfocus();
                                                        FocusScope.of(context).requestFocus(_lNmaeFocus);
                                                      },
                                                      obscureText: false,
                                                      keyboardType: TextInputType.text,
                                                      textInputAction: TextInputAction.next,
                                                      inputFormatters: [new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),],
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

                                                    height: 45,
                                                    margin: EdgeInsets.only(top: 10,),
                                                    alignment: Alignment.center,

                                                    decoration: BoxDecoration(
                                                        color: AppTheme.white,
                                                        border: Border.all(color: AppTheme.gray_400, width: 1,),
                                                        borderRadius: BorderRadius.circular(24.0)
                                                    ),

                                                    child: TextFormField(
                                                      //key:UniqueKey(),
                                                      decoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                                        prefixIcon: Container(
                                                          padding: EdgeInsets.all(5),
                                                          //height: 4,
                                                          width: 5,
                                                          child: Image.asset('assets/images/p_user.png',),
                                                        ),

                                                        border: InputBorder.none,
                                                        focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                                        // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                                        //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                                        hintText: 'Last Name',


                                                      ),

                                                      validator: (value) {
                                                        if (value.isEmpty) {

                                                          return 'Please enter last name';
                                                        }
                                                        return null;
                                                      },


                                                      controller:  bloc.lNamecontroller,
                                                      focusNode: _lNmaeFocus,
                                                      onFieldSubmitted: (term){
                                                        _lNmaeFocus.unfocus();
                                                        FocusScope.of(context).requestFocus(_emailFocus);
                                                      },
                                                      obscureText: false,
                                                      keyboardType: TextInputType.text,
                                                      textInputAction: TextInputAction.next,
                                                      inputFormatters: [new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),],
                                                    ),
                                                  ),
                                                ),






                                              ],
                                            ),
                                          ),


                                          SizedBox(width: 5,),

                                          Center(
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 101,
                                              // height: 101,
                                              child: Column(
                                                children: [

                                                  Container(
                                                    color: AppTheme.white,
                                                    padding: EdgeInsets.all(2),

                                                    child:  (imagesLoad!=null && imagesLoad.path!="")?

                                                    ClipRRect(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        child: Image.file(File(imagesLoad.path), height: 90, )
                                                    )
                                                        : CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      imageUrl:bloc.image,
                                                      height: 90,
                                                     // width: 90,
                                                      errorWidget: (context, url, error) => Icon(Icons.person,size:90),
                                                      placeholder: (context, url) => Icon(Icons.person,size:90),
                                                    ),

                                                  ),




                                                  Row(
                                                    children: [
                                                      Expanded(child: InkWell(
                                                        onTap: () {
                                                          selectImage(context);
                                                        },

                                                        child: Container(

                                                          alignment: Alignment.center,
                                                          margin: EdgeInsets.all(3),
                                                          padding: EdgeInsets.all(3),
                                                          color: AppTheme.primary,
                                                          child: Text("Change Pic",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontSize: 12),),
                                                        ),
                                                      ))
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),


                                        ],
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
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),

                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.all(5),
                                                //height: 4,
                                                width: 5,
                                                child: Image.asset('assets/images/p_email.png',),
                                              ),

                                              border: InputBorder.none,
                                                focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                                // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                                //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'Email',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {

                                                return 'Please enter email';
                                              }else if (!Validation.validateEmail(value)) {
                                                return 'Please enter valid email';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.emailtroller,
                                            focusNode: _emailFocus,
                                            onFieldSubmitted: (term){
                                              _emailFocus.unfocus();
                                              FocusScope.of(context).requestFocus(_phoneFocus);
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
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),

                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(

                                                padding: EdgeInsets.all(2),
                                                //height: 4,
                                                //width: 3,
                                                child: Image.asset('assets/images/p_phone.png',),
                                              ),
                                              border: InputBorder.none,
                                                      focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'Phone',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {
                                                FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter phone';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.phonetroller,
                                            focusNode: _phoneFocus,
                                            onFieldSubmitted: (term){
                                              _phoneFocus.unfocus();
                                              // FocusScope.of(context).requestFocus(_);
                                            },
                                            obscureText: false,
                                            keyboardType: TextInputType.phone,
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
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),

                                          child: InkWell(

                                            onTap: (){

                                              _selectDate(context);

                                            },
                                            child: TextFormField(

                                              obscureText: false,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                                prefixIcon: Container(

                                                  padding: EdgeInsets.all(0),
                                                  //height: 4,
                                                  width: 4,
                                                  child: Image.asset('assets/images/p_dob.png',width: 3,height: 5,),
                                                ),
                                                border: InputBorder.none,
                                                  focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                                  // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                                  //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                                hintText: 'DOB',


                                              ),
                                              // enabled: false,
                                              controller:  bloc.datecontrolar,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  // FocusScope.of(context).requestFocus(_phoneFocus);
                                                  return 'Please select date';
                                                }
                                                return null;
                                              },

                                              readOnly: true,
                                              onTap: (){
                                                _selectDate(context);
                                              },


                                              keyboardType: TextInputType.text,

                                              //inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[\\,|\\-|\\ ]'))],
                                              // inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[ -]'))],

                                              textInputAction: TextInputAction.next,
                                              //keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),

                                            ),

                                          ),
                                        ),
                                      ),




                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Divider(),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.all(5),
                                        child: Text("Company Details",style: AppTheme.subtitle.copyWith(color: AppTheme.black,fontSize: 18,fontWeight: FontWeight.w500),),
                                      ),


                                      Theme(
                                        data: new ThemeData(
                                          // primaryColor: Colors.grey,
                                          // primaryColorDark: Colors.red,
                                        ),
                                        child: Container(
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),

                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.all(5),
                                                //height: 4,
                                                width: 5,
                                                child: Image.asset('assets/images/p_cname.png',),
                                              ),

                                              border: InputBorder.none,
                                              focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                              // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                              //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'Company Name',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {
                                                // FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter Company Name';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.companycontroller,
                                            focusNode: _companyFocus,
                                            onFieldSubmitted: (term){
                                              _companyFocus.unfocus();
                                              FocusScope.of(context).requestFocus(_add1Focus);
                                            },
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
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
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),
                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.all(5),
                                                height: 3,
                                                width: 4,
                                                child: Image.asset('assets/images/p_address.png',),
                                              ),

                                              border: InputBorder.none,
                                              focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                            // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                            //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'Address Line 1',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {
                                                //  FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter address';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.address1controller,
                                            focusNode: _add1Focus,
                                            onFieldSubmitted: (term){
                                              _add1Focus.unfocus();
                                              FocusScope.of(context).requestFocus(_add2Focus);
                                            },
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
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
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),
                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.all(5),
                                                height: 4,
                                                width: 4,
                                                child: Image.asset('assets/images/p_address.png',),
                                              ),

                                              border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                            // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                            //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'Address Line 2',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {
                                                // FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter address';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.address2controller,
                                            focusNode: _add2Focus,
                                            onFieldSubmitted: (term){
                                              _add2Focus.unfocus();
                                              FocusScope.of(context).requestFocus(_gstFocus);
                                            },
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
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
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),

                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.all(5),
                                                height: 4,
                                                width: 4,
                                                child: Image.asset('assets/images/p_gst.png',),
                                              ),

                                                border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                            // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                            //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'GST',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {
                                                //  FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter GST';
                                              }else  if (value.length >15 && value.length<15) {
                                                //  FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter valid GST';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.gstcontroller,
                                            focusNode: _gstFocus,
                                            onFieldSubmitted: (term){
                                              _gstFocus.unfocus();
                                              FocusScope.of(context).requestFocus(_cityFocus);
                                            },
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
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
                                        child:  Container(
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),
                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.all(5),
                                                height: 4,
                                                width: 4,
                                                child: Image.asset('assets/images/p_state.png',),
                                              ),

                                              border: InputBorder.none,
                                             focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                            // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                            //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'City',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {
                                                // FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter city';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.citycontroller,
                                            focusNode: _cityFocus,
                                            onFieldSubmitted: (term){
                                              _cityFocus.unfocus();
                                              FocusScope.of(context).requestFocus(_stateFocus);
                                            },
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
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
                                        child:  Container(
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),
                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.all(5),
                                                height: 4,
                                                width: 4,
                                                child: Image.asset('assets/images/p_state.png',),
                                              ),

                                              border: InputBorder.none,
                                            focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                            // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                            //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'State',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {
                                                // FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter state';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.statecontroller,
                                            focusNode: _stateFocus,
                                            onFieldSubmitted: (term){
                                              _stateFocus.unfocus();
                                              FocusScope.of(context).requestFocus(_countryFocus);
                                            },
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,
                                            inputFormatters: [new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),],
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
                                        child:  Container(
                                          height: 45,
                                          margin: EdgeInsets.only(top: 10,),
                                          alignment: Alignment.center,
                                          // color: AppTheme.edit_bg,

                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(color: AppTheme.gray_400, width: 1,),
                                              borderRadius: BorderRadius.circular(24.0)
                                          ),

                                          child: TextFormField(
                                            //key:UniqueKey(),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only(left: 20.0,right: 5,top: 10),
                                              prefixIcon: Container(
                                                padding: EdgeInsets.all(5),
                                                //height: 4,
                                                width: 5,
                                                child: Image.asset('assets/images/p_country.png',),
                                              ),

                                              border: InputBorder.none,
                                              focusedBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.red, width: 1.0,)),
                                              // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 1.0,)),
                                              //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(24.0),),

                                              hintText: 'Country',


                                            ),


                                            validator: (value) {
                                              if (value.isEmpty) {
                                                // FocusScope.of(context).requestFocus(_phoneFocus);
                                                return 'Please enter country';
                                              }
                                              return null;
                                            },
                                            controller:  bloc.countrycontroller,
                                            focusNode: _countryFocus,
                                            onFieldSubmitted: (term){
                                              _countryFocus.unfocus();
                                              // FocusScope.of(context).requestFocus();
                                            },
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.next,
                                            inputFormatters: [new FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),],
                                          ),
                                        ),
                                      ),






                                      SizedBox(
                                        height: 20,
                                      ),



                                      Row(
                                        children: [
                                          Expanded(child: MaterialButton(
                                            color: AppTheme.primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                                side: BorderSide(color: AppTheme.primary, width: 1.0)),
                                            onPressed: () {




                                              if(validdata()){
                                                register();
                                              }

                                              //




                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 25,right: 25,top:5,bottom: 5),
                                              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                              child: Text("Update Profile",style: AppTheme.subtitle.copyWith(color: AppTheme.white,fontWeight: FontWeight.w500,fontSize: 16) ,textAlign: TextAlign.right,),
                                            ),

                                          )),

                                        ],
                                      ),





                                      SizedBox(
                                        height: 10,
                                      ),






                                    ],
                                  ),
                                ),






                              ],
                            ),
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




      ),
    );





  }







  bool validdata(){


    if(bloc.fNamecontroller.text!="") {
      if(bloc.lNamecontroller.text!="") {

          if (bloc.emailtroller.text != "") {
            if (Validation.validateEmail(bloc.emailtroller.text.trim())){
              if (bloc.phonetroller.text != "") {
                if(Validation.validateMobile(bloc.phonetroller.text.trim())) {


                  if (bloc.datecontrolar.text != "") {

                    if (bloc.companycontroller.text != "") {

                      if (bloc.address1controller.text != "") {

                        if (bloc.address2controller.text != "") {

                          if (bloc.gstcontroller.text != "") {

                            if (bloc.citycontroller.text != "") {

                              if (bloc.statecontroller.text != "") {

                                if (bloc.countrycontroller.text != "") {


                                  return true;

                                } else {

                                  _countryFocus.requestFocus();
                                  showInSnackBar("Please enter country");
                                  return false;
                                }


                              } else {
                                _stateFocus.requestFocus();
                                showInSnackBar("Please enter state");
                                return false;
                              }



                            } else {
                              _cityFocus.requestFocus();
                              showInSnackBar("Please enter city");
                              return false;
                            }

                          } else {
                            _gstFocus.requestFocus();
                            showInSnackBar("Please enter gst");
                            return false;
                          }


                        } else {

                          _add2Focus.requestFocus();
                          showInSnackBar("Please enter address line 2");
                          return false;
                        }


                      } else {
                        _add1Focus.requestFocus();
                        showInSnackBar("Please enter address");
                        return false;
                      }

                    } else {
                      _companyFocus.requestFocus();
                      showInSnackBar("Please enter company name");
                      return false;
                    }

                  } else {

                    showInSnackBar("Please enter birth date");
                    return false;
                  }

                } else {
                  _phoneFocus.requestFocus();
                  showInSnackBar("Please enter valid  phone");
                  return false;
                }
              }else {
                _phoneFocus.requestFocus();
                showInSnackBar("Please enter phone");
                return false;
              }
            } else {
              _emailFocus.requestFocus();
              showInSnackBar("Please enter valid email");
              return false;
            }

          } else {
            _emailFocus.requestFocus();
            showInSnackBar("Please enter email");
            return false;
          }

      }else {
        _lNmaeFocus.requestFocus();
        showInSnackBar("Please enter last name");
        return false;
      }
    }else {

      _fNmaeFocus.requestFocus();
      showInSnackBar("Please enter first name");
      return false;
    }


  }





  void showInSnackBar(String value) {

    LogCustom.logd("xxxxxx: network snackbar :");
    Snack.showS(context, value);


  }


  register()async{


    Pr.show(context);

    var formData = FormData();

   /* for(int i=0;i<images.length;i++){

      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();

      LogCustom.logd("xxxxxxxxxxxxxx file name::"+images[i].name);

      formData.files.add( MapEntry("image",   MultipartFile.fromBytes(imageData, filename: images[i].name, contentType:  MediaType('image', ''),)));

    }
*/


    if(imagesLoad!=null && imagesLoad.path!=""){

      String fileName = imagesLoad.path.split('/').last;

      LogCustom.logd("xxxxxxxxxxxxxx file name::"+fileName);

      formData.files.add( MapEntry("image",  await MultipartFile.fromFile(imagesLoad.path, filename: fileName, contentType:  MediaType('image', ''),)));

    }




    Map<String, String> parms = new Map<String,String>();

      parms.putIfAbsent("id",()=> bloc.apiProvider.pref.getUserId());
      parms.putIfAbsent("firstname",()=> bloc.fNamecontroller.text.trim());
      parms.putIfAbsent("lastname",()=> bloc.lNamecontroller.text.trim());
      parms.putIfAbsent("dob",()=> bloc.datecontrolar.text.trim());
      parms.putIfAbsent("email",()=> bloc.emailtroller.text.trim());
      parms.putIfAbsent("mobile",()=> bloc.phonetroller.text.trim());
      //parms.putIfAbsent("password",()=> bloc.pswdcontroller.text.trim());

      parms.putIfAbsent("company_name",()=> bloc.companycontroller.text.trim());
      parms.putIfAbsent("company_address_1",()=> bloc.address1controller.text.trim());
      parms.putIfAbsent("company_address_2",()=> bloc.address2controller.text.trim());
      parms.putIfAbsent("city",()=> bloc.citycontroller.text.trim());
      parms.putIfAbsent("state",()=> bloc.statecontroller.text.trim());
      parms.putIfAbsent("gstno",()=> bloc.gstcontroller.text.trim());
      parms.putIfAbsent("country",()=> bloc.countrycontroller.text.trim());
     // parms.putIfAbsent("security_code",()=> "789456");


    LoginResponse commonResponse = await   bloc.update(formData,parms);

    Pr.hide(context);


    if(commonResponse!=null && commonResponse.statusCode==Constant.API_CODE){

      await bloc.apiProvider.pref.login(commonResponse);


      Navigator.pop(context);



    }else if(commonResponse!=null){

      showInSnackBar(commonResponse.message[0]);
    }






  }




String date="";



  Future<String>  _selectDate(BuildContext context,) async {



    DateTime selectedDate;


    if(date!=""){
      selectedDate = DateTime.parse(Utils().getDeliveryDate(date));
    }else{
      selectedDate =DateTime.now();
    }



    selectedDate =DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      //initialDatePickerMode: DatePickerMode.day,
      lastDate: selectedDate,

    );
    if (picked != null && picked != selectedDate){
      setState(() {

        selectedDate = picked;
        date=Utils().setDeliveryDate(selectedDate);

      });

      LogCustom.logd("xxxxxxx selected date ::"+date);

    }else{
      return null;
    }

    // deliveryDate=Utils().setDeliveryDate(selectedDate);



    bloc.datecontrolar.text=date;

    return date;

  }






  selectImage(BuildContext context) async {
    return await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Option '),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(true);

                },
                child:  Container(padding: EdgeInsets.all(4),child: Text('Open Camera'),),
              ),

              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(false);

                },
                child: Container(padding: EdgeInsets.all(4),child:  Text('Open Gallery'),),
              ),

            ],
          );
        });
  }


  XFile imagesLoad;

  final ImagePicker _picker = ImagePicker();


  getImage(bool iscamera)async{





    try{

      if(iscamera){
        imagesLoad = await _picker.pickImage(source: ImageSource.camera);
      }else{
        imagesLoad = await _picker.pickImage(source: ImageSource.gallery);
      }

      LogCustom.logd("xxxxxxx image loaded :"+imagesLoad.path);

      setState(() {

      });

    }catch(e){

    }







  }




  /* List<Asset> images = List<Asset>();



  Future<void> _loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "ShraddhaDesign"),
        materialOptions: MaterialOptions(
          actionBarColor: "#FF010352",
          statusBarColor: "#FF010352",
          actionBarTitle: Constant.AppName,
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#FFB71C1C",
        ),
      );
    } on Exception catch (e) {

      LogCustom.logd("xxxxxx impage picker error" +e.toString());


    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;

    });



  }
*/



  @override
  void dispose() {

    LogCustom.logd("xxxxxxx dispose");

    PaintingBinding.instance.imageCache.clear();

    super.dispose();
  }








}

