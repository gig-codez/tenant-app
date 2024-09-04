import 'dart:convert';

import 'package:nyumbayo_app/exports/exports.dart';

class UserController extends Cubit<Map<String, dynamic>> {
  UserController() : super({});
  // capture user data from user model
  void captureUser(Map<String, dynamic> user) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('user', jsonEncode(user));
    });
    emit(user);
  }
}
