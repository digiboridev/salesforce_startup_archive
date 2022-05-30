import 'dart:ui';

import 'package:***REMOVED***/core/mycolors.dart';
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
    content: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: MyColors.blue_00458C,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(child: PointsLoader(points_color: Colors.white))),
    ));
