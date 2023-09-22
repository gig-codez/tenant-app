// To parse this JSON data, do
//
//     final userAccountModel = userAccountModelFromJson(jsonString);

import 'dart:convert';

UserAccountModel userAccountModelFromJson(String str) =>
    UserAccountModel.fromJson(json.decode(str));

String userAccountModelToJson(UserAccountModel data) =>
    json.encode(data.toJson());

class UserAccountModel {
  final String userId;
  final String landlordId;
  final String token;
  final String email;
  final String name;

  UserAccountModel({
    required this.userId,
    required this.landlordId,
    required this.token,
    required this.email,
    required this.name,
  });

  factory UserAccountModel.fromJson(Map<String, dynamic> json) =>
      UserAccountModel(
        userId: json["userId"],
        landlordId: json["landlordId"],
        token: json["token"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "landlordId": landlordId,
        "token": token,
        "email": email,
        "name": name,
      };
}
