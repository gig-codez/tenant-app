import '/exports/exports.dart';
import '/models/Payment.dart';

class Payments {
  static Future<Response> makePayments(String tenantId, Payment pay) async {
    // adding different payments

    var p = {
      "balance": pay.balance,
      "amountPaid": pay.amount,
      "property": pay.property,
      "tenantId": tenantId,
      "tenantName": pay.tenantName,
      "paymentMode": pay.paymentMode,
      "paymentStatus": pay.status,
      "date": pay.date,
    };
    Response response = await Client().post(Uri.parse("uri"),
        body: p); //creating the payments collection in the firestore database
    return response;
    debugPrint("Payment record saved successfully..");
  }
}
