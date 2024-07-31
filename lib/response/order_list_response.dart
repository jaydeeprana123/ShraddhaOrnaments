class OrderListResponse {
  String status;
  int statusCode;
  dynamic message;
  List<OrderData> data;

  OrderListResponse({
      this.status, 
      this.statusCode, 
      this.message, 
      this.data});

  OrderListResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(OrderData.fromJson(v));
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

class OrderData {
  int id;
  String userId;
  String orderCode;
  dynamic remarks;
  String pdf;
  String totalPrice;
  String totalTnaPrice;
  String status;
  String createdAt;
  String companyAddress1;
  String companyAddress2;
  String city;
  String state;
  String country;
  List<Order_detail> orderDetail;

  OrderData({
      this.id, 
      this.userId, 
      this.orderCode, 
      this.remarks, 
      this.pdf, 
      this.totalPrice, 
      this.totalTnaPrice, 
      this.status, 
      this.createdAt, 
      this.companyAddress1, 
      this.companyAddress2, 
      this.city, 
      this.state, 
      this.country, 
      this.orderDetail});

  OrderData.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    orderCode = json["order_code"];
    remarks = json["remarks"];
    pdf = json["pdf"];
    totalPrice = json["total_price"];
    totalTnaPrice = json["total_tna_price"];
    status = json["status"];
    createdAt = json["created_at"];
    companyAddress1 = json["company_address_1"];
    companyAddress2 = json["company_address_2"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    if (json["order_detail"] != null) {
      orderDetail = [];
      json["order_detail"].forEach((v) {
        orderDetail.add(Order_detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["order_code"] = orderCode;
    map["remarks"] = remarks;
    map["pdf"] = pdf;
    map["total_price"] = totalPrice;
    map["total_tna_price"] = totalTnaPrice;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["company_address_1"] = companyAddress1;
    map["company_address_2"] = companyAddress2;
    map["city"] = city;
    map["state"] = state;
    map["country"] = country;
    if (orderDetail != null) {
      map["order_detail"] = orderDetail.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Order_detail {
  int id;
  String orderId;
  String product_id;
  String price;
  String quantity;
  List<Quantity_type> quantityType;
  String tna;
  String imageName;
  String productTitle;
  String packing;

  Order_detail({
      this.id, 
      this.orderId, 
      this.product_id,
      this.price,
      this.quantity, 
      this.quantityType, 
      this.tna, 
      this.imageName, 
      this.packing,
      this.productTitle});

  Order_detail.fromJson(dynamic json) {
    id = json["id"];
    orderId = json["order_id"];
    product_id = json["product_id"];
    price = json["price"];
    quantity = json["quantity"];
    if (json["quantity_type"] != null) {
      quantityType = [];
      json["quantity_type"].forEach((v) {
        quantityType.add(Quantity_type.fromJson(v));
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
    map["product_id"] = product_id;
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

class Quantity_type {
  String type;
  String value;

  Quantity_type({
      this.type, 
      this.value});

  Quantity_type.fromJson(dynamic json) {
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