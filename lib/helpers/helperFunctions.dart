// function to handle login
import 'dart:developer';

import 'package:nyumbayo_app/APIS/AppUrls.dart';
import 'package:nyumbayo_app/models/Complaints.dart';
import 'package:nyumbayo_app/models/Payment.dart';

import '/exports/exports.dart';

Future<Response> tenantLogin(String email, String password) async {
  Response response = await Client().post(
    Uri.parse(Feeds.tenantLogin),
    body: {'email': email, 'password': password},
  );
  return response;
}

// function to verify account
Future<Response> verifyEmail(String email) async {
  Response response = await Client().post(
    Uri.parse("uri"),
    body: {'email': email},
  );
  return response;
}

// function to fetch user data
Future<Response> fetchUserData(String user) async {
  Response response = Response.bytes([], 200);
  try {
    response = await Client().get(Uri.parse(Feeds.tenantDetails + user));
  } on ClientException catch (e) {
    log(e.message);
  }
  return response;
}

// function to fetch the payment recorded
Future<Response> fetchPaymentRecord(String user) async {
  Response response = Response.bytes([], 200);
  try {
    response = await Client().get(Uri.parse(Feeds.tenantLastPayment + user));
  } on ClientException catch (e) {
    log(e.message);
  }
  return response;
}

Future<List<ComplaintModel>> fetchComplaints(String userId) async {
  List<ComplaintModel> complaints = [];
  Response response =
      await Client().get(Uri.parse(Feeds.tenantComplaints + userId));
  if (response.statusCode == 200) {
    complaints = complaintModelFromJson(response.body);
    return complaints;
  }
  return complaints;
}

// function to fetch payments made by the tenant
Future<List<PaymentModel>> fetchTenantPayments(String tenantId) async {
  Response response =
      await Client().get(Uri.parse(Feeds.tenantPayments + tenantId));
  return paymentModelFromJson(response.body);
}
