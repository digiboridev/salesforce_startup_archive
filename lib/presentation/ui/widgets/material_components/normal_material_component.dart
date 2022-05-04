import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/presentation/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NormalMaterialComponent extends StatelessWidget {
  NormalMaterialComponent({
    Key? key,
    required this.materiale,
  }) : super(key: key);

  final Materiale materiale;
  final CartController cartController = Get.find();

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
                      left: Get.width * 0.02, right: Get.width * 0.02),
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
                          Text(
                              "${materiale.AverageQty} ${materiale.salesUnitType.text.tr}",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text("${'Minimum order'.tr}: ",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12)),
                          Text(
                              "${materiale.MinimumOrderQuantity} ${materiale.salesUnitType.text.tr}",
                              style: TextStyle(
                                  color: MyColors.blue_003E83, fontSize: 12))
                        ],
                      )
                    ],
                  ))
            ],
          ),
          InkWell(
              onTap: () => cartController.setItem(
                  materialNumber: materiale.MaterialNumber,
                  unit: materiale.salesUnitType,
                  quantity: materiale.MinimumOrderQuantity.toInt()),
              child: Container(
                height: 44,
                width: Get.width * 0.17,
                decoration: BoxDecoration(
                    color: MyColors.blue_003E7E,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
