class ForGotPasswordResponse {
  String status;
  int statusCode;
 // String message;

  ForGotPasswordResponse({
      this.status, 
      this.statusCode, 
   //   this.message,
      });

  ForGotPasswordResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
   // message = json["message"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["status_code"] = statusCode;
   // map["message"] = message;

    return map;
  }

}