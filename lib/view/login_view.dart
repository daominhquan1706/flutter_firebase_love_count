import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/utils.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:jiffy/jiffy.dart';
import '../ui/dialog/login_dialog.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    Jiffy.locale("vi").then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: _buildTabPage(),
                ),
                _buildActionButton(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabPage() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildLoginPage(),
        Container(),
      ],
    );
  }

  Widget _buildLoginPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Spacer(),
            _buildDatePickerUI(),
            Spacer(),
            _buildCountDateText(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget myButton({
    VoidCallback onPressed,
    IconData icon,
    String title,
    Color color = Colors.blue,
  }) {
    return Container(
      width: double.infinity,
      height: 65,
      child: Card(
        child: RaisedButton(
          child: Expanded(
            child: Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          color: color,
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: Colors.black87,
      child: Stack(
        children: [
          FlareActor(
            "assets/background_wave_teal.flr",
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            animation: "slow",
          ),
          // FlareActor(
          //   "assets/coupleHug.flr",
          //   alignment: Alignment.bottomCenter,
          //   fit: BoxFit.fitWidth,
          //   animation: "heart",
          // ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The Couple",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Chọn ngày mà tình yêu bắt đầu!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    const padding2 = const EdgeInsets.symmetric(vertical: 16.0);

    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            minWidth: 100,
            maxWidth: 250,
          ),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: padding2,
                child: Text(
                  "Tiếp tục",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                _tabController.animateTo(1);
              },
            ),
          ),
        ),
        FlatButton(
          child: Padding(
            padding: padding2,
            child: Text(
              "Đăng nhập",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => LoginDialog(),
            );
          },
        )
      ],
    );
  }

  Widget _buildCountDateText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: [
          AutoSizeText(
            DateHelper.countDate(_startDate),
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
            maxLines: 1,
          ),
          Text(
            "(${Jiffy(_startDate).fromNow()})",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  _buildDatePickerUI() {
    return GestureDetector(
      onTap: () async {
        CupertinoRoundedDatePicker.show(
          context,
          textColor: Colors.white,
          background: Colors.pink[300],
          borderRadius: 16,
          initialDatePickerMode: CupertinoDatePickerMode.date,
          locale: Locale('vi', 'VN'),
          initialDate: _startDate,
          minimumDate: DateTime(0),
          maximumDate: DateTime.now(),
          minimumYear: 1,
          maximumYear: DateTime.now().year,
          onDateTimeChanged: (newDateTime) {
            setState(() {
              if (newDateTime != null && newDateTime.isBefore(DateTime.now())) {
                _startDate = newDateTime;
              }
            });
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Row(
            children: [
              Text(
                Jiffy(_startDate).yMMMMEEEEd,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
