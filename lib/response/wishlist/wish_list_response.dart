class WishListResponse {
  String status;
  int statusCode;
  dynamic message;
  List<Data> data;

  WishListResponse({
      this.status, 
      this.statusCode, 
      this.message, 
      this.data});

  WishListResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["status_code"] = statusCode;
    map["message"] = message;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  int id;
  String title;
  String productCode;
  String price;
  String sellingType;
  String tna;
  String packing;
  String size;
  String imageName;

  Data({
      this.id, 
      this.title, 
      this.productCode, 
      this.price, 
      this.sellingType, 
      this.tna, 
      this.packing, 
      this.size, 
      this.imageName});

  Data.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    productCode = json["product_code"];
    price = json["price"];
    sellingType = json["selling_type"];
    tna = json["tna"];
    packing = json["packing"];
    size = json["size"];
    imageName = json["image_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["product_code"] = productCode;
    map["price"] = price;
    map["selling_type"] = sellingType;
    map["tna"] = tna;
    map["packing"] = packing;
    map["size"] = size;
    map["image_name"] = imageName;
    return map;
  }

}