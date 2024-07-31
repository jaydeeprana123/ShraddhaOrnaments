import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/categoryproductlist/product_list_response.dart';
import 'package:shradha_design/response/homebanner/home_slider_response.dart';
import 'package:shradha_design/response/maincategory/main_category_response.dart';
import 'package:shradha_design/response/wishlistaddremove/add_remove_wishlist_response.dart';


class HomeBloc {
  final BehaviorSubject<HomeSliderResponse> _subject =  BehaviorSubject<HomeSliderResponse>();
  final BehaviorSubject<MainCategoryResponse> _categoryWithImage =  BehaviorSubject<MainCategoryResponse>();
  final BehaviorSubject<ProductListResponse> _newproduct =  BehaviorSubject<ProductListResponse>();
  final BehaviorSubject<ProductListResponse> _bestsaleproduct =  BehaviorSubject<ProductListResponse>();


  /* final BehaviorSubject<HomeBannerResponse> _subject =  BehaviorSubject<HomeBannerResponse>();

  final BehaviorSubject<TrendingProductResponse> _trendingProduct =  BehaviorSubject<TrendingProductResponse>();
  final BehaviorSubject<CollactionResponse> _collection=  BehaviorSubject<CollactionResponse>();
  final BehaviorSubject<CustomerSayResponse> _customer=  BehaviorSubject<CustomerSayResponse>();
*/



  //final pref=AppPreferencesHelper();
  //UserApiProvider apiProvider = UserApiProvider();

  final ApiClient apiProvider ;

  HomeBloc({this.apiProvider});//= UserApiProvider();


  Future<void> getBanner(bool refresh) async {


    HomeSliderResponse response;
    Map parms=new Map<String,String>();

    try{
      response = HomeSliderResponse.fromJson((await apiProvider.getDatawithcache(Api.slider,parms,false)));
    }catch(e){
      response=null;
    }


    if( response!=null && !_subject.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE){
      _subject.sink.add(response);

    }else{
      _subject.sink.addError("Data Not Found");
    }



    getcategoryMain(refresh);


  }




  Future<void> getcategoryMain(bool refresh) async {


    MainCategoryResponse response;
    Map parms=new Map<String,String>();

    try{
      response = MainCategoryResponse.fromJson((await apiProvider.getDataGetwithcache(Api.categorytag,parms,false)));
    }catch(e){
      response=null;
    }


    if( response!=null && !_categoryWithImage.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE){
      _categoryWithImage.sink.add(response);

    }

    getnewproduct(refresh);

  }





  Future<void> getnewproduct(bool refresh) async {


    ProductListResponse response;
    Map parms=new Map<String,String>();

    try{
      response = ProductListResponse.fromJson((await apiProvider.getDatawithcache(Api.new_products,parms,false)));
    }catch(e){
      response=null;
    }


    if( response!=null && !_newproduct.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE && response.data!=null && response.data.length!=0){
      _newproduct.sink.add(response);

    }



    bestsale(refresh);


  }


  Future<void> bestsale(bool refresh) async {


    ProductListResponse response;
    Map parms=new Map<String,String>();

    try{
      response = ProductListResponse.fromJson((await apiProvider.getDatawithcache(Api.bast_product,parms,false)));
    }catch(e){
      response=null;
    }


    if( response!=null && !_bestsaleproduct.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE&& response.data!=null && response.data.length!=0){
      _bestsaleproduct.sink.add(response);

    }




  }






  Future<AddRemoveWishlistResponse>  addremoveWhislist(bool isAdd,Map parms) async {



    var response;  //= AddRemoveWishlistResponse.fromJson((await apiProvider.postData(Api.login,null,parms)));

    if(isAdd){

      response = AddRemoveWishlistResponse.fromJson((await apiProvider.postData(Api.addWishlist,null,parms)));
    }else{
      response = AddRemoveWishlistResponse.fromJson((await apiProvider.postData(Api.removeWhishlist,null,parms)));
    }


    return response;

  }





  dispose() {

    _subject.close();
    _categoryWithImage.close();
    _newproduct.close();
    _bestsaleproduct.close();
  }



  BehaviorSubject<HomeSliderResponse> get subject => _subject;
  BehaviorSubject<MainCategoryResponse> get categoryWithImage => _categoryWithImage;
  BehaviorSubject<ProductListResponse> get newproduct => _newproduct;
  BehaviorSubject<ProductListResponse> get bestsaleproduct => _bestsaleproduct;



}

final bloc = HomeBloc();