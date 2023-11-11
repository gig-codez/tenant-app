import 'package:nyumbayo_app/APIS/Api.dart';

import '../exports/exports.dart';

class MainController extends ChangeNotifier {
  bool _power = false;
  final List<Map<String, dynamic>> _complaints = [];

  String _property = "";
  bool _online = false;
  // getters
  bool get power => _power;
  // power consumed

  String get property => _property;
  List<Map<String, dynamic>> get complaints => _complaints;
  bool get online => _online;

  checkOnline() {
    InternetConnectionChecker.createInstance()
        .hasConnection
        .asStream()
        .listen((event) {
      _online = event;
      notifyListeners();
    });
  }
}
