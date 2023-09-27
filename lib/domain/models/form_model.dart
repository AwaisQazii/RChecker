// To parse this JSON data, do
//
//     final formModel = formModelFromJson(jsonString);

import 'dart:convert';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  String? docId;
  String? name;
  String? cnic;
  String? seatNo;
  String? district;
  double? marks;
  String? testName;
  String? coaching;
  String? college;

  int? attempt;
  int? year;

  FormModel({
    this.docId,
    this.name,
    this.cnic,
    this.seatNo,
    this.district,
    this.testName,
    this.marks,
    this.coaching,
    this.attempt,
    this.college,
    this.year,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        docId: json["docId"],
        name: json["name"],
        cnic: json["cnic"],
        seatNo: json["seatNo"],
        district: json["district"],
        marks: json["marks"],
        coaching: json["coaching"],
        college: json["college"],
        testName: json["testName"],
        attempt: json["attempt"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "docId": docId,
        "name": name,
        "cnic": cnic,
        "seatNo": seatNo,
        "district": district?.toUpperCase() ?? "",
        "marks": marks,
        "coaching": coaching,
        "college": college,
        "testName": testName?.toUpperCase() ?? "",
        "attempt": attempt,
        "year": year,
      };
}
