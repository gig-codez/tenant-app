import 'dart:convert';
import 'dart:developer';

import '/models/UserModel.dart';

import '/exports/exports.dart';

class TenantController extends Cubit<UserModel> {
  TenantController() : super(user);
  static UserModel user = UserModel.fromJson({});
  void fetchTenantData(String tenantId) {
    fetchUserData(tenantId).then((value) {
      if (value.statusCode == 200) {
        user = UserModel.fromJson(json.decode(value.body));
        emit(user);
      } else {
        log("Error: ${value.body}");
      }
    });
  }
}
