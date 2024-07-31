import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:shradha_design/response/common/common_response.dart';



class SplashBloc {

//  final BehaviorSubject<SaleAndSessionResponse> _subject =  BehaviorSubject<SaleAndSessionResponse>();

  final ApiClient apiProvider ;




  SplashBloc({this.apiProvider});//= UserApiProvider();

  Future<CommonResponse> getcontact(bool refresh) async {


    Map parms=new Map<String,String>();


    CommonResponse response;

    try{
      response = CommonResponse.fromJson((await apiProvider.getDatawithcache(Api.comman,parms,false)));


      apiProvider.pref.setSplaceBg(response.data.background);
      apiProvider.pref.setSplacelogo(response.data.logo);
      apiProvider.pref.setcontactPhone(response.data.phone);



    }catch(e){
      response=null;
    }

    return response;


  }



}

final splashBloc = SplashBloc();