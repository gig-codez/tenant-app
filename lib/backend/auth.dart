// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import '/helpers/session_manager.dart';
import '../exports/exports.dart';

class Auth {
  // landlord sign
  static Future<UserCredential> signInTenant(
      String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e, stackTrace) {
      AuthExceptionHandler.handleAuthException(e.message ?? "");
      return Future.error(e, stackTrace);
    }
  }

  static Future<void> apiLogin(String email, String password,
      BuildContext context, LoaderController controller) async {
    Response? response;
    try {
      response = await tenantLogin(email, password);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        // save user session
        await SessionManager().storeToken(data["token"]);
        // capture user data
        context.read<MainController>().userData = data;
        controller.loginLoader = false;
        Routes.routeUntil(context, Routes.dashboard);
        //
        showMessage(context: context, msg: "Logged in Successfully");
      } else {
        showMessage(
            context: context,
            msg: "Login failed: ${data['message']}",
            type: 'danger');
      }
    } on ClientException catch (e) {
      AuthExceptionHandler.handleAuthException(e.message);
    }
  }

  static Future<void> signOut() async {
    await SessionManager().clearToken();
  }

  static Future<void> resetPassword({required String email}) async {
    try {
      Client().post(Uri.parse("uri"));
    } on ClientException catch (e, _) {
      // status = AuthExceptionHandler.handleAuthException(e.message);
    }
  }
}

// exception handler

enum AuthStatus {
  wrongPassword,
  emailAlreadyExists,
  emailDoesnotExist,
  weakPassword,
  unknown
}

class AuthExceptionHandler {
  static AuthStatus handleAuthException(String msg) {
    AuthStatus status;
    switch (msg) {
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;

      case "email-doesnot-exist":
        status = AuthStatus.emailDoesnotExist;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;

      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static void generateErrorMessage(AuthStatus error, BuildContext context) {
    String? errorMessage;
    switch (error) {
      case AuthStatus.weakPassword:
        errorMessage = "Your password should be at least 6 characters.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your email or password is wrong.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
            "The email address is already in use by another account.";
        break;
      case AuthStatus.emailDoesnotExist:
        errorMessage = "The email address doesn't exist.";
        break;
      case AuthStatus.unknown:
        errorMessage = null;
        break;
    }
    if (errorMessage != null) {
      showMessage(context: context, msg: errorMessage, type: 'danger');
    }
  }
}
