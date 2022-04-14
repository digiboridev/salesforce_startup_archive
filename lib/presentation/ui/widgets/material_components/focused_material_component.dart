import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/unit_types.dart';
import 'package:***REMOVED***/presentation/controllers/material_count_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/product_count_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FocusedMaterialComponent extends StatelessWidget {
  const FocusedMaterialComponent({
    Key? key,
    required this.materialCountController,
    required this.materiale,
  }) : super(key: key);

  final MaterialCountController materialCountController;
  final Materiale materiale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Get.width * 0.03, right: Get.width * 0.03, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () async {
                Map<UnitType, int>? d = await Get.to<Map<UnitType, int>>(
                    () => ProductCountScreen(
                          initialCount: materialCountController.unit_count,
                          material: materiale,
                          initialUnitType: materialCountController.unitType,
                        ),
                    transition: Transition.circularReveal);

                if (d != null) {
                  materialCountController.setCountManual(count: d.values.first);
                  materialCountController.setUnitType(unitType: d.keys.first);
                }
              },
              child: Container(
                  height: 44,
                  width: Get.width * 0.45,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: MyColors.blue_00458C,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.04, right: Get.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Text(
                                    "${materialCountController.unit_count} ${materialCountController.unitType.text} ₪${materiale.UnitNetPrice.toInt() * materialCountController.unit_count * materiale.countByUnitType(materialCountController.unitType)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: MyColors.blue_00458C,
                                    ),
                                  )),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                color: MyColors.blue_00458C,
                              )
                            ],
                          ))))),
          InkWell(
            onTap: () {
              materialCountController.increaseCount();
            },
            child: Container(
              height: 44,
              width: Get.width * 0.17,
              decoration: BoxDecoration(
                  color: MyColors.blue_007AFE,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Icon(
                Icons.add_outlined,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
              onTap: () {
                materialCountController.decreaseCount();
              },
              child: Container(
                height: 44,
                width: Get.width * 0.17,
                decoration: BoxDecoration(
                    color: MyColors.blue_E8EEF6,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Icon(
                  Icons.remove,
                  color: MyColors.blue_00458C,
                ),
              ))
        ],
      ),
    );
  }
}
