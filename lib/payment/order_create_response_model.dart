// To parse this JSON data, do
//
//     final orderCreateResponseModel = orderCreateResponseModelFromJson(jsonString);

import 'dart:convert';

OrderCreateResponseModel orderCreateResponseModelFromJson(String str) => OrderCreateResponseModel.fromJson(json.decode(str));

String orderCreateResponseModelToJson(OrderCreateResponseModel data) => json.encode(data.toJson());

class OrderCreateResponseModel {
  int? amount;
  int? amountDue;
  int? amountPaid;
  int? attempts;
  int? createdAt;
  String? currency;
  String? entity;
  String? id;
  List<dynamic>? notes;
  dynamic offerId;
  String? receipt;
  String? status;

  OrderCreateResponseModel({
    this.amount,
    this.amountDue,
    this.amountPaid,
    this.attempts,
    this.createdAt,
    this.currency,
    this.entity,
    this.id,
    this.notes,
    this.offerId,
    this.receipt,
    this.status,
  });

  factory OrderCreateResponseModel.fromJson(Map<String, dynamic> json) => OrderCreateResponseModel(
    amount: json["amount"],
    amountDue: json["amount_due"],
    amountPaid: json["amount_paid"],
    attempts: json["attempts"],
    createdAt: json["created_at"],
    currency: json["currency"],
    entity: json["entity"],
    id: json["id"],
    notes: json["notes"] == null ? [] : List<dynamic>.from(json["notes"]!.map((x) => x)),
    offerId: json["offer_id"],
    receipt: json["receipt"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "amount_due": amountDue,
    "amount_paid": amountPaid,
    "attempts": attempts,
    "created_at": createdAt,
    "currency": currency,
    "entity": entity,
    "id": id,
    "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
    "offer_id": offerId,
    "receipt": receipt,
    "status": status,
  };
}
