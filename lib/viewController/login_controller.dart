import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/services/authentication_service.dart';

enum LoginType { google_login, facebook_login, apple_login }

class LoginViewController {
  AuthenticationService _authenticationService = AuthenticationService.instance;

  Future login(LoginType loginType) async {
    switch (loginType) {
      case LoginType.google_login:
        var user = UserApp("Haha");
        _authenticationService.changeAuthState(user);
        break;
      case LoginType.facebook_login:
        // TODO: Handle this case.
        break;
      case LoginType.apple_login:
        // TODO: Handle this case.
        break;
    }
  }
}
