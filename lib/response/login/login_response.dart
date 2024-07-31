class LoginResponse {
  String status;
  int statusCode;
  List<String> message;

  //String message;
  Data data;

  LoginResponse({this.status, this.statusCode, this.message, this.data});

  LoginResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
    message = json["message"] != null
        ? json["message"].cast<String>()
        : []; //message = json["message"];
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
  String firstname;
  String lastname;
  String email;
  String dob;
  String mobile;
  String companyName;
  String companyAddress1;
  String companyAddress2;
  String gstno;
  String securityCode;
  String city;
  String state;
  String country;
  String image;
  String isPrime;
  dynamic lastLogin;
  dynamic status;
  dynamic priceShow;
  dynamic isLocation;
  String createdDate;
  String createdAt;
  String updatedAt;
  String token;

  Data(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.dob,
      this.mobile,
      this.companyName,
      this.companyAddress1,
      this.companyAddress2,
      this.gstno,
      this.securityCode,
      this.city,
      this.state,
      this.country,
      this.image,
      this.isPrime,
      this.lastLogin,
      this.priceShow,
        this.isLocation,
      this.status,
      this.createdDate,
      this.createdAt,
      this.updatedAt,
      this.token});

  Data.fromJson(dynamic json) {
    id = json["id"];
    firstname = json["firstname"];
    lastname = json["lastname"];
    email = json["email"];
    dob = json["dob"];
    mobile = json["mobile"];
    companyName = json["company_name"];
    companyAddress1 = json["company_address_1"];
    companyAddress2 = json["company_address_2"];
    gstno = json["gstno"];
    securityCode = json["security_code"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    image = json["image"];
    isPrime = json["is_prime"];
    lastLogin = json["last_login"];
    priceShow = json["price_show"];
    isLocation = json["is_location"];
    status = json["status"];
    createdDate = json["created_date"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["email"] = email;
    map["dob"] = dob;
    map["mobile"] = mobile;
    map["company_name"] = companyName;
    map["company_address_1"] = companyAddress1;
    map["company_address_2"] = companyAddress2;
    map["gstno"] = gstno;
    map["security_code"] = securityCode;
    map["city"] = city;
    map["state"] = state;
    map["country"] = country;
    map["image"] = image;
    map["is_prime"] = isPrime;
    map["last_login"] = lastLogin;
    map["price_show"] = priceShow;
    map["is_location"] = isLocation;
    map["status"] = status;
    map["created_date"] = createdDate;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["token"] = token;
    return map;
  }
}
