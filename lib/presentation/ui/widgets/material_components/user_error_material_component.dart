import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserErrorMaterialComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserErrorMaterialComponentState();
}

class UserErrorMaterialComponentState
    extends State<UserErrorMaterialComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: Get.width,
        height: 43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            gradient: LinearGradient(
                colors: [MyColors.red_EF6262, MyColors.red_C82B2B],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                bottom: 5,
                top: 5),
            child: Text(
              "Here will come an error message".tr,
              maxLines: 2,
              style: TextStyle(color: Colors.white, fontSize: 16),
            )));
  }
}
