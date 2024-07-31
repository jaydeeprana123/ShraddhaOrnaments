
import 'package:flutter/cupertino.dart';

class CartConstants {



  String id="";
  String pid="";
  String title="";
  String image="";
  String code="";
  String qnt="";
  String boxtype="";
  String size="";
  String tna="";
  String price="";
  String packing="";

  List<String> qty=[];
  List<String> sizeList=[];
  List<TextEditingController >  boxcontroller=[];


  CartConstants({this.id, this.pid, this.title, this.image, this.code, this.qnt,
    this.boxtype, this.size, this.tna, this.price, this.packing});
}
