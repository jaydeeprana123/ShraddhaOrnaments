import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shradha_design/appbloc/app_bloc.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/constant/network_constant.dart';
import 'package:shradha_design/response/login/login_response.dart';
import 'package:shradha_design/ui/widget/loader.dart';
import 'package:shradha_design/ui/widget/snack.dart';
import 'package:shradha_design/utils/my_icons.dart';
import 'package:shradha_design/utils/utils.dart';
import 'package:shradha_design/utils/validation.dart';
import '../../app_theme.dart';
import 'loginBloc.dart';
import 'package:http_parser/http_parser.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => new _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with WidgetsBindingObserver {
  final FocusNode _fNmaeFocus = FocusNode();
  final FocusNode _lNmaeFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pswdFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  final FocusNode _companyFocus = FocusNode();
  final FocusNode _gstFocus = FocusNode();
  final FocusNode _add1Focus = FocusNode();
  final FocusNode _add2Focus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();

  TextEditingController _fNamecontroller;
  TextEditingController _lNamecontroller;
  TextEditingController _emailtroller;
  TextEditingController _pswdcontroller;
  TextEditingController _phonetroller;

  TextEditingController _companycontroller;
  TextEditingController _gstcontroller;
  TextEditingController _address1controller;
  TextEditingController _address2controller;
  TextEditingController _citycontroller;
  TextEditingController _statecontroller;
  TextEditingController _countrycontroller;
  TextEditingController _datecontrolar;
  final formGlobalKey = GlobalKey<FormState>();

  LoginBloc bloc;

  String image = "";

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    bloc = LoginBloc(
        apiProvider: BlocProvider.of<AppBloc>(context).appRepository.apiClient);

    _fNamecontroller = new TextEditingController();
    _lNamecontroller = new TextEditingController();
    _emailtroller = new TextEditingController();
    _phonetroller = new TextEditingController();
    _pswdcontroller = new TextEditingController();
    _datecontrolar = new TextEditingController();

    _companycontroller = new TextEditingController();
    _gstcontroller = new TextEditingController();
    _address1controller = new TextEditingController();
    _address2controller = new TextEditingController();
    _citycontroller = new TextEditingController();
    _statecontroller = new TextEditingController();
    _countrycontroller = new TextEditingController();

    print("xxxxxxx  islive::" + NetworkContastant.isLive.toString());

    super.initState();

    // NotificationHandler().notConfig(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppTheme.bg,
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(28),
              // height: 200,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      back_arrow,
                      height: 18,
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(20),

                    child: Form(
                      key: formGlobalKey,
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 16,
                              ),

                              Text(
                                "Sign Up",
                                style: AppTheme.subtitleopensans.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.black_text),
                              ),

                              // Center(
                              //   child:  Container(margin: EdgeInsets.only(top: 20),child: Text("Sign Up",style: AppTheme.subtitleopensans.copyWith(fontSize: 18 ,fontWeight: FontWeight.w700,color: AppTheme.black_text),)),
                              // ),

                              // SizedBox(height: 5,),

                              //    Image.asset(line_white,height: 15,),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          (imagesLoad != null && imagesLoad.path != "")
                              ? InkWell(
                            onTap: () {
                              selectImage(context);
                            },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.file(File(
                                      imagesLoad.path,

                                    ),   height: 116,
                                        width: 116,
                                    fit: BoxFit.cover,) //AssetThumb( asset: images[0], width: 90,height: 90, )
                                    ),
                              )
                              : InkWell(
                            onTap: () {
                              selectImage(context);
                            },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(58),
                                    child: DottedBorder(
                                      dashPattern: [6, 3],
                                      strokeWidth: 1.5,
                                      color: AppTheme.black_800,
                                      borderType: BorderType.Circle,
                                      radius: Radius.circular(50),
                                      child: Container(
                                        height: 116,
                                        width: 116,
                                        decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppTheme.bg),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit_calendar),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("Add Photo",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff3e4046),
                                                    fontFamily:
                                                        AppTheme.poppinsRegular,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                          Container(
                            width: screenwidth,
                            color: AppTheme.bg,
                            margin: EdgeInsets.only(top: 12),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),
                                  child: TextFormField(
                                    //key:UniqueKey(),
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),

                                      hintText: 'First Name',
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 20,
                                        color: AppTheme.black_800,
                                      ),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter first name';
                                      }
                                      return null;
                                    },

                                    controller: _fNamecontroller,
                                    focusNode: _fNmaeFocus,
                                    onFieldSubmitted: (term) {
                                      _fNmaeFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_lNmaeFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      new FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z]")),
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    //key:UniqueKey(),
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),
                                      hintText: 'Last Name',

                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        size: 20,
                                        color: AppTheme.black_800,
                                      ),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter last name';
                                      }
                                      return null;
                                    },

                                    controller: _lNamecontroller,
                                    focusNode: _lNmaeFocus,
                                    onFieldSubmitted: (term) {
                                      _lNmaeFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_pswdFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,

                                    inputFormatters: [
                                      new FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z]")),
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),

                                    obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),

                                      prefixIcon: Container(
                                        padding: EdgeInsets.all(14),
                                        height: 4,
                                        width: 4,
                                        child: SvgPicture.asset(
                                          password,
                                          color: AppTheme.black_800,
                                          height: 16,
                                        ),
                                      ),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),
                                      hintText: 'Password',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        FocusScope.of(context)
                                            .requestFocus(_emailFocus);
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },

                                    controller: _pswdcontroller,

                                    focusNode: _pswdFocus,
                                    onFieldSubmitted: (term) {
                                      //  _pswdFocus.unfocus();
                                      // FocusScope.of(context).requestFocus(_cpswdFocus);
                                    },

                                    keyboardType: TextInputType.text,

                                    //inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[\\,|\\-|\\ ]'))],
                                    // inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[ -]'))],

                                    textInputAction: TextInputAction.next,
                                    //keyboardType: TextInputType.numberWithOptions(decimal: true,signed: false),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    //key:UniqueKey(),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 2, top: 15),
                                      prefixIcon: Icon(Icons.email,
                                          size: 20,
                                          color: AppTheme.black_800),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'Email',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter email';
                                      } else if (!Validation.validateEmail(
                                          value)) {
                                        return 'Please enter valid email';
                                      }
                                      return null;
                                    },
                                    controller: _emailtroller,
                                    focusNode: _emailFocus,
                                    onFieldSubmitted: (term) {
                                      _emailFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_phoneFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),


                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    //key:UniqueKey(),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Icon(Icons.phone,
                                          size: 20,
                                          color: AppTheme.black_800),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'Phone',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        FocusScope.of(context)
                                            .requestFocus(_phoneFocus);
                                        return 'Please enter phone';
                                      }
                                      return null;
                                    },
                                    controller: _phonetroller,
                                    focusNode: _phoneFocus,
                                    onFieldSubmitted: (term) {
                                      _phoneFocus.unfocus();
                                      //  FocusScope.of(context).requestFocus(_pswdFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: TextFormField(
                                      style: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.black_text),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 20.0, right: 5, top: 15),
                                        prefixIcon: Icon(
                                            Icons.date_range_outlined,
                                            size: 20,
                                            color: AppTheme.black_800),

                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: BorderSide(
                                              color: AppTheme.black_text,
                                              width: 0.5,
                                            )),
                                        // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                        //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                        hintText: 'Birth Date',
                                        hintStyle: AppTheme.subtitleopensans
                                            .copyWith(
                                                color:
                                                    AppTheme.hint_txt_798281,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      // enabled: false,
                                      controller: _datecontrolar,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          // FocusScope.of(context).requestFocus(_phoneFocus);
                                          return 'Please select date';
                                        }
                                        return null;
                                      },

                                      readOnly: true,
                                      onTap: () {
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

                                const SizedBox(
                                  height: 8,
                                ),

                                Divider(
                                  color: AppTheme.black_text.withOpacity(0.2),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    //key:UniqueKey(),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Icon(Icons.shopping_bag,
                                          size: 20,
                                          color: AppTheme.black_800),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'Company Name',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        // FocusScope.of(context).requestFocus(_phoneFocus);
                                        return 'Please enter Company Name';
                                      }
                                      return null;
                                    },
                                    controller: _companycontroller,
                                    focusNode: _companyFocus,
                                    onFieldSubmitted: (term) {
                                      _companyFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_add1Focus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),


                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    //key:UniqueKey(),
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Icon(Icons.maps_home_work,
                                          size: 20,
                                          color: AppTheme.black_800),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'Address Line 1',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        //  FocusScope.of(context).requestFocus(_phoneFocus);
                                        return 'Please enter address';
                                      }
                                      return null;
                                    },
                                    controller: _address1controller,
                                    focusNode: _add1Focus,
                                    onFieldSubmitted: (term) {
                                      _add1Focus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_add2Focus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    //key:UniqueKey(),
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Icon(Icons.location_on,
                                          size: 20,
                                          color: AppTheme.black_800),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'Address Line 2',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        // FocusScope.of(context).requestFocus(_phoneFocus);
                                        return 'Please enter address';
                                      }
                                      return null;
                                    },
                                    controller: _address2controller,
                                    focusNode: _add2Focus,
                                    onFieldSubmitted: (term) {
                                      _add2Focus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_gstFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),


                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    //key:UniqueKey(),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Container(
                                        padding: EdgeInsets.all(12),
                                        height: 4,
                                        width: 4,
                                        child: SvgPicture.asset(
                                          gst,
                                          color: AppTheme.black_800,
                                          height: 18,
                                        ),
                                      ),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'GST',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        //  FocusScope.of(context).requestFocus(_phoneFocus);
                                        return 'Please enter GST';
                                      } else if (value.length > 15 &&
                                          value.length < 15) {
                                        //  FocusScope.of(context).requestFocus(_phoneFocus);
                                        return 'Please enter valid GST';
                                      }
                                      return null;
                                    },
                                    controller: _gstcontroller,
                                    focusNode: _gstFocus,
                                    onFieldSubmitted: (term) {
                                      _gstFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_cityFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),


                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    //key:UniqueKey(),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Icon(
                                          Icons.location_city_outlined,
                                          size: 24,
                                          color: AppTheme.black_800),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'City',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        // FocusScope.of(context).requestFocus(_phoneFocus);
                                        return 'Please enter city';
                                      }
                                      return null;
                                    },
                                    controller: _citycontroller,
                                    focusNode: _cityFocus,
                                    onFieldSubmitted: (term) {
                                      _cityFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_stateFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),


                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    //key:UniqueKey(),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Container(
                                        padding: EdgeInsets.all(15),
                                        height: 4,
                                        width: 4,
                                        child: Image.asset(
                                            'assets/images/p_state.png',
                                            color: AppTheme.black_800),
                                      ),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'State',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        // FocusScope.of(context).requestFocus(_phoneFocus);
                                        return 'Please enter state';
                                      }
                                      return null;
                                    },
                                    controller: _statecontroller,
                                    focusNode: _stateFocus,
                                    onFieldSubmitted: (term) {
                                      _stateFocus.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(_countryFocus);
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      new FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z]")),
                                    ],
                                  ),
                                ),


                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 5),
                                  alignment: Alignment.center,
                                  // color: AppTheme.edit_bg,

                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppTheme.black_600),
                                  ),

                                  child: TextFormField(
                                    style: AppTheme.subtitleopensans
                                        .copyWith(color: AppTheme.black_text),
                                    //key:UniqueKey(),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 20.0, right: 5, top: 15),
                                      prefixIcon: Container(
                                        padding: EdgeInsets.all(15),
                                        //height: 4,
                                        width: 5,
                                        child: SvgPicture.asset(
                                          country,
                                          color: AppTheme.black_800,
                                        ),
                                      ),

                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide(
                                            color: AppTheme.black_text,
                                            width: 0.5,
                                          )),
                                      // enabledBorder: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),borderSide: BorderSide(color: AppTheme.gray_500, width: 0.5,)),
                                      //border: OutlineInputBorder(borderRadius:  BorderRadius.circular(12.0),),

                                      hintText: 'Country',
                                      hintStyle: AppTheme.subtitleopensans
                                          .copyWith(
                                              color: AppTheme.hint_txt_798281,
                                              fontWeight: FontWeight.w600),
                                    ),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        // FocusScope.of(context).requestFocus(_phoneFocus);
                                        return 'Please enter country';
                                      }
                                      return null;
                                    },
                                    controller: _countrycontroller,
                                    focusNode: _countryFocus,
                                    onFieldSubmitted: (term) {
                                      _countryFocus.unfocus();
                                      // FocusScope.of(context).requestFocus();
                                    },
                                    obscureText: false,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      new FilteringTextInputFormatter.allow(
                                          RegExp("[a-zA-Z]")),
                                    ],
                                  ),
                                ),


                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(
                                    top: 10,
                                      // left: 40,
                                      // right: 40,
                                      ),
                                  child: MaterialButton(
                                    color: AppTheme.black_grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: BorderSide(
                                            color: AppTheme.black_grey,
                                            width: 0.5)),
                                    onPressed: () {
                                      if (validdata()) {
                                        register();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        "Submit",
                                        style: AppTheme.subtitleopensans
                                            .copyWith(
                                                color: AppTheme.white,
                                                fontWeight: FontWeight.w100,
                                                fontSize: 14),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ),

                                // Row(
                                //   children: [
                                //     Expanded(child: Container(
                                //       height: 45,
                                //       decoration: BoxDecoration(
                                //         color: AppTheme.black_text,
                                //         borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                //
                                //       ),
                                //       //color: AppTheme.black_text,
                                //       padding: EdgeInsets.all(2),
                                //       child: MaterialButton(
                                //         color: AppTheme.black_text,
                                //
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius: BorderRadius.circular(12),
                                //             side: BorderSide(color: AppTheme.primarydark, width: 2.0,)),
                                //         onPressed: () {
                                //
                                //
                                //
                                //           if(validdata()){
                                //             register();
                                //           }
                                //
                                //
                                //
                                //
                                //         },
                                //         child: Container(
                                //           margin: EdgeInsets.only(left: 25,right: 25,top:5,bottom: 5),
                                //           padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                                //           child: Text("SIGN UP",style: AppTheme.subtitleopensans.copyWith(fontSize: 16,color: AppTheme.primarydark,fontWeight: FontWeight.w600) ,textAlign: TextAlign.right,),
                                //         ),
                                //
                                //       ),
                                //     )),
                                //
                                //   ],
                                // ),

                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }

  bool validdata() {
    if (_fNamecontroller.text != "") {
      if (_lNamecontroller.text != "") {
        if (_pswdcontroller.text != "") {
          if (_emailtroller.text != "") {
            if (Validation.validateEmail(_emailtroller.text.trim())) {
              if (_phonetroller.text != "") {
                if (Validation.validateMobile(_phonetroller.text.trim())) {
                  //  if (_datecontrolar.text != "") {

                  if (_companycontroller.text != "") {
                    if (_address1controller.text != "") {
                      if (_address2controller.text != "") {
                        if (_gstcontroller.text != "") {
                          if (_citycontroller.text != "") {
                            if (_statecontroller.text != "") {
                              if (_countrycontroller.text != "") {
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

                  /*} else {

                    showInSnackBar("Please enter birth date");
                    return false;
                  }
*/
                } else {
                  _phoneFocus.requestFocus();
                  showInSnackBar("Please enter valid  phone");
                  return false;
                }
              } else {
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
        } else {
          _pswdFocus.requestFocus();
          showInSnackBar("Please enter password");
          return false;
        }
      } else {
        _lNmaeFocus.requestFocus();
        showInSnackBar("Please enter last name");
        return false;
      }
    } else {
      _fNmaeFocus.requestFocus();
      showInSnackBar("Please enter first name");
      return false;
    }
  }

  void showInSnackBar(String value) {
    LogCustom.logd("xxxxxx: network snackbar :");
    Snack.showS(context, value);
  }

  // List<XFile> _imageFileList=[];

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
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Text('Open Camera'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(false);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: Text('Open Gallery'),
                ),
              ),
            ],
          );
        });
  }

  XFile imagesLoad;

  getImage(bool iscamera) async {
    final ImagePicker _picker = ImagePicker();

    try {
      if (iscamera) {
        imagesLoad = await _picker.pickImage(source: ImageSource.camera);
      } else {
        imagesLoad = await _picker.pickImage(source: ImageSource.gallery);
      }

      setState(() {});
    } catch (e) {}
  }

  register() async {
    Pr.show(context);

    var formData = FormData();

    if (imagesLoad != null && imagesLoad.path != "") {
      String fileName = imagesLoad.path.split('/').last;

      formData.files.add(MapEntry(
          "image",
          await MultipartFile.fromFile(
            imagesLoad.path,
            filename: fileName,
            contentType: MediaType('image', ''),
          )));
    }

    /* for(int i=0;i<images.length;i++){

      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();

      LogCustom.logd("xxxxxxxxxxxxxx file name::"+images[i].name);

      formData.files.add( MapEntry("image",   MultipartFile.fromBytes(imageData, filename: images[i].name, contentType:  MediaType('image', ''),)));

    }
*/

    Map<String, String> parms = new Map<String, String>();

    parms.putIfAbsent("firstname", () => _fNamecontroller.text.trim());
    parms.putIfAbsent("lastname", () => _lNamecontroller.text.trim());
    parms.putIfAbsent("dob", () => _datecontrolar.text.trim());
    parms.putIfAbsent("email", () => _emailtroller.text.trim());
    parms.putIfAbsent("mobile", () => _phonetroller.text.trim());
    parms.putIfAbsent("password", () => _pswdcontroller.text.trim());

    parms.putIfAbsent("company_name", () => _companycontroller.text.trim());
    parms.putIfAbsent(
        "company_address_1", () => _address1controller.text.trim());
    parms.putIfAbsent(
        "company_address_2", () => _address2controller.text.trim());
    parms.putIfAbsent("city", () => _citycontroller.text.trim());
    parms.putIfAbsent("state", () => _statecontroller.text.trim());
    parms.putIfAbsent("gstno", () => _gstcontroller.text.trim());
    parms.putIfAbsent("country", () => _countrycontroller.text.trim());
    // parms.putIfAbsent("security_code",()=> "789456");

    LoginResponse commonResponse = await bloc.register(formData, parms);

    if (commonResponse != null &&
        commonResponse.statusCode == Constant.API_CODE) {
      //await bloc.apiProvider.pref.login(commonResponse);

      // await bloc.apiProvider.pref.setLogin(true);

      Pr.hide(context);

      showInSnackBar("Sign up successfully admin will active you soon");
      /*if(commonResponse.message != null && commonResponse.message.length!=0 && commonResponse.message[0]!=null){
        showInSnackBar(commonResponse.message[0]);
      }
*/
      Navigator.pop(context);

      // PageTransition.createRoutedata(context,"MainPage",null);
    } else if (commonResponse != null) {
      showInSnackBar(commonResponse.message[0]);
    }

    Pr.hide(context);
  }

  String date = "";

  Future<String> _selectDate(
    BuildContext context,
  ) async {
    DateTime selectedDate;

    if (date != "") {
      selectedDate = DateTime.parse(Utils().getDeliveryDate(date));
    } else {
      selectedDate = DateTime.now();
    }

    selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      //initialDatePickerMode: DatePickerMode.day,
      lastDate: selectedDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = Utils().setDeliveryDate(selectedDate);
      });

      LogCustom.logd("xxxxxxx selected date ::" + date);
    } else {
      return null;
    }

    // deliveryDate=Utils().setDeliveryDate(selectedDate);

    _datecontrolar.text = date;

    return date;
  }

  //List<Asset> images = List<Asset>();

  /* Future<void> _loadAssets() async {
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
