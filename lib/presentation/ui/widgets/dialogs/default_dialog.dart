import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/presentation/ui/widgets/loaders/points_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

defaultDialog() => Get.defaultDialog(
      onWillPop: () async => false,
      title: '',
      barrierDismissible: false,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      content: Container(
        alignment: Alignment.center,
      //  margin: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05),
          decoration: BoxDecoration(
            color: MyColors.blue_00458C,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child:Center(child:
PointsLoader(points_color: Colors.white))));
