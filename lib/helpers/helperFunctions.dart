// function to handle login
import 'package:nyumbayo_app/APIS/AppUrls.dart';

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
