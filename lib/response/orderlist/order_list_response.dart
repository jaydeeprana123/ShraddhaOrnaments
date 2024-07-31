// To parse this JSON data, do
//
//     final orderListResponse = orderListResponseFromJson(jsonString);

import 'dart:convert';

OrderListResponse orderListResponseFromJson(String str) => OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) => json.encode(data.toJson());

class OrderListResponse {
  String status;
  int statusCode;
  dynamic message;
  List<Datum> data;

  OrderListResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) => OrderListResponse(
    status: json["status"],
    statusCode: json["status_code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int userId;
  String orderCode;
  String totalPrice;
  String totalTnaPrice;
  String status;
  String createdAt;
  String city;
  String state;
  String country;

  Datum({
    this.id,
    this.userId,
    this.orderCode,
    this.totalPrice,
    this.totalTnaPrice,
    this.status,
    this.createdAt,
    this.city,
    this.state,
    this.country,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    orderCode: json["order_code"],
    totalPrice: json["total_price"],
    totalTnaPrice: json["total_tna_price"],
    status: json["status"],
    createdAt: json["created_at"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_code": orderCode,
    "total_price": totalPrice,
    "total_tna_price": totalTnaPrice,
    "status": status,
    "created_at": createdAt,
    "city": city,
    "state": state,
    "country": country,
  };
}
