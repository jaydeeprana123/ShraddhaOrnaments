// To parse this JSON data, do
//
//     final termListResponseModel = termListResponseModelFromJson(jsonString);

import 'dart:convert';

TermListResponseModel termListResponseModelFromJson(String str) => TermListResponseModel.fromJson(json.decode(str));

String termListResponseModelToJson(TermListResponseModel data) => json.encode(data.toJson());

class TermListResponseModel {
  String status;
  int statusCode;
  String message;
  List<TermData> data;

  TermListResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory TermListResponseModel.fromJson(Map<String, dynamic> json) => TermListResponseModel(
    status: json["status"],
    statusCode: json["status_code"],
    message: json["message"],
    data: List<TermData>.from(json["data"].map((x) => TermData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TermData {
  int id;
  String term;

  TermData({
    this.id,
    this.term,
  });

  factory TermData.fromJson(Map<String, dynamic> json) => TermData(
    id: json["id"],
    term: json["term"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "term": term,
  };
}
