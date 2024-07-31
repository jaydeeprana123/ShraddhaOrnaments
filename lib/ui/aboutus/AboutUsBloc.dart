import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/aboutus/about_us_response.dart';





class AboutBloc {


  final BehaviorSubject<AboutUsResponse> _subject =  BehaviorSubject<AboutUsResponse>();




  final ApiClient apiProvider ;

  AboutBloc({this.apiProvider});//= UserApiProvider();







  Future<void> getsub_subcat(bool refresh) async {




    AboutUsResponse response;

    //response = AboutUsResponse.fromJson((await apiProvider.getDatawithcache(Api.about_us,null,false)));

    try{
      response = AboutUsResponse.fromJson((await apiProvider.getDatawithcache(Api.about_us,null,false)));
    }catch(e){
      response=null;
    }

    // }




    if( response!=null && !_subject.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE && response.data!=null ){
      _subject.sink.add(response);

    }else if(response!=null && !_subject.isClosed){

      _subject.sink.addError("Data Not Found");
      //_subject.sink.addError(response.message);
    }




  }





  dispose() {

    _subject.close();


  }



  BehaviorSubject<AboutUsResponse> get subject => _subject;


}

final bloc = AboutBloc();