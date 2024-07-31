import 'package:flutter/cupertino.dart';

class ProductDetailsResponse {
  String status;
  int statusCode;
  String message;
  Data data;

  ProductDetailsResponse({
      this.status, 
      this.statusCode, 
      this.message, 
      this.data});

  ProductDetailsResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
    message = json["message"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["status_code"] = statusCode;
    map["message"] = message;
    if (data != null) {
      map["data"] = data.toJson();
    }
    return map;
  }

}

class Data {
  int id;
  String categoryId;
  String title;
  String description;
  String itemNo;
  String productCode;
  String price;
  String quantity;
  String sellingType;
  String size;
  String brand;
  String department;
  String width;
  String length;
  String colour;
  String material;
  String plating;
  String stoneType;
  String tna;
  String packing;
  String wishlist;
  Object prev_id;
  Object next_id;
  List<String> productImages;
  List<String> qty=[];
  List<String> sizeList=[];
  List<TextEditingController >  boxcontroller=[];

  Data({
      this.id, 
      this.categoryId, 
      this.title, 
      this.description, 
      this.itemNo, 
      this.productCode, 
      this.price, 
      this.quantity, 
      this.sellingType, 
      this.size, 
      this.brand, 
      this.department, 
      this.width, 
      this.length, 
      this.colour, 
      this.material, 
      this.plating, 
      this.stoneType, 
      this.tna, 
      this.packing, 
      this.wishlist,
      this.prev_id,
      this.next_id,
      this.productImages});

  Data.fromJson(dynamic json) {
    id = json["id"];
    categoryId = json["category_id"];
    title = json["title"];
    description = json["description"];
    itemNo = json["item_no"];
    productCode = json["product_code"];
    price = json["price"];
    quantity = json["quantity"];
    sellingType = json["selling_type"];
    size = json["size"];
    brand = json["brand"];
    department = json["department"];
    width = json["width"];
    length = json["length"];
    colour = json["colour"];
    material = json["material"];
    plating = json["plating"];
    stoneType = json["stone_type"];
    tna = json["tna"];
    packing = json["packing"];
    wishlist = json["wishlist"];
    prev_id = json["prev_id"];
    next_id = json["next_id"];
    productImages = json["product_images"] != null ? json["product_images"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["category_id"] = categoryId;
    map["title"] = title;
    map["description"] = description;
    map["item_no"] = itemNo;
    map["product_code"] = productCode;
    map["price"] = price;
    map["quantity"] = quantity;
    map["selling_type"] = sellingType;
    map["size"] = size;
    map["brand"] = brand;
    map["department"] = department;
    map["width"] = width;
    map["length"] = length;
    map["colour"] = colour;
    map["material"] = material;
    map["plating"] = plating;
    map["stone_type"] = stoneType;
    map["tna"] = tna;
    map["packing"] = packing;
    map["wishlist"] = wishlist;
    map["prev_id"] = prev_id;
    map["next_id"] = next_id;
    map["product_images"] = productImages;
    return map;
  }

}