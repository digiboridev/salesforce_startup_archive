import 'package:***REMOVED***/core/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsightMaterialComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InsightMaterialComponentState();
}

class InsightMaterialComponentState extends State<InsightMaterialComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Get.width * 0.04, right: Get.width * 0.04, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: Get.width * 0.005,
                color: MyColors.blue_003E7E,
              ),
              Padding(
                  padding: EdgeInsets.only(
                    left: Get.width * 0.01,
                    right: Get.width * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${'Recommended quantity'.tr}: ",
                            style: TextStyle(
                                color: MyColors.blue_003E83, fontSize: 12),
                          ),
                          Text("value",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text("${'Minimum order'.tr}: ",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12)),
                          Text("value",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12))
                        ],
                      )
                    ],
                  ))
            ],
          ),
          Container(
            height: Get.width * 0.09,
            decoration: BoxDecoration(
                color: MyColors.pink_FF268E,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                child: Text(
                  "You may be\nmissing!".tr,
                  style: TextStyle(color: Colors.white, fontSize: 10),
                )),
          ),
          Container(
            height: 44,
            width: Get.width * 0.17,
            decoration: BoxDecoration(
                color: MyColors.blue_003E7E,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
