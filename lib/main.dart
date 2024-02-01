import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovecount/biz/app_controller.dart';
import 'package:flutter_lovecount/firebase_options.dart';
import 'package:flutter_lovecount/routes/app_pages.dart';
import 'package:flutter_lovecount/services/authentication_service.dart';
import 'package:flutter_lovecount/pages/home/home_view.dart';
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
      locale: Locale('en', 'US'), // Việt Nam
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('vi', 'VN'), // Việt Nam
      ],
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
      initialBinding: AppBindings(),
    );
  }
}

class AppBindings extends Bindings {
  AppBindings();
  @override
  void dependencies() {
    // Get.lazyPut<IAddressRepository>(() => AddressRepository(Get.find()), fenix: true);
    Get.put(AuthenticationService());
    Get.put(AppController());
  }
}
