import 'dart:convert';

import '../exports/exports.dart';

class MainController extends ChangeNotifier {
  SharedPreferences? prefs;
  MainController() {
    loadSavedData();
  }
  // user data
  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => _userData;
  set userData(Map<String, dynamic> data) {
    _userData = data;
    prefs?.setString('user', json.encode(data));
    notifyListeners();
  }
//  end of user data

  void loadSavedData() async {
    prefs = await SharedPreferences.getInstance();
    _userData = json.decode(prefs?.getString('user') ?? "{}");
  }
}
