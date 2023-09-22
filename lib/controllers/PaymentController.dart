import 'dart:convert';

import '/exports/exports.dart';
import '/models/Payment.dart';

class PaymentController extends Cubit<PaymentModel> {
  PaymentController() : super(paymentModel);
  static PaymentModel paymentModel = PaymentModel.fromJson({});
  fetchLastPayment(String tenantId) {
    fetchPaymentRecord(tenantId).then((value) {
      if (value.statusCode == 200) {
        PaymentModel pay = PaymentModel.fromJson(json.decode(value.body));
        emit(pay);
      }
    });
  }
}
