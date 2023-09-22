import 'dart:convert';

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(
    json.decode(str).map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
  final String id;
  final int amountPaid;
  final int balance;
  final String date;
  final String tenant;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  PaymentModel({
    required this.id,
    required this.amountPaid,
    required this.balance,
    required this.date,
    required this.tenant,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["_id"],
        amountPaid: json["amount_paid"],
        balance: json["balance"],
        date: json["date"],
        tenant: json["tenant"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount_paid": amountPaid,
        "balance": balance,
        "date": date,
        "tenant": tenant,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
