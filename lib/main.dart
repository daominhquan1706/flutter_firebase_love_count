import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/services/authentication_service.dart';
import 'package:flutter_app/view/home_view.dart';
import 'package:flutter_app/view/login_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  print("Firebase.initializeApp");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthenticationService.instance.setFirebaseAuth(FirebaseAuth.instance);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService.instance,
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: Colors.pink[300],
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
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserApp>();

    if (firebaseUser != null) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
