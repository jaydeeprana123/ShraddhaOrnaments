import 'package:flutter/cupertino.dart';
import 'package:shradha_design/constant/Api.dart';
import 'package:shradha_design/constant/CartConstants.dart';
import 'package:shradha_design/constant/constant.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/repositories/api_client.dart';
import 'package:rxdart/subjects.dart';
import 'package:shradha_design/response/cart/CartRespone.dart';
import 'package:shradha_design/response/placeorder/place_order_response.dart';
import 'package:shradha_design/response/wishlistaddremove/add_remove_wishlist_response.dart';
import 'package:shradha_design/utils/cart_db.dart' as cart_database;





class CartListBloc {


  final BehaviorSubject<List<CartConstants>> _subject =  BehaviorSubject<List<CartConstants>>();
  final BehaviorSubject<List<CartConstants>> _subjectTNA =  BehaviorSubject<List<CartConstants>>();
  final BehaviorSubject<bool> _visibleButton =  BehaviorSubject<bool>();


  TextEditingController comentcontroller;



  final ApiClient apiProvider ;

  CartListBloc({this.apiProvider});//= UserApiProvider();

  List<CartConstants> data;

  double grandtotal=0;
  double tnagrandtotal=0;

  final database = cart_database.openDB();







 Future<bool> getcartData()async{




    data=await cart_database.cart(database);




    if(data!=null && data.length!=0){


      List<String> idProducts=[];



      data.forEach((element) {

        idProducts.add(element.pid);

       element.qty.addAll(element.qnt.replaceAll('[', '').replaceAll(']','').split(","));



       element.qty.forEach((element2) {

         TextEditingController boxcontroller = new TextEditingController(text: element2);
         element.boxcontroller.add(boxcontroller);

       });


       element.sizeList.addAll(element.size.replaceAll('[', '').replaceAll(']','').split(","));



      });


      CartRespone response;

      try{

        var params =  {
          "product": idProducts
          //  "product": [1505400000,6546465,7649,14517]
        };


        response = CartRespone.fromJson((await apiProvider.sendProduct(Api.cart_check,params,false)));

        LogCustom.logd("xxxxxxxxx :: response::"+response.data.toString());

       // response.data.add("4605");

        if(response!=null && response.data!=null && response.data.length!=0){


          response.data.forEach((element) {

            String id=element.toString();

            data.removeWhere((element)  {

              if(element.pid==id){
                cart_database.deleteScore(id, database);
                return true;
              }else{
                return false;
              }

            });


          });


        }



      }catch(e){
        response=null;
        LogCustom.logd("xxxxxxxxx :: error::"+e.toString());

      }





      Constant.count=data.length;
      List<CartConstants> product=[];
      List<CartConstants> tnaproduct=[];

      data.forEach((element) {

        if(element.tna=="0"){
          product.add(element);
        }else{
          tnaproduct.add(element);
        }


        double qnty=0;

        element.qty.forEach((element) {
          qnty=double.parse(element)+qnty;
        });


      /*  double price;


        if(element.packing!=null && element.packing!=""){
          price=double.parse(element.price)*qnty*int.parse(element.packing.toString());
        }else{
          price=double.parse(element.price)*qnty;
        }
*/

        //grandtotal=grandtotal+price;

        getGrand();


      });













      _subject.sink.add(product);
      _subjectTNA.sink.add(tnaproduct);
      _visibleButton.sink.add(true);









    }else {


        Constant.count = 0;
        _visibleButton.sink.add(false);
        _subject.sink.addError("YOUR CART IS EMPTY");
      }








    return true;


  }








  deleteitem(String pid){

    //final database = cart_database.openDB();

    cart_database.deleteScore(pid, database);


  }




  updateqty(String pid, String qty){


   LogCustom.logd("xxxxxxx : update:"+qty);



    cart_database.updateScore(pid, database,qty);

   getGrand();


  }

  getGrand(){



   LogCustom.logd("xxxxxxx size ::"+data.length.toString());
    grandtotal=0;
   tnagrandtotal=0;


    data.forEach((element) {




      if(element.tna=="0"){

        double qnty=0;

        element.qty.forEach((element) {

          qnty=double.parse(element)+qnty;

        });


        double price;


        if(element.packing!=null && element.packing!=""){
          price=double.parse(element.price)*qnty*int.parse(element.packing.toString());
        }else{
          price=double.parse(element.price)*qnty;
        }


        grandtotal=grandtotal+price;

      }else{



        int qnty=0;

        element.qty.forEach((element) {

          qnty=int.parse(element)+qnty;

        });


        double price;


        if(element.packing!=null && element.packing!=""){
          price=double.parse(element.price)*qnty*int.parse(element.packing.toString());
        }else{
          price=double.parse(element.price)*qnty;
        }


        tnagrandtotal=tnagrandtotal+price;


      }




    });


  }





  Future<PlaceOrderResponse> placeOrder(bool refresh,Map parms) async {




    PlaceOrderResponse response;


    try{
      response = PlaceOrderResponse.fromJson((await apiProvider.getDatawithcache(Api.placeorder,parms,false)));


      if(response!=null && response.statusCode==Constant.API_CODE){
        final database = cart_database.openDB();

        cart_database.deletetable(database);

      }

    }catch(e){
      response=null;
    }


    return response;



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
    _subjectTNA.close();
    _visibleButton.close();


  }



  BehaviorSubject<List<CartConstants>> get subject => _subject;
  BehaviorSubject<List<CartConstants>> get subjectTNA => _subjectTNA;
  BehaviorSubject<bool> get visibleButton => _visibleButton;




}

final bloc = CartListBloc();