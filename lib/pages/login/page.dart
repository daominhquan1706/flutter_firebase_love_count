import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovecount/helper/utils.dart';
import 'package:flutter_lovecount/pages/login/controller.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import '../../ui/dialog/login_dialog.dart';

class LoginPage extends GetView<LoginController> {
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
      controller: controller.tabController,
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
        width: Get.width,
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
    required VoidCallback onPressed,
    required IconData icon,
    String? title,
    Color color = Colors.blue,
  }) {
    return Container(
      width: double.infinity,
      height: 65,
      child: Card(
        child: ElevatedButton(
          child: Expanded(
            child: Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
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
      width: Get.width,
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
            child: ElevatedButton(
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
                controller.tabController.animateTo(1);
              },
            ),
          ),
        ),
        TextButton(
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
            Get.dialog(LoginDialog());
          },
        )
      ],
    );
  }

  Widget _buildCountDateText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Obx(
        () => Column(
          children: [
            AutoSizeText(
              DateHelper.countDate(controller.startDate.value),
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
              maxLines: 1,
            ),
            Text(
              "(${Jiffy.parseFromDateTime(controller.startDate.value).fromNow()})",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildDatePickerUI() {
    return GestureDetector(
      onTap: () async {
        CupertinoRoundedDatePicker.show(
          Get.context!,
          textColor: Colors.white,
          background: Colors.pink[300] ?? Colors.white,
          borderRadius: 16,
          initialDatePickerMode: CupertinoDatePickerMode.date,
          locale: Locale('vi', 'VN'),
          initialDate: controller.startDate.value,
          minimumDate: DateTime(0),
          maximumDate: DateTime.now(),
          minimumYear: 1,
          maximumYear: DateTime.now().year,
          onDateTimeChanged: (newDateTime) {
            if (newDateTime.isBefore(DateTime.now())) {
              controller.startDate.value = newDateTime;
            }
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
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Row(
            children: [
              Obx(
                () => Text(
                  Jiffy.parseFromDateTime(controller.startDate.value).yMMMMEEEEd,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
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
