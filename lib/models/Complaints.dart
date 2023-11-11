// To parse this JSON data, do
//
//     final complaintModel = complaintModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ComplaintModel> complaintModelFromJson(String str) =>
    List<ComplaintModel>.from(
        json.decode(str).map((x) => ComplaintModel.fromJson(x)));

String complaintModelToJson(List<ComplaintModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplaintModel {
  final String id;
  final String tenant;
  final String property;
  final String complaintName;
  final String complaintDescription;
  final String complaintStatus;
  final String complaintImage;
  final String reason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ComplaintModel({
    required this.id,
    required this.tenant,
    required this.property,
    required this.complaintName,
    required this.complaintDescription,
    required this.complaintStatus,
    required this.complaintImage,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) => ComplaintModel(
        id: json["_id"],
        tenant: json["tenant"],
        property: json["property"],
        complaintName: json["complaint_name"],
        complaintDescription: json["complaint_description"],
        complaintStatus: json["complaint_status"],
        complaintImage: json["complaint_image"],
        reason: json["reason"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tenant": tenant,
        "property": property,
        "complaint_name": complaintName,
        "complaint_description": complaintDescription,
        "complaint_status": complaintStatus,
        "complaint_image": complaintImage,
        "reason": reason,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
