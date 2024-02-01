import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lovecount/services/authentication_service.dart';
import 'package:get/get.dart';

enum LoginType { google_login, facebook_login, apple_login }

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  AuthenticationService get _authenticationService => Get.find<AuthenticationService>();
  late TabController tabController;
  Rx<DateTime> startDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
  }

  FutureOr<void> login(LoginType loginType) async {
    switch (loginType) {
      case LoginType.google_login:
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
