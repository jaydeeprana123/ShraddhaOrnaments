import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/constant/network_constant.dart';
import 'package:shradha_design/repositories/prefrance.dart';
import 'package:meta/meta.dart';

class ApiClient {

  final Dio dio ;
  final PreferencesHelper pref ;

 // final MemCacheStore  mm =  MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);

  //  final DbCacheStore db =DbCacheStore ();
 // CacheOptions options;



  ApiClient({@required this.dio,@required this.pref}) : assert(dio != null,pref != null){


    LogCustom.loge("xxxxxxxxx ApiClient: init");

   /* mm.clean();

    options =  CacheOptions(
      // A default store is required for interceptor.
      store: mm,
      //store: DbCacheStore(),
      // Default.
      policy: CachePolicy.noCache,
      // Optional. Returns a cached response on error but for statuses 401 & 403.
      hitCacheOnErrorExcept: [401, 403],
      // Optional. Overrides any HTTP directive to delete entry past this duration.
      maxStale: const Duration(hours: 3),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended.
      allowPostMethod: false,
    );
*/

    if(!NetworkContastant.isLive){

      dio.interceptors.add(LogInterceptor());

       (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };


    }
  }










  Future<dynamic> getData(String url,Map parms) async {


    Response response = await dio.get(url,queryParameters: parms);


    try {

     // parms.addAll(await getCommon());


      LogCustom.loge("xxxxxxxxx getData: "+response.data.toString());


      return response.data;
     // return response.data;

    } on DioError catch (error) {

      LogCustom.loge("xxxxxxxxx error: $error stackTrace: $error"+"peramter:"+parms.toString());


      return null;
    }

  }


  Future<dynamic> postData(String url,FormData filedata,Map parms) async {
    try {
     // parms.addAll(await getCommon());


      if(pref.getToken()!=""){
        dio.options.headers["authorization"] = "Bearer "+pref.getToken();
      }


      ///
      Response response = await dio.post(url/*,data: filedata*/ ,queryParameters: parms);
       LogCustom.logd("xxxxxxxxx  data receive success:" +response.data.toString());
      return response.data;
    } catch (error, stacktrace) {
      LogCustom.logd("xxxxxxxxx sendReview: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<dynamic> sendData(String url,FormData filedata,Map parms) async {
    try {
     // parms.addAll(await getCommon());

      ///
      Response response = await dio.post(url,data: filedata ,queryParameters: parms,options:Options(contentType: "multipart/form-data"));
      LogCustom.logd("xxxxxxxxx  data receive success:" +response.data.toString());
      return response.data;
    } catch (error, stacktrace) {
      LogCustom.logd("xxxxxxxxx sendReview: $error stackTrace: $stacktrace");
      return null;
    }
  }




  Future<dynamic> getDatawithcache(String url,Map parms, bool refresh) async {

    try {





      LogCustom.loge("xxxxxxxxx getData: getDatawithcache refresh:"+refresh.toString());


      if(pref.getToken()!=""){
        dio.options.headers["authorization"] = "Bearer "+pref.getToken();
      }







     // dio.options.headers['content-Type'] = 'application/json';

      FormData formData = new FormData.fromMap(parms);
     Response response = await dio.post(url,data: formData,
         options: Options(headers: {
         HttpHeaders.contentTypeHeader: "application/json",
         }
     )

     );

     // Response response = await dio.post(url,queryParameters: parms);






      LogCustom.loge("xxxxxxxxx getData: "+response.data.toString());

      //return response.data.toString();
      return response.data;

    } on DioError catch (error) {

      LogCustom.loge("xxxxxxxxx getData: $error stackTrace: $error"+"peramter:"+parms.toString());
     // GlobleApi().senderrorlog(this,"API CALL", "peramter:"+parms.toString()+":Error:"+error.toString());

      return null;
    }

  }



  Future<dynamic> sendProduct(String url,Map parms, bool refresh) async {

    try {





      LogCustom.loge("xxxxxxxxx getData: sendProduct refresh:"+refresh.toString());


      if(pref.getToken()!=""){
        dio.options.headers["authorization"] = "Bearer "+pref.getToken();
      }







      // dio.options.headers['content-Type'] = 'application/json';

      FormData formData = new FormData.fromMap(parms);
      Response response = await dio.post(url,data: jsonEncode(parms),
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }
          )

      );

      // Response response = await dio.post(url,queryParameters: parms);






      LogCustom.loge("xxxxxxxxx getData: "+response.data.toString());

      //return response.data.toString();
      return response.data;

    } on DioError catch (error) {

      LogCustom.loge("xxxxxxxxx getData: $error stackTrace: $error"+"peramter:"+parms.toString());
      // GlobleApi().senderrorlog(this,"API CALL", "peramter:"+parms.toString()+":Error:"+error.toString());

      return null;
    }

  }







