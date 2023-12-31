import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SystemErrorMaterialComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SystemErrorMaterialComponentState();
}

class SystemErrorMaterialComponentState extends State<SystemErrorMaterialComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
            gradient: LinearGradient(colors: [MyColors.blue_3B99FF, MyColors.blue_027BFE], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, bottom: 5, top: 5),
            child: Row(
              children: [
                Image.asset(
                  AssetImages.error,
                  height: 24,
                ),
                SizedBox(
                  width: Get.width * 0.04,
                ),
                Text(
                  "${'This product was partially supplied, supplied'.tr}:\n300 out of 600 units",
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            )));
  }
}
