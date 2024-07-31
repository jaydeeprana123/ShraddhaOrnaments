import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/categoryproductlist/product_list_response.dart';
import 'package:shradha_design/response/wishlistaddremove/add_remove_wishlist_response.dart';





class ProductListBloc {


  final BehaviorSubject<ProductListResponse> _subject =  BehaviorSubject<ProductListResponse>();
  final BehaviorSubject<ProductListResponse> newproduct =  BehaviorSubject<ProductListResponse>();
  final BehaviorSubject<ProductListResponse> bestSellerProduct =  BehaviorSubject<ProductListResponse>();


  final ApiClient apiProvider ;

  ProductListBloc({this.apiProvider});//= UserApiProvider();


  /// Get Best seller products
  Future<void> getBestSeller(bool refresh) async {


    ProductListResponse response;
    Map parms=new Map<String,String>();

    try{
      response = ProductListResponse.fromJson((await apiProvider.getDatawithcache(Api.bast_product,parms,false)));
    }catch(e){
      response=null;
    }


    if( response!=null && !bestSellerProduct.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE&& response.data!=null && response.data.length!=0){
      bestSellerProduct.sink.add(response);

    }




  }

  /// Get new arrival products
  Future<void> getnewproduct(bool refresh) async {


    ProductListResponse response;
    Map parms=new Map<String,String>();

    try{
      response = ProductListResponse.fromJson((await apiProvider.getDatawithcache(Api.new_products,parms,false)));
    }catch(e){
      response=null;
    }


    if( response!=null && !newproduct.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE && response.data!=null && response.data.length!=0){
      newproduct.sink.add(response);

    }
  }




  Future<void> getProductList(bool refresh,Map parms,String url) async {




    ProductListResponse response;


    try{


      response = ProductListResponse.fromJson((await apiProvider.getDatawithcache(url,parms,false)));


    }catch(e){
      response=null;
    }

    // }




    if( response!=null && !_subject.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE && response.data!=null && response.data.length!=0){
      _subject.sink.add(response);

    }else if(response!=null && !_subject.isClosed){
      //_subject.sink.addError(response.message);
      _subject.sink.addError("Data Not Found");
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


  }



  BehaviorSubject<ProductListResponse> get subject => _subject;




}

final bloc = ProductListBloc();