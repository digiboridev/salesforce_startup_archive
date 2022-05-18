import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutStockMaterialComponent extends StatefulWidget {
  OutStockMaterialComponent({
    Key? key,
    required this.isUpdate,
    required this.materiale,
  }) : super(key: key);

  final bool isUpdate;
  final Materiale materiale;

  @override
  State<OutStockMaterialComponent> createState() =>
      _OutStockMaterialComponentState();
}

class _OutStockMaterialComponentState extends State<OutStockMaterialComponent> {
  bool loading = false;

  final MaterialsCatalogController materialsCatalogController = Get.find();

  onSubscribe() async {
    setState(() => loading = true);

    await materialsCatalogController.subscribeToMaterial(
        materialNumber: widget.materiale.MaterialNumber);

    setState(() => loading = false);
  }

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
                color: widget.isUpdate
                    ? MyColors.blue_007AFE
                    : MyColors.blue_003E83,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: content,
          )
        ],
      ),
    );
  }

  Widget get content {
    if (loading) {
      return CircularProgressIndicator();
    } else {
      return widget.isUpdate
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
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ))
          : GestureDetector(
              onTap: () => onSubscribe(),
              child: Text(
                "Not in stock, update when he gets back?".tr,
                style: TextStyle(color: Colors.white),
              ),
            );
    }
  }
}
