import 'dart:developer';

import '/exports/exports.dart';

class Complaints {
  static Future<Response> raiseComplaint(var complaint) async {
    Response response = Response("", 200);
    try {
      response = await Client().post(Uri.parse(""), body: complaint);
    } on ClientException catch (e) {
      log(e.message);
    }
    return response;
  }
}
