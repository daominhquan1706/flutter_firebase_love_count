import 'dart:async';

import 'package:flutter_lovecount/model/user_model.dart';
import 'package:flutter_lovecount/services/authentication_service.dart';
import 'package:get/get.dart';

enum LoginType { google_login, facebook_login, apple_login }

class LoginViewController {
  AuthenticationService get _authenticationService => Get.find<AuthenticationService>();

  FutureOr<void> login(LoginType loginType) async {
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
