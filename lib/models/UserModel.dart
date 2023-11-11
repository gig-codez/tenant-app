// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String name;
  final String address;
  final String email;
  final String phone;
  final String password;
  final String profile;
  final String property;
  final String landlord;
  final int monthlyRent;
  final int powerFee;
  final int powerStatus;
  final int otp;
  final String fcmToken;
  final bool isEmailVerified;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserModel({
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.password,
    required this.profile,
    required this.property,
    required this.landlord,
    required this.monthlyRent,
    required this.powerFee,
    required this.powerStatus,
    required this.otp,
    required this.fcmToken,
    required this.isEmailVerified,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"]??"",
        address: json["address"]??"",
        email: json["email"]??"",
        phone: json["phone"]??"",
        password: json["password"]??"",
profile: json["profile"]??"",
        property: json["property"]??"",
        landlord: json["landlord"]??"",
        monthlyRent: json["monthly_rent"]??0,
        powerFee: json["power_fee"]??0,
        powerStatus: json["power_status"]??0,
        otp: json["otp"]??0,
        fcmToken: json["fcm_token"]??"",
        isEmailVerified: json["isEmailVerified"]??false,
        id: json["_id"]??"",
        createdAt: DateTime.now(),//parse(json["createdAt"]),
        updatedAt: DateTime.now(),//parse(json["updatedAt"]),
        v: json["__v"]??0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "email": email,
        "phone": phone,
        "password": password,
        "profile": profile,
        "property": property,
        "landlord": landlord,
        "monthly_rent": monthlyRent,
        "power_fee": powerFee,
        "power_status": powerStatus,
        "otp": otp,
        "fcm_token": fcmToken,
        "isEmailVerified": isEmailVerified,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
