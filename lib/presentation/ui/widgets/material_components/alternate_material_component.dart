import 'package:***REMOVED***/core/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlternateMaterialComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlternateMaterialComponentState();
}

class AlternateMaterialComponentState
    extends State<AlternateMaterialComponent> {
  bool isOriginal = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            width: Get.width,
            height: 43,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                color: MyColors.blue_E8EEF6),
            child: isOriginal
                ? Text(
                    "Alternative product".tr,
                    style: TextStyle(color: MyColors.blue_37C33A, fontSize: 18),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.05, right: Get.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Back to original product".tr,
                          style: TextStyle(
                              color: MyColors.blue_37C33A, fontSize: 18),
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: MyColors.blue_37C33A,
                        )
                      ],
                    )))
      ],
    );
  }
}
