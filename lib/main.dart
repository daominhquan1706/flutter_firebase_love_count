import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovecount/firebase_options.dart';
import 'package:flutter_lovecount/model/user_model.dart';
import 'package:flutter_lovecount/services/authentication_service.dart';
import 'package:flutter_lovecount/view/home_view.dart';
import 'package:flutter_lovecount/view/login_view.dart';
import 'package:flutter_lovecount/services/authentication_service.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  print("Firebase.initializeApp");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        hintColor: Colors.pink[300],
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: AuthenticationWrapper(),
      locale: Locale('en', 'US'), // Việt Nam
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('vi', 'VN'), // Việt Nam
      ],
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class AppBindings extends Bindings {
  AppBindings();
  @override
  void dependencies() {
    // Get.lazyPut<IAddressRepository>(() => AddressRepository(Get.find()), fenix: true);
    Get.put(AuthenticationService());
  }
}
