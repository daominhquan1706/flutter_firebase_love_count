import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication_service.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: new OutlineInputBorder(),
                prefixIcon: Icon(FontAwesome.mail),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: _hidePassword,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: new OutlineInputBorder(),
                prefixIcon: Icon(FontAwesome.lock),
                suffixIcon: GestureDetector(
                  child: Icon(
                    _hidePassword ? FontAwesome.eye : FontAwesome.eye_off,
                  ),
                  onTap: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 55,
              child: RaisedButton.icon(
                icon: Icon(
                  FontAwesome.adn,
                  color: Colors.white,
                ),
                label: Expanded(
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Colors.blueAccent,
                onPressed: () async {
                  String result =
                      await context.read<AuthenticationService>().signIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                  showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                      title: Text("Warning message !"),
                      content: Text(result),
                      actions: [
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
