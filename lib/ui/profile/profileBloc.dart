import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:shradha_design/response/login/login_response.dart';


class ProfileBloc {

  final ApiClient apiProvider ;



  ProfileBloc({this.apiProvider});



  final BehaviorSubject<LoginResponse> _subject =  BehaviorSubject<LoginResponse>();

  TextEditingController fNamecontroller;
  TextEditingController lNamecontroller;
  TextEditingController emailtroller;
 // TextEditingController pswdcontroller;
  TextEditingController phonetroller;

  TextEditingController companycontroller;
  TextEditingController gstcontroller;
  TextEditingController address1controller;
  TextEditingController address2controller;
  TextEditingController citycontroller;
  TextEditingController statecontroller;
  TextEditingController countrycontroller;
  TextEditingController datecontrolar;

  String image="";



  Future<bool> getuser() async {


    Map<String, String> parms = new Map<String,String>();

    parms.putIfAbsent("id",()=> apiProvider.pref.getUserId());



    var response = LoginResponse.fromJson((await apiProvider.postData(Api.user_detail,null,parms)));



    if(response!=null){

      if(response.statusCode==Constant.API_CODE){

        print("imageee   " +  response.data.image);

       fNamecontroller.text=response.data.firstname;
       lNamecontroller.text=response.data.lastname;
       emailtroller.text=response.data.email;
       phonetroller.text=response.data.mobile;
       datecontrolar.text=response.data.dob;
       image=response.data.image;

       companycontroller.text=response.data.companyName;
       gstcontroller.text=response.data.gstno;
       address1controller.text=response.data.companyAddress1;
       address2controller.text=response.data.companyAddress2;
       citycontroller.text=response.data.city;
       statecontroller.text=response.data.state;
       countrycontroller.text=response.data.country;



      }

    }




    return true;



  }




  getuserdata() async {


    Map<String, String> parms = new Map<String,String>();

    parms.putIfAbsent("id",()=> apiProvider.pref.getUserId());



    var response = LoginResponse.fromJson((await apiProvider.postData(Api.user_detail,null,parms)));


      if(response!=null && response.statusCode==Constant.API_CODE){

        _subject.sink.add(response);

        await apiProvider.pref.login(response);


      }else{

        _subject.sink.addError(response.message);

      }







  }





  Future<LoginResponse>  login(Map parms) async {

    var response = LoginResponse.fromJson((await apiProvider.postData(Api.login,null,parms)));
    return response;

  }





  Future<LoginResponse>  register(FormData filedata,Map parms) async {

    var response = LoginResponse.fromJson((await apiProvider.sendData(Api.register,filedata,parms)));
    return response;

  }



  Future<LoginResponse>  update(FormData filedata,Map parms) async {

    var response = LoginResponse.fromJson((await apiProvider.sendData(Api.updateProfile,filedata,parms)));
    return response;

  }



  dispose() {

    _subject.close();
  }




  BehaviorSubject<LoginResponse> get subject => _subject;
}
final bloc = ProfileBloc();