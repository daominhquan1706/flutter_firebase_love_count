import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication_service.dart';
import 'package:flutter_app/helper/utils.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl = "https://api.adorable.io/avatars/M3UImkAZc8x@adorable.png";
  String imageUrl2 = "https://api.adorable.io/avatars/asdfadsfafd@adorable.png";
  DateTime loveDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Love"),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: _buildAppDrawer(),
          body: Stack(
            children: [
              //_buildBackground(),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _topSection(),
                  _bottomSection(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _topSection() {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 100,
            child: Icon(
              FontAwesome5.heart,
              color: Colors.white,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            user(imageUrl: imageUrl, userName: "Người dùng 1"),
            user(imageUrl: imageUrl2, userName: "Người dùng 2"),
          ],
        ),
      ],
    );
  }

  Widget user({@required String imageUrl, @required String userName}) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(imageUrl),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 5,
                    blurRadius: 12,
                    offset: Offset(0, 5),
                  )
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: ScreenInfo(context).width / 2.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 5,
                      blurRadius: 12,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  userName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSection() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Container(),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          FlareActor(
            "assets/background_wave_teal.flr",
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            animation: "slow",
          ),
          FlareActor(
            "assets/coupleHug.flr",
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fitWidth,
            animation: "heart",
          ),
        ],
      ),
    );
  }

  Drawer _buildAppDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Love Quote'),
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
          ),
          ListTile(
            leading: Icon(FontAwesome5.calendar_alt),
            title: Text('Thay đổi ngày'),
            onTap: () async {
              loveDate = await showDatePicker(
                context: context,
                initialDate: loveDate,
                firstDate: DateTime(0),
                lastDate: DateTime(9999),
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesome5.user),
            title: Text('Thay đổi tên bạn'),
            onTap: () {},
          ),
          Spacer(),
          ListTile(
            leading: Icon(FontAwesome5.power_off),
            title: Text('Đăng xuất'),
            onTap: () {
              context.read<AuthenticationService>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
