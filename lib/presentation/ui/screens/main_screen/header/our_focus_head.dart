import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/domain/entities/contact_us_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurFocusHead extends StatelessWidget {
  const OurFocusHead({
    Key? key,
    required this.contactUsData,
  }) : super(key: key);
  final ContactUsData contactUsData;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyColors.blue_0250A0, borderRadius: BorderRadius.circular(Get.width * 0.02)),
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      padding: EdgeInsets.symmetric(vertical: Get.width * 0.025, horizontal: Get.width * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Our focus is open'.tr,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              contactUsData.openingHoursString,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
