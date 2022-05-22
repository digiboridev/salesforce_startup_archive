import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessMaterialComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SuccessMaterialComponentState();
}

class SuccessMaterialComponentState extends State<SuccessMaterialComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          height: 43,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              gradient: LinearGradient(
                  colors: [MyColors.green_49D84C, MyColors.green_37C33A],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                bottom: 5,
                top: 5),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AssetImages.success_back,
                  height: 32,
                ),
                Text(
                  "Two ${'free pallets added!'.tr}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
