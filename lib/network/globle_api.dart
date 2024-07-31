
import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/repositories/api_client.dart';



class GlobleApi{





  static void  logout(ApiClient apiProvider) async {


       Map parms=new Map<String,String>();

       parms.putIfAbsent("id",()=>apiProvider.pref.getUserId());

      apiProvider.postData(Api.logout,null,parms);

  }


  static void  deleteAccount(ApiClient apiProvider) async {

    Map parms=new Map<String,String>();

    parms.putIfAbsent("id",()=>apiProvider.pref.getUserId());

    apiProvider.postData(Api.deleteAccount,null,parms);

  }

}
