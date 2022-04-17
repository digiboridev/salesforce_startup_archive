import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutStockMaterialComponent extends StatelessWidget {
  OutStockMaterialComponent({
    Key? key,
    required this.isUpdate,
  }) : super(key: key);

  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: Get.width * 0.05, right: Get.width * 0.05, bottom: 15),
            alignment: Alignment.center,
            height: 44,
            decoration: BoxDecoration(
                color: isUpdate ? MyColors.blue_007AFE : MyColors.blue_003E83,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: isUpdate
                ? Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.03, right: Get.width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "We will update as soon as it returns to stock".tr,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        SizedBox(width: Get.width*0.01,),
                        Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ))
                : Text(
                    "Not in stock, update when he gets back?".tr,
                    style: TextStyle(color: Colors.white),
                  ),
          )
        ],
      ),
    );
  }
}
