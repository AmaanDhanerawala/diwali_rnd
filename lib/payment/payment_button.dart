import 'package:diwali_rnd/payment/payment_manager.dart';
import 'package:diwali_rnd/payment/payment_options_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_web/razorpay_web.dart';

class PaymentButton extends ConsumerWidget implements PaymentHandler {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        PaymentOptionsModel options = PaymentOptionsModel(
          key: 'rzp_test_a7AOKGYekSZ1zZ',
          amount: 100,
          name: 'Amaan',
          timeout: 120,
          orderId: /*ref.watch(paymentController).orderCreateResponseModel?.id*/ 'rzp_temp_order_id',
          description: 'Paisa de',
          prefill: Prefill(contact: '+917572877843', email: 'amaandhanerawala@icloud.com'),
        );
        PaymentManager.payment.setPaymentOptions(options);
        PaymentManager.payment.razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
        PaymentManager.payment.razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
        PaymentManager.payment.razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
      },
      child: const Icon(Icons.payment),
    );
  }

  @override
  handleExternalWallet(ExternalWalletResponse response) {}

  @override
  handlePaymentError(PaymentFailureResponse response) {}

  @override
  handlePaymentSuccess(PaymentSuccessResponse response) {}
}
