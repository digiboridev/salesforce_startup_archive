import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JustLoadingScreen extends StatelessWidget {
  const JustLoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(Get.width * 0.06),
                alignment: Alignment.center,
                color: MyColors.white_F4F4F6,
                child: Image.asset(AssetImages.loading_circle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildHeader() {
    return Container(
      height: Get.width * 0.25,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [MyColors.blue_0D63BB, MyColors.blue_00458C])),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Align(
        alignment: Alignment.center,
        child: Hero(
          tag: 'logo',
          child: Image.asset(
            AssetImages.***REMOVED***Logo,
            width: Get.width * 0.25,
          ),
        ),
      ),
    );
  }
}
