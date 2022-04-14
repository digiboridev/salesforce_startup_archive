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
                        left: Get.width * 0.05, right: Get.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "We'll update as soon as it's back in stock",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ],
                    ))
                : Text(
                    "Not in stock, update when he gets back?",
                    style: TextStyle(color: Colors.white),
                  ),
          )
        ],
      ),
    );
  }
}
