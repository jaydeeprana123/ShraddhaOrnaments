class HomeSliderResponse {
  String status;
  int statusCode;
  String message;
  List<Data> data;

  HomeSliderResponse({
      this.status, 
      this.statusCode, 
      this.message, 
      this.data});

  HomeSliderResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(Data.fromJson(v));
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

class Data {
  int id;
  String categoryId;
  dynamic topTitle;
  dynamic mainTitle;
  dynamic subTitle;
  String image;
  String created;
  String updated;

  Data({
      this.id, 
      this.categoryId, 
      this.topTitle, 
      this.mainTitle, 
      this.subTitle, 
      this.image, 
      this.created, 
      this.updated});

  Data.fromJson(dynamic json) {
    id = json["id"];
    categoryId = json["category_id"];
    topTitle = json["top_title"];
    mainTitle = json["main_title"];
    subTitle = json["sub_title"];
    image = json["image"];
    created = json["created"];
    updated = json["updated"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["category_id"] = categoryId;
    map["top_title"] = topTitle;
    map["main_title"] = mainTitle;
    map["sub_title"] = subTitle;
    map["image"] = image;
    map["created"] = created;
    map["updated"] = updated;
    return map;
  }

}