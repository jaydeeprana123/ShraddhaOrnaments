import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:shradha_design/response/search/search_response.dart';
import 'package:shradha_design/response/search/term_list_response.dart';

import '../../constant/constant.dart';




class SearchBloc {

  final ApiClient apiProvider ;//= UserApiProvider();

  // UserApiProvider _apiProvider = UserApiProvider();
  /*final UserRepository _repository = UserRepository();*/


  List<ProductData> searchdata=[];
  List<TermData> termData=[];

  int totalItems = 0;

  final BehaviorSubject<List<ProductData>> _subjectSearch =  BehaviorSubject<List<ProductData>>();
  final BehaviorSubject<List<TermData>> _subTermData =  BehaviorSubject<List<TermData>>();


  BehaviorSubject<bool> _loading =  BehaviorSubject<bool>();

  bool _isLoading=false;



  int totoalPage = 2;
  int currentPage = 1;


  SearchBloc({this.apiProvider});



  void getSearch(String str) async {


    Map hashMap5 = new Map<String, String>();
   // hashMap5.putIfAbsent("id", () => apiProvider.pref.getUserId());
    hashMap5.putIfAbsent("title", () => str);
    hashMap5.putIfAbsent("page", () => currentPage.toString());

    LogCustom.logd("xxxxxxxxx: search :"+_isLoading.toString());



    if(currentPage==1){
      searchdata.clear();
    }


    if(!_isLoading && str!=null && str!="" ){

      _loading.add(true);
      _isLoading=true;

      SearchResponse response;
      try{

        response  = SearchResponse.fromJson((await apiProvider.postData(Api.searchProduct,null,hashMap5)));

      }catch(e){
        response=null;
      }

      _loading.add(false);

      _isLoading=false;


      if(response!=null && response.data!=null && !_subjectSearch.isClosed){


        if(response.data.total != 0){

          print("response.data.tota " + response.data.total.toString());
          totalItems =  response.data.total;
        }


        totoalPage=response.data.lastPage;

        LogCustom.logd("xxxxxxxxx: totoalPage :"+totoalPage.toString());

        searchdata.addAll(response.data.data);

        _subjectSearch.sink.add(searchdata);

      }else if(!_subjectSearch.isClosed){

        searchdata.clear();

        _subjectSearch.sink.add([]);
      }

    }else if(!_subjectSearch.isClosed){

      searchdata.clear();
      _subjectSearch.sink.add([]);
      _loading.add(false);
    }




  }

  void getSearchTerm(String id, BuildContext context, String term) async {

    Map hashMap5 = new Map<String, String>();
    // hashMap5.putIfAbsent("id", () => apiProvider.pref.getUserId());
    hashMap5.putIfAbsent("term_id", () => id);
    hashMap5.putIfAbsent("page", () => currentPage.toString());

    LogCustom.logd("xxxxxxxxx: search :"+_isLoading.toString());



    if(currentPage==1){
      searchdata.clear();
    }


    if(!_isLoading && id!=null && id!="" ){

      _loading.add(true);
      _isLoading=true;

      SearchResponse response;
      try{

        response  = SearchResponse.fromJson((await apiProvider.postData(Api.searchTermProduct,null,hashMap5)));

        if(response.data.data.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No data available in ' + term),
          ));

        }

      }catch(e){
        response=null;
      }

      _loading.add(false);

      _isLoading=false;


      if(response!=null && response.data!=null && !_subjectSearch.isClosed){

        if(response.data.total != 0){
          print("response.data.tota " + response.data.total.toString());
          totalItems =  response.data.total;
        }
        totoalPage=response.data.lastPage;

        LogCustom.logd("xxxxxxxxx: totoalPage :"+totoalPage.toString());

        searchdata.addAll(response.data.data);


        _subjectSearch.sink.add(searchdata);

      }else if(!_subjectSearch.isClosed){

        searchdata.clear();

        _subjectSearch.sink.add([]);
      }

    }else if(!_subjectSearch.isClosed){

      searchdata.clear();
      _subjectSearch.sink.add([]);
      _loading.add(false);
    }




  }


  void getTermList() async {


    TermListResponseModel response;
    Map parms=new Map<String,String>();

    try{
      response = TermListResponseModel.fromJson((await apiProvider.getData(Api.termList,null)));
    }catch(e){
      response=null;
    }


    if( response!=null && !_subTermData.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE){
      _subTermData.sink.add(response.data);

    }


  }



  bool isLoading() {

    return _loading.value;

  }




  dispose() {
    _subTermData.close();
    _subjectSearch.close();
  }

  BehaviorSubject<List<ProductData>> get subject => _subjectSearch;
  BehaviorSubject<List<TermData>> get termList => _subTermData;
  BehaviorSubject<bool> get loading => _loading;

}


final searchBloc = SearchBloc();