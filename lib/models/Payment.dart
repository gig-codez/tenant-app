// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(json.decode(str).map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
    final String id;
    final int amountPaid;
    final int balance;
    final Tenant tenant;
    final Property property;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    PaymentModel({
        required this.id,
        required this.amountPaid,
        required this.balance,
        required this.tenant,
        required this.property,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["_id"] ??"",
        amountPaid: json["amount_paid"]??0,
        balance: json["balance"]??0,
        tenant: Tenant.fromJson(json["tenant"]??{}),
        property: Property.fromJson(json["property"]??{}),
        createdAt: DateTime.parse(json["createdAt"]??DateTime.now().toString()),
        updatedAt: DateTime.parse(json["updatedAt"]??DateTime.now().toString()),
        v: json["__v"]??0,
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "amount_paid": amountPaid,
        "balance": balance,
        "tenant": tenant.toJson(),
        "property": property.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Property {
    final String id;
    final String name;
    final String address;
    final String landlord;

    Property({
        required this.id,
        required this.name,
        required this.address,
        required this.landlord,
    });

    factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["_id"]??"",
        name: json["name"]??"",
        address: json["address"]??"",
        landlord: json["landlord"]??"",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address,
        "landlord": landlord,
    };
}

class Tenant {
    final String id;
    final String name;
    final String email;
    final String phone;
    final String profile;
    final String property;

    Tenant({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.profile,
        required this.property,
    });

    factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json["_id"]??"",
        name: json["name"]??"",
        email: json["email"]??"",
        phone: json["phone"]??"",
        profile: json["profile"]??"",
        property: json["property"]??"",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "profile": profile,
        "property": property,
    };
}
