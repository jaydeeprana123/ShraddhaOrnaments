import 'package:flutter/cupertino.dart';
import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/product_details_response.dart';
import 'package:shradha_design/response/wishlistaddremove/add_remove_wishlist_response.dart';





class ProductDetailsBloc {


  final BehaviorSubject<ProductDetailsResponse> _subject =  BehaviorSubject<ProductDetailsResponse>();



  final ApiClient apiProvider ;

  ProductDetailsBloc({this.apiProvider});//= UserApiProvider();


  String sizeType="Pcs";




  Future<void> getProduct(bool refresh,Map parms) async {


    print("paramssss" + parms.toString());

    ProductDetailsResponse response;

    try{

      response = ProductDetailsResponse.fromJson((await apiProvider.getDatawithcache(Api.product_detail,parms,false)));


    }catch(e){
      response=null;
    }

    // }




    if( response!=null && !_subject.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE){


      List<String> saletype = response.data.sellingType.split(",");

      if(saletype.isNotEmpty ){

        if(saletype.length==2){
          sizeType=saletype[1];
        }else{
          sizeType=saletype[0];
        }

      }


      if(response.data.size!=null && response.data.size!=""){


        List<String> sizeList = response.data.size.split(",");

        response.data.sizeList=sizeList;

        sizeList.forEach((element) {
          TextEditingController boxcontroller = new TextEditingController(text: "");
          response.data.boxcontroller.add(boxcontroller);
          response.data.qty.add("");

        });

      }else{

        TextEditingController boxcontroller = new TextEditingController(text: "");
        response.data.boxcontroller.add(boxcontroller);
        response.data.qty.add("");
        response.data.sizeList.add("Qty");

      }





      _subject.sink.add(response);

    }else if(response!=null && !_subject.isClosed){
      _subject.sink.addError(response.message);
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



  BehaviorSubject<ProductDetailsResponse> get subject => _subject;



 /*
  BehaviorSubject<CategoryWithImageResponse> get categoryWithImage => _categoryWithImage;
  BehaviorSubject<TrendingProductResponse> get trendingProduct => _trendingProduct;
  BehaviorSubject<CollactionResponse> get collection => _collection;
  BehaviorSubject<CustomerSayResponse> get customerSay => _customer;*/
 // BehaviorSubject<SearchResponse> get subjectSearch => _subjectSearch;


}

final bloc = ProductDetailsBloc();