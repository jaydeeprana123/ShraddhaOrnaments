import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/wishlist/wish_list_response.dart';
import 'package:shradha_design/response/wishlistaddremove/add_remove_wishlist_response.dart';





class WishListBloc {


  final BehaviorSubject<WishListResponse> _subject =  BehaviorSubject<WishListResponse>();


  final ApiClient apiProvider ;

  WishListBloc({this.apiProvider});//= UserApiProvider();






  Future<void> getwishlist(bool refresh,Map parms) async {




    WishListResponse response;


    try{
      response = WishListResponse.fromJson((await apiProvider.getDatawithcache(Api.display_wishlist,parms,false)));
    }catch(e){
      response=null;
    }

    // }




    if( response!=null && !_subject.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE){

      if(response.data.isEmpty){
        _subject.sink.addError("YOUR WISHLIST IS EMPTY");
      }else{
        _subject.sink.add(response);
      }





      print("jhgj");

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



  BehaviorSubject<WishListResponse> get subject => _subject;




}

final bloc = WishListBloc();