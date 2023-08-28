import 'package:salesforce.startup/core/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackingMaterialComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TrackingMaterialComponentState();
}

class TrackingMaterialComponentState extends State<TrackingMaterialComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
          gradient: LinearGradient(colors: [MyColors.green_49D84C, MyColors.green_37C33A], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Padding(
        padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, bottom: 5, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Text(
                  "Supplied!".tr,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "price",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Text(
                  "count",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
