import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/category/category_response.dart';
import 'package:shradha_design/response/maincategory/main_category_response.dart';
import 'package:shradha_design/response/subcategory/sub_category_response.dart';





class CatBloc {


  final BehaviorSubject<SubCategoryResponse> _subject =  BehaviorSubject<SubCategoryResponse>();

  final BehaviorSubject<CategoryResponse> _category =  BehaviorSubject<CategoryResponse>();


  final BehaviorSubject<MainCategoryResponse> _categoryWithImage =  BehaviorSubject<MainCategoryResponse>();



  final ApiClient apiProvider ;

  CatBloc({this.apiProvider});//= UserApiProvider();





  Future<void> getcategoryMain(bool refresh) async {


    MainCategoryResponse response;
    Map parms=new Map<String,String>();

    try{
      response = MainCategoryResponse.fromJson((await apiProvider.getDataGetwithcache(Api.categorytag,parms,false)));
    }catch(e){
      response=null;
    }


    if( response!=null && !_categoryWithImage.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE && response.data!=null && response.data.length!=0){
      _categoryWithImage.sink.add(response);

    }else if(response!=null && !_categoryWithImage.isClosed){

      _categoryWithImage.sink.addError("Data Not Found");
      //_categoryWithImage.sink.addError(response.message);
    }





  }




  Future<void> getsubcat(bool refresh,Map parms) async {
    CategoryResponse response;


    try{
      response = CategoryResponse.fromJson((await apiProvider.getDatawithcache(Api.maincategory,parms,false)));
    }catch(e){
      response=null;
    }

    // }




    if( response!=null && !_category.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE && response.data!=null && response.data.length!=0){
      _category.sink.add(response);

    }else if(response!=null &&!_category.isClosed){

      _category.sink.addError("Data Not Found");
    }




  }


  Future<void> getsub_subcat(bool refresh,Map parms) async {




    SubCategoryResponse response;


    try{
      response = SubCategoryResponse.fromJson((await apiProvider.getDatawithcache(Api.subcategory,parms,false)));
    }catch(e){
      response=null;
    }

    // }




    if( response!=null && !_subject.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE && response.data!=null && response.data.length!=0){
      _subject.sink.add(response);

    }else if(response!=null && !_subject.isClosed){

      _subject.sink.addError("Data Not Found");
      //_subject.sink.addError(response.message);
    }




  }





  dispose() {

    _subject.close();
    _categoryWithImage.close();
    _category.close();


  }



  BehaviorSubject<SubCategoryResponse> get subject => _subject;
  BehaviorSubject<MainCategoryResponse> get categoryWithImage => _categoryWithImage;
  BehaviorSubject<CategoryResponse> get category => _category;



 /*
  BehaviorSubject<CategoryWithImageResponse> get categoryWithImage => _categoryWithImage;
  BehaviorSubject<TrendingProductResponse> get trendingProduct => _trendingProduct;
  BehaviorSubject<CollactionResponse> get collection => _collection;
  BehaviorSubject<CustomerSayResponse> get customerSay => _customer;*/
 // BehaviorSubject<SearchResponse> get subjectSearch => _subjectSearch;


}

final bloc = CatBloc();