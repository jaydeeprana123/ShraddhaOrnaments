class AddRemoveWishlistResponse {
  String status;
  int statusCode;
 // String message;
  Data data;

  AddRemoveWishlistResponse({
      this.status, 
      this.statusCode, 
     // this.message,
      this.data});

  AddRemoveWishlistResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
    //message = json["message"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["status_code"] = statusCode;
   // map["message"] = message;
    if (data != null) {
      map["data"] = data.toJson();
    }
    return map;
  }

}

class Data {
  String userId;
  String productId;
  int id;

  Data({
      this.userId, 
      this.productId, 
      this.id});

  Data.fromJson(dynamic json) {
    userId = json["user_id"];
    productId = json["product_id"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = userId;
    map["product_id"] = productId;
    map["id"] = id;
    return map;
  }

}