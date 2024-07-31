import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/common/common_response.dart';





class ContactBloc {


  final BehaviorSubject<CommonResponse> _subject =  BehaviorSubject<CommonResponse>();




  final ApiClient apiProvider ;

  ContactBloc({this.apiProvider});//= UserApiProvider();






  Future<void> getcontact(bool refresh) async {


    Map parms=new Map<String,String>();

   // parms.putIfAbsent("user_id", () => apiProvider.pref.getUserId());


    CommonResponse response;


    try{
      response = CommonResponse.fromJson((await apiProvider.getDatawithcache(Api.comman,parms,false)));
    }catch(e){
      response=null;
    }

    // }




    if( response!=null && !_subject.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE){
      _subject.sink.add(response);

    }else if(response!=null && !_subject.isClosed){

      _subject.sink.addError(response.message);
    }




  }





  dispose() {

    _subject.close();


  }



  BehaviorSubject<CommonResponse> get subject => _subject;




}

final bloc = ContactBloc();