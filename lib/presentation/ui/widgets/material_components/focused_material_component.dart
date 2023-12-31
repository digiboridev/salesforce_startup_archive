import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/domain/entities/cart_item.dart';
import 'package:salesforce.startup/domain/entities/materials/material.dart';
import 'package:salesforce.startup/domain/entities/materials/unit_types.dart';
import 'package:salesforce.startup/presentation/controllers/cart_controller.dart';
import 'package:salesforce.startup/presentation/ui/screens/product_count_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FocusedMaterialComponent extends StatelessWidget {
  FocusedMaterialComponent({
    Key? key,
    required this.materiale,
    required this.cartItem,
  }) : super(key: key);

  final CartController cartController = Get.find();
  final CartItem cartItem;
  final Materiale materiale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () async {
                Map<UnitType, int>? d = await Get.dialog<Map<UnitType, int>>(
                  ProductCountPopup(initialCount: cartItem.quantity.toInt(), material: materiale, initialUnitType: cartItem.salesUnitType),
                  transitionDuration: Duration(milliseconds: 100),
                );

                if (d != null) {
                  if (d.values.first < 1) {
                    cartController.removeItem(materialNumber: materiale.MaterialNumber);
                  } else {
                    cartController.setItem(materialNumber: materiale.MaterialNumber, unit: d.keys.first, quantity: d.values.first);
                  }
                }
              },
              child: Container(
                  height: 44,
                  width: Get.width * 0.45,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: MyColors.blue_00458C, style: BorderStyle.solid, width: 0.80),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${cartItem.quantity} ${cartItem.salesUnitType.text.tr}",
                                style: TextStyle(
                                  fontSize: Get.width * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.blue_00458C,
                                ),
                              ),
                              Text(
                                "₪${materiale.UnitNetPrice.toInt() * cartItem.quantity * materiale.countByUnitType(cartItem.salesUnitType)}",
                                style: TextStyle(
                                  fontSize: Get.width * 0.035,
                                  color: MyColors.blue_00458C,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: MyColors.blue_00458C,
                              )
                            ],
                          ))))),
          InkWell(
            onTap: () {
              int count = (cartItem.quantity + 1).toInt();
              cartController.setItem(materialNumber: materiale.MaterialNumber, unit: cartItem.salesUnitType, quantity: count);
            },
            child: Container(
              height: 44,
              width: Get.width * 0.17,
              decoration: BoxDecoration(color: MyColors.blue_007AFE, borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Icon(
                Icons.add_outlined,
                color: Colors.white,
              ),
            ),
          ),
          InkWell(
              onTap: () {
                int count = (cartItem.quantity - 1).toInt();

                if (count < 1) {
                  cartController.removeItem(materialNumber: materiale.MaterialNumber);
                } else {
                  cartController.setItem(materialNumber: materiale.MaterialNumber, unit: cartItem.salesUnitType, quantity: count);
                }
              },
              child: Container(
                height: 44,
                width: Get.width * 0.17,
                decoration: BoxDecoration(color: MyColors.blue_E8EEF6, borderRadius: BorderRadius.all(Radius.circular(25))),
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
