// To parse this JSON data, do
//
//     final orderDetailsResponse = orderDetailsResponseFromJson(jsonString);

import 'dart:convert';

OrderDetailsResponse orderDetailsResponseFromJson(String str) => OrderDetailsResponse.fromJson(json.decode(str));

String orderDetailsResponseToJson(OrderDetailsResponse data) => json.encode(data.toJson());

class OrderDetailsResponse {
  String status;
  int statusCode;
  dynamic message;
  OrderData data;

  OrderDetailsResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => OrderDetailsResponse(
    status: json["status"],
    statusCode: json["status_code"],
    message: json["message"],
    data: OrderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class OrderData {
  int id;
  int userId;
  String orderCode;
  String totalPrice;
  String totalTnaPrice;
  String status;
  DateTime createdAt;
  List<OrderDetail> orderDetail;

  OrderData({
    this.id,
    this.userId,
    this.orderCode,
    this.totalPrice,
    this.totalTnaPrice,
    this.status,
    this.createdAt,
    this.orderDetail,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    userId: json["user_id"],
    orderCode: json["order_code"],
    totalPrice: json["total_price"],
    totalTnaPrice: json["total_tna_price"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    orderDetail: List<OrderDetail>.from(json["order_detail"].map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_code": orderCode,
    "total_price": totalPrice,
    "total_tna_price": totalTnaPrice,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
  };
}

class OrderDetail {
  int id;
  String orderId;
  String productId;
  String price;
  String quantity;
  List<QuantityType> quantityType;
  String tna;
  String imageName;
  String productTitle;
  String packing;

  OrderDetail({
    this.id,
    this.orderId,
    this.productId,
    this.price,
    this.quantity,
    this.quantityType,
    this.tna,
    this.imageName,
    this.packing,
    this.productTitle});

  OrderDetail.fromJson(dynamic json) {
    id = json["id"];
    orderId = json["order_id"];
    productId = json["product_id"];
    price = json["price"];
    quantity = json["quantity"];
    if (json["quantity_type"] != null) {
      quantityType = [];
      json["quantity_type"].forEach((v) {
        quantityType.add(QuantityType.fromJson(v));
      });
    }
    tna = json["tna"];
    imageName = json["image_name"];
    packing = json["packing"];
    productTitle = json["product_title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["order_id"] = orderId;
    map["product_id"] = productId;
    map["price"] = price;
    map["quantity"] = quantity;
    if (quantityType != null) {
      map["quantity_type"] = quantityType.map((v) => v.toJson()).toList();
    }
    map["tna"] = tna;
    map["image_name"] = imageName;
    map["packing"] = packing;
    map["product_title"] = productTitle;
    return map;
  }

}

class QuantityType {
  String type;
  String value;

  QuantityType({
    this.type,
    this.value});

  QuantityType.fromJson(dynamic json) {
    type = json["type"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["value"] = value;
    return map;
  }

}
