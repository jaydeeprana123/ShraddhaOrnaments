class AboutUsResponse {
  String status;
  int statusCode;
  dynamic message;
  Data data;

  AboutUsResponse({
      this.status, 
      this.statusCode, 
      this.message, 
      this.data});

  AboutUsResponse.fromJson(dynamic json) {
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
  String slug;
  String title;
  String content;
  String status;

  Data({
      this.slug, 
      this.title, 
      this.content, 
      this.status});

  Data.fromJson(dynamic json) {
    slug = json["slug"];
    title = json["title"];
    content = json["content"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["slug"] = slug;
    map["title"] = title;
    map["content"] = content;
    map["status"] = status;
    return map;
  }

}