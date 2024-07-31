import 'package:dio/dio.dart';
import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:shradha_design/response/forgotpassword/for_got_password_response.dart';
import 'package:shradha_design/response/login/login_response.dart';


class LoginBloc {

  final ApiClient apiProvider ;


  LoginBloc({this.apiProvider});

  Future<LoginResponse>  login(Map parms) async {

    var response = LoginResponse.fromJson((await apiProvider.postData(Api.login,null,parms)));
    return response;

  }


  Future<LoginResponse>  checkcode(Map parms) async {

    var response = LoginResponse.fromJson((await apiProvider.postData(Api.check_security_code,null,parms)));
    return response;

  }



  Future<LoginResponse>  register(FormData filedata,Map parms) async {

    var response = LoginResponse.fromJson((await apiProvider.sendData(Api.register,filedata,parms)));
    return response;

  }


  Future<LoginResponse>  changePassword(Map parms) async {

    var response = LoginResponse.fromJson((await apiProvider.postData(Api.updatePassword,null,parms)));
    return response;

  }




  Future<ForGotPasswordResponse>  forgotPassw(Map parms, bool isForgotPassw) async {

    var response = ForGotPasswordResponse.fromJson((await apiProvider.postData(isForgotPassw?Api.forgot_password:Api.forgot_securitycode,null,parms)));

    return response;

  }







  dispose() {
  }



}
final bloc = LoginBloc();