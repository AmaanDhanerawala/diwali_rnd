import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:diwali_rnd/payment/order_create_response_model.dart';
import 'package:diwali_rnd/payment/payment_options_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentController = ChangeNotifierProvider((ref) => PaymentController());

class PaymentController extends ChangeNotifier {
  clearController() {
    isLoading = false;
    orderCreateResponseModel = null;
    notifyListeners();
  }

  OrderCreateResponseModel? orderCreateResponseModel;
  bool isLoading = false;

  Future<void> createOrderApi(PaymentOptionsModel options) async {
    Dio dio = Dio();
    Map<String, dynamic> headers = ({
      'Authorization': 'Basic ${base64Encode(utf8.encode('rzp_live_SV3oKwNQQEshmW:GtCyIBv2E9kTAHcen1gD1g0v'))}',
      'content-type': 'application/json',
    });
    dio.options.headers = headers;
    Map<String, dynamic> data = ({
      "amount": options.amount,
      "currency": "INR",
      "receipt": options.orderId,
    });
    isLoading = true;
    notifyListeners();
    try {
      isLoading = false;
      notifyListeners();
      await dio.post('https://api.razorpay.com/v1/orders', data: data, onReceiveProgress: (int count, int total) {}).then((value) {
        orderCreateResponseModel = OrderCreateResponseModel.fromJson(value.data);
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}
