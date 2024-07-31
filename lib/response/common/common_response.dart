class CommonResponse {
  String status;
  int statusCode;
  dynamic message;
  Data data;

  CommonResponse({
      this.status, 
      this.statusCode, 
      this.message, 
      this.data});

  CommonResponse.fromJson(dynamic json) {
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
  String logo;
  String background;
  String siteTitle;
  String email;
  String phone;
  String address;
  String android_version;
  String ios_version;

  Data({
      this.logo, 
      this.background, 
      this.siteTitle, 
      this.email, 
      this.phone,
      this.android_version,
      this.ios_version,
      this.address});

  Data.fromJson(dynamic json) {
    logo = json["logo"];
    background = json["background"];
    siteTitle = json["site_title"];
    email = json["email"];
    phone = json["phone"];
    address = json["address"];
    android_version = json["android_version"];
    ios_version = json["ios_version"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["logo"] = logo;
    map["background"] = background;
    map["site_title"] = siteTitle;
    map["email"] = email;
    map["phone"] = phone;
    map["address"] = address;
    map["android_version"] = android_version;
    map["ios_version"] = ios_version;
    return map;
  }

}