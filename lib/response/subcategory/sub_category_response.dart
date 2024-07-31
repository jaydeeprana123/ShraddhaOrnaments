class SubCategoryResponse {
  String status;
  int statusCode;
 // List<String> message;
  List<Data> data;

  SubCategoryResponse({
      this.status, 
      this.statusCode, 
     // this.message,
      this.data});

  SubCategoryResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
   // message = json["message"] != null ? json["message"].cast<String>() : [];//message = json["message"];
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
   // map["message"] = message;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  int id;
  String categoryTagId;
  String title;
  String image;
  int count;

  Data({
      this.id, 
      this.categoryTagId, 
      this.title, 
      this.count,
      this.image});

  Data.fromJson(dynamic json) {
    id = json["id"];
    categoryTagId = json["category_tag_id"];
    title = json["title"];
    image = json["image"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["category_tag_id"] = categoryTagId;
    map["title"] = title;
    map["image"] = image;
    map["count"] = count;
    return map;
  }

}