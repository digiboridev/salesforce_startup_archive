import 'dart:ui';

import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewFavoritesListBottomheet extends StatelessWidget {
  NewFavoritesListBottomheet({
    Key? key,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        height: Get.width / 1.5,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.width * 0.05),
        width: Get.width,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 10)],
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width * 0.06), topRight: Radius.circular(Get.width * 0.06))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New shopping list".tr,
                  style: TextStyle(color: MyColors.blue_003E7E, fontSize: 26),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(
                    AssetImages.close,
                    width: Get.width * 0.05,
                    height: Get.width * 0.05,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Get.width * 0.02,
            ),
            Container(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: "List Name".tr,
                    labelStyle: TextStyle(color: MyColors.blue_003E7E, fontSize: 17),
                    hintStyle: TextStyle(color: MyColors.blue_003E7E, fontSize: 20),
                    hintText: "Sample: Breakfast products".tr,
                    border: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.blue_003E7E)),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.blue_003E7E)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.blue_003E7E))),
              ),
            ),
            SizedBox(
              height: Get.width * 0.1,
            ),
            GestureDetector(
              onTap: () {
                Get.back(result: controller.text);
              },
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: Get.width * 0.03),
                decoration: BoxDecoration(color: MyColors.blue_00458C, borderRadius: BorderRadius.all(Radius.circular(27))),
                child: Text(
                  "Save".tr,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