  Future<dynamic> getDataformdata(String url,FormData parms, bool refresh) async {

    try {





      LogCustom.loge("xxxxxxxxx getData: getDatawithcache refresh:"+refresh.toString());


      if(pref.getToken()!=""){
        dio.options.headers["authorization"] = "Bearer "+pref.getToken();
      }






      Response response = await dio.post(url,data: parms);






      LogCustom.loge("xxxxxxxxx getData: "+response.data.toString());

      //return response.data.toString();
      return response.data;

    } on DioError catch (error) {

      LogCustom.loge("xxxxxxxxx getData: $error stackTrace: $error"+"peramter:"+parms.toString());
      // GlobleApi().senderrorlog(this,"API CALL", "peramter:"+parms.toString()+":Error:"+error.toString());

      return null;
    }

  }








  Future<dynamic> getDataGetwithcache(String url,Map parms, bool refresh) async {

    try {





      LogCustom.loge("xxxxxxxxx getData: getDatawithcache refresh:"+refresh.toString());


      if(pref.getToken()!=""){
        dio.options.headers["authorization"] = "Bearer "+pref.getToken();
      }




      Response response = await dio.get(url,queryParameters: parms);






      LogCustom.loge("xxxxxxxxx getData: "+response.data.toString());

      //return response.data.toString();
      return response.data;

    } on DioError catch (error) {

      LogCustom.loge("xxxxxxxxx getData: $error stackTrace: $error"+"peramter:"+parms.toString());
      // GlobleApi().senderrorlog(this,"API CALL", "peramter:"+parms.toString()+":Error:"+error.toString());

      return null;
    }

  }



/*

  Future<bool>  deleteCache(String url,Map parms)async{


    try{
      final key = CacheOptions.defaultCacheKeyBuilder(RequestOptions(path:url ,queryParameters: parms),);
      // bool ss =await mm.exists(key);
      // LogCustom.logd("xxxxxxxxx :xxx cache response: ::"+ss.toString());

      //mm.delete(key);
      // mm.delete(queryString);
    }catch(e){
      LogCustom.logd("xxxxxxxxx :xxx cache delete error ::");
    }

    return true;

  }
*/





/*

  Future<CommonResponse> sendReview(FormData filedata,Map parms) async {
    try {
      parms.addAll(await getCommon());

      ///
      Response response = await dio.post(NetworkContastant.endpoint,data: filedata ,queryParameters: parms,options:Options(contentType: "multipart/form-data"));
      // LogCustom.logd("xxxxxxxxx  data receive success:");
      return CommonResponse.fromJson(json.decode(response.data.toString()));
    } catch (error, stacktrace) {
      LogCustom.logd("xxxxxxxxx sendReview: $error stackTrace: $stacktrace");
      return null;
    }
  }


  Future<SendProblemTypeResponse> sendticket(FormData filedata,Map parms) async {
    try {
      parms.addAll(await getCommon());

      ///
      Response response = await dio.post(NetworkContastant.endpoint,data: filedata ,queryParameters: parms,options:Options(contentType: "multipart/form-data"));
      //LogCustom.logd("xxxxxxxxx  data receive success:");
      return SendProblemTypeResponse.fromJson(json.decode(response.data.toString()));
    } catch (error, stacktrace) {
      LogCustom.loge("xxxxxxxxx sendReview: $error stackTrace: $stacktrace");
      return null;
    }
  }





  Future<CommonResponse> sendattachment(FormData filedata,Map parms) async {
    try {
      parms.addAll(await getCommon());

      ///
      Response response = await dio.post(NetworkContastant.endpoint,data: filedata ,queryParameters: parms,options:Options(contentType: "multipart/form-data"));

      //LogCustom.logd("xxxxxxxxx  data receive success:");

      return CommonResponse.fromJson(json.decode(response.data.toString()));
    } catch (error, stacktrace) {
      LogCustom.loge("xxxxxxxxx sendReview: $error stackTrace: $stacktrace");
      return null;
    }
  }

*/

}
