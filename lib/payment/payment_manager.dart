import 'package:diwali_rnd/payment/payment_options_model.dart';
import 'package:razorpay_web/razorpay_web.dart';

abstract class PaymentHandler {
  handlePaymentSuccess(PaymentSuccessResponse response);

  handlePaymentError(PaymentFailureResponse response);

  handleExternalWallet(ExternalWalletResponse response);
}

///[PaymentManager] to access all the variables regarding payment
class PaymentManager {
  PaymentManager._();

  static PaymentManager payment = PaymentManager._();

  Razorpay razorpay = Razorpay();

  clearAllListeners() {
    razorpay.clear();
  }

  setPaymentOptions(PaymentOptionsModel options) {
    razorpay.open(paymentOptionsModelToJson(options));
  }
}
