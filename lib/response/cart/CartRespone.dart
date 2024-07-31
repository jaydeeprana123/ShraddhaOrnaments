class CartRespone {
  CartRespone({
      this.status, 
      this.statusCode, 
      this.message, 
      this.data,});

  CartRespone.fromJson(dynamic json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<dynamic>() : [];
  }
  String status;
  int statusCode;
  String message;
  List<dynamic> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_code'] = statusCode;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}