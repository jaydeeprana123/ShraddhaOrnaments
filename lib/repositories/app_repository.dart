import 'package:meta/meta.dart';
import 'api_client.dart';



class AppRepository {


  final ApiClient apiClient    ;
  //final PreferencesHelper pref ;


  AppRepository({@required this.apiClient/*,@required this.pref*/})
      : assert(apiClient != null/*,pref != null*/);




  /*
  Future<HashMap> getCommon() async{

    // apiClient.dio.options=options;


   *//* if(!NetworkContastant.isLive){
      apiClient.dio.interceptors.add(LogInterceptor());

      (apiClient.dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };

    }

*//*
    HashMap con=new HashMap<String,String>();


    if( NetworkContastant.key!="" && NetworkContastant.key!="ABC"){
      con.putIfAbsent("randomNumber",()=>NetworkContastant.key);
    }else{
      CommonData data=new CommonData();
      String ss= await data.setup();
      con.putIfAbsent("randomNumber",()=>ss);
    }

    if(pref.getDeviceId()!=""){
      con.putIfAbsent("androidDeviceId",()=>pref.getDeviceId());

    }else{

      String deviceId="test";
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if(Platform.isAndroid){

        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        pref.setDeviceId(androidInfo.androidId);
        deviceId=androidInfo.androidId;
      }else{

        IosDeviceInfo iosinfo= await deviceInfo.iosInfo;
        pref.setDeviceId(iosinfo.identifierForVendor);
        deviceId=iosinfo.identifierForVendor;
        //LogCustom.logd("xxxxxxxxxx::model :"+iosinfo.utsname.machine);

      }

      pref.setDeviceId(deviceId);
      con.putIfAbsent("androidDeviceId",()=>deviceId);

    }

    if(Platform.isAndroid){
      con.putIfAbsent("requestFrom",()=>"Android");
    }else{
      con.putIfAbsent("requestFrom",()=>"ios");
    }

    con.putIfAbsent("idDbSession",()=>pref.getSessionId());
    con.putIfAbsent("idDbSessionCart",()=>pref.getCartId());
    con.putIfAbsent("idCustomer",()=>pref.getUserId());

    return con;

  }




  Future<String> getData(Map parms) async {
    try {

      parms.addAll(await getCommon());
      Response response = await apiClient.dio.get(NetworkContastant.endpoint,queryParameters: parms);
      LogCustom.loge("xxxxxxxxx getData: "+response.data.toString());

      return response.data.toString();
    } catch (error, stacktrace) {

      LogCustom.loge("xxxxxxxxx getData: $error stackTrace: $stacktrace");
      GlobleApi().senderrorlog(apiClient,"API CALL", "peramter:"+parms.toString()+":Error:"+error.toString());


      return null;
    }
  }


*/




}
