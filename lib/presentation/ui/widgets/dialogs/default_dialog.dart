import 'package:flutter/material.dart';
import 'package:get/get.dart';

defaultDialog() => Get.defaultDialog(
      onWillPop: () async => false,
      title: '',
      barrierDismissible: false,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      content: Image.asset(
        'assets/images/dialog.png',
        width: Get.width * 1,
      ),
    );
