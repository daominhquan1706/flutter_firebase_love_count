import 'package:flutter/material.dart';
import 'package:flutter_lovecount/pages/home/home_view.dart';
import 'package:flutter_lovecount/pages/login/controller.dart';
import 'package:flutter_lovecount/pages/login/page.dart';
import 'package:flutter_lovecount/pages/splash/controller.dart';
import 'package:flutter_lovecount/pages/splash/page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

// IMPORTANT: Ask yourself about authentication & showAppbar to integrate correctly Middleware
abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      transition: Transition.noTransition,
      page: () => SplashPage(),
      bindings: [
        BindingsBuilder(() => Get.put(SplashController())),
      ],
    ),
    GetPage(
      name: Routes.HOME,
      transition: Transition.fadeIn,
      page: () => HomePage(),
      bindings: [],
    ),
    GetPage(
      name: Routes.LOGIN,
      transition: Transition.fadeIn,
      page: () => LoginPage(),
      bindings: [
        BindingsBuilder(() => Get.lazyPut(() => LoginController())),
      ],
    ),
  ];
}
