import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/domain/services/image_caching_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialScreenDialog extends StatelessWidget {
  final String image_uri;
  MaterialScreenDialog({required this.image_uri});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.all(Get.width * 0.03),
        backgroundColor: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          height: Get.width * 1.2,
          width: Get.width,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.only(top: Get.width * 0.03, left: Get.width * 0.025, right: Get.width * 0.025),
                  child: CachedImage(
                    Url: image_uri,
                    width: Get.width,
                    height: Get.width * 1.1,
                  )),
              Positioned.directional(
                  textDirection: Directionality.of(context),
                  end: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: Get.width * 0.07,
                      width: Get.width * 0.07,
                      decoration: BoxDecoration(color: MyColors.blue_00458C, shape: BoxShape.circle),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
