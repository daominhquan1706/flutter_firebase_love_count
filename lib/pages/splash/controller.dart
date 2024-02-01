import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lovecount/routes/app_pages.dart';
import 'package:flutter_lovecount/services/authentication_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  AuthenticationService get _authenticationService => Get.find<AuthenticationService>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    final currentUser = Get.find<AuthenticationService>().currentUser.value;
    if (currentUser != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
