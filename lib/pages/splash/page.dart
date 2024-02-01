import 'package:flutter/material.dart';
import 'package:flutter_lovecount/pages/splash/controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Love Count"),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
