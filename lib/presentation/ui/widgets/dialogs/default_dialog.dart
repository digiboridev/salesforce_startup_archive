import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/presentation/ui/widgets/loaders/points_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

defaultDialog() => Get.defaultDialog(
    onWillPop: () async => false,
    title: '',
    barrierDismissible: false,
    backgroundColor: Colors.transparent,
    contentPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    content: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: MyColors.blue_00458C,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(child: PointsLoader(points_color: Colors.white))));

appVersionDialog({
  required String current,
  required String desired,
  required String ulr,
}) =>
    Get.defaultDialog(
      onWillPop: () async => false,
      title: '',
      barrierDismissible: false,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      content: Container(
          padding: EdgeInsets.symmetric(vertical: Get.width * 0.06),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              Text('Update app'),
              SizedBox(
                height: Get.width * 0.03,
              ),
              Text('Current version: ' + current),
              SizedBox(
                height: Get.width * 0.03,
              ),
              Text('Actual version: ' + desired),
              SizedBox(
                height: Get.width * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  launch(ulr);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.blue_003E7E,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    padding: EdgeInsets.symmetric(
                        vertical: Get.width * 0.02,
                        horizontal: Get.width * 0.03),
                    child: Text(
                      'Update app'.tr,
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          )),
    );
