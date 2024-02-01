import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovecount/viewController/login_controller.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginDialog extends StatefulWidget {
  LoginDialog({Key? key}) : super(key: key);

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final viewModel = LoginViewController();
  var width;
  var height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              constraints: BoxConstraints(
                minHeight: 200,
                minWidth: 300,
                maxHeight: 400,
                maxWidth: 300,
              ),
              padding: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: 260,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.black, Colors.transparent],
                        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: FlareActor(
                        "assets/coupleHug.flr",
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        animation: "heart",
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildHeaderView(),
                      Spacer(),
                      _buildBottomAction(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderView() {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Đăng nhập",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "khi đăng nhập, tài khoản của bạn sẽ được sao lưu trên đám mây của ứng dụng.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Center(
                child: SignInButton(
                  Buttons.Google,
                  padding: EdgeInsets.only(left: 10),
                  onPressed: () {
                    viewModel.login(LoginType.google_login);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  text: "Google",
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Center(
                child: SignInButton(
                  Buttons.Facebook,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  text: "Facebook",
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Container(
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SignInButton(
                Buttons.AppleDark,
                mini: true,
                elevation: 10,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Expanded(
                child: Text(
                  "Sign in with Apple",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
