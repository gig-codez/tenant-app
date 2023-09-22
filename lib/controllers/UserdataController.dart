import 'dart:convert';

import 'package:nyumbayo_app/exports/exports.dart';
import '/models/UserAccountModel.dart';

class UserAccountController extends Cubit<UserAccountModel> {
  UserAccountController() : super(userModel);
  static UserAccountModel userModel = UserAccountModel(
    userId: "",
    landlordId: "",
    token: "",
    email: "",
    name: "",
  );
// capture user data
  void captureData(String userData) {
    SharedPreferences.getInstance().then((value) {
      value.setString("userAccountData", userData);
    });
    UserAccountModel userAccountModel =
        UserAccountModel.fromJson(json.decode(userData));
    emit(userAccountModel);
  }

  getUserData() {
    SharedPreferences.getInstance().then((userData) {
      String? saved = userData.getString("userAccountData");
      if (saved != null && saved.isNotEmpty) {
        UserAccountModel userAccountModel = UserAccountModel.fromJson(
          json.decode(saved),
        );
        emit(userAccountModel);
      }
    });
  }
}
