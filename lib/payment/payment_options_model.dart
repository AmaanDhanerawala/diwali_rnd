// To parse this JSON data, do
//
//     final paymentOptionsModel = paymentOptionsModelFromJson(jsonString);

import 'dart:convert';

PaymentOptionsModel paymentOptionsModelFromJson(String str) => PaymentOptionsModel.fromJson(json.decode(str));

Map<String, dynamic> paymentOptionsModelToJson(PaymentOptionsModel data) => data.toJson();

class PaymentOptionsModel {
  String? key;
  int? amount;
  int? timeout;
  String? name;
  String? description;
  String? orderId;
  Prefill? prefill;

  PaymentOptionsModel({
    this.key,
    this.amount,
    this.orderId,
    this.name,
    this.timeout,
    this.description,
    this.prefill,
  });

  factory PaymentOptionsModel.fromJson(Map<String, dynamic> json) => PaymentOptionsModel(
        key: json["key"],
        amount: json["amount"],
        name: json["name"],
        timeout: json["timeout"],
        description: json["description"],
        orderId: json["id"],
        prefill: json["prefill"] == null ? null : Prefill.fromJson(json["prefill"]),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "amount": amount,
        "name": name,
        "id": orderId,
        "timeout": timeout,
        "description": description,
        "prefill": prefill?.toJson(),
      };
}

class Prefill {
  String? contact;
  String? email;

  Prefill({
    this.contact,
    this.email,
  });

  factory Prefill.fromJson(Map<String, dynamic> json) => Prefill(
        contact: json["contact"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "contact": contact,
        "email": email,
      };
}
