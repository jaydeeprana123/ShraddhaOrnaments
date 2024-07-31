class PlaceOrderResponse {
  String status;
  int statusCode;
  String message;
 // Data data;

  PlaceOrderResponse({
      this.status, 
      this.statusCode, 
      this.message, 
  //    this.data
  });

  PlaceOrderResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
    message = json["message"];
   // data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["status_code"] = statusCode;
    map["message"] = message;
   /* if (data != null) {
      map["data"] = data.toJson();
    }*/
    return map;
  }

}

class Data {
  String userId;
  String orderCode;
  String updatedAt;
  String createdAt;
  int id;

  Data({
      this.userId, 
      this.orderCode, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  Data.fromJson(dynamic json) {
    userId = json["user_id"];
    orderCode = json["order_code"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = userId;
    map["order_code"] = orderCode;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}