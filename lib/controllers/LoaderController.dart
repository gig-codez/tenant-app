import '../exports/exports.dart';

class LoaderController with ChangeNotifier {
  // login loader
  bool _loginLoader = false;
  bool get loginLoader => _loginLoader;
  set loginLoader(bool value) {
    _loginLoader = value;
    notifyListeners();
  }

  //
}
