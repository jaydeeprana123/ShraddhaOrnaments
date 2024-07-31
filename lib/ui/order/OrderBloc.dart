import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/common/common_response.dart';
import 'package:shradha_design/response/orderlist/order_details_response.dart';
import 'package:shradha_design/response/orderlist/order_list_response.dart';
import 'package:shradha_design/response/placeorder/place_order_response.dart';





class OrderBloc {


  final BehaviorSubject<OrderListResponse> _subject =  BehaviorSubject<OrderListResponse>();
  final BehaviorSubject<OrderDetailsResponse> _subjectOrderDetails =  BehaviorSubject<OrderDetailsResponse>();



  final ApiClient apiProvider ;

  OrderBloc({this.apiProvider});//= UserApiProvider();






  Future<void> getOrder(bool refresh) async {
    Map parms=new Map<String,String>();

    print("userId - "+  apiProvider.pref.getUserId());

    parms.putIfAbsent("user_id", () => apiProvider.pref.getUserId());


    OrderListResponse response;

    try{
      response = OrderListResponse.fromJson((await apiProvider.getDatawithcache(Api.order,parms,false)));
    }catch(e){

      print("hiii");

      response=null;
      subject.sink.addError("Data Not Found");
    }

    // }




    if( response!=null && !_subject.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE){
      _subject.sink.add(response);

    }else if(response!=null && !_subject.isClosed){

      _subject.sink.addError("Data Not Found");

      //_subject.sink.addError(response.message);
    }




  }


  Future<void> getOrderDetails(bool refresh, String orderId) async {


    Map parms=new Map<String,String>();

    parms.putIfAbsent("order_id", () => orderId);

    print("order_id - " + orderId);

    OrderDetailsResponse response;


    try{


      response = OrderDetailsResponse.fromJson((await apiProvider.getDatawithcache(Api.orderDetails,parms,false)));

      print("response get order details");

    }catch(e){
      response=null;
    }

    // }




    if( response!=null && !_subjectOrderDetails.isClosed && response.statusCode!=null && response.statusCode==Constant.API_CODE){
      _subjectOrderDetails.sink.add(response);

      print("_subjectOrderDetails.sink");


    }else if(response!=null && !_subjectOrderDetails.isClosed){

      _subjectOrderDetails.sink.addError("Data Not Found");

      //_subject.sink.addError(response.message);
    }




  }




  Future<PlaceOrderResponse> placeOrder(bool refresh,Map parms) async {

    PlaceOrderResponse response;


    try{
      response = PlaceOrderResponse.fromJson((await apiProvider.getDatawithcache(Api.placeorder,parms,false)));

    }catch(e){
      response=null;
    }


    return response;



  }








  Future<CommonResponse> deleteOrder(bool refresh,Map parms) async {


    CommonResponse response;


    try{

      response = CommonResponse.fromJson((await apiProvider.getDatawithcache(Api.order_remove,parms,false)));

    }catch(e){
      response=null;


    }


    return response;

  }




  dispose() {

    _subject.close();
    _subjectOrderDetails.close();

  }



  BehaviorSubject<OrderListResponse> get subject => _subject;
  BehaviorSubject<OrderDetailsResponse> get subjectOrderDetails => _subjectOrderDetails;



}

final bloc = OrderBloc();