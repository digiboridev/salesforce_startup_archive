import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductOptions extends StatefulWidget {
  final bool isNew;
  final bool isHotSale;
  final bool isFrozen;
  ProductOptions(
      {required this.isNew, required this.isHotSale, required this.isFrozen});
  @override
  State<StatefulWidget> createState() => ProductOptionsState();
}

class ProductOptionsState extends State<ProductOptions> {
  late bool isNew;
  late bool isHotSale;
  late bool isFrozen;

  @override
  void initState() {
    isNew = widget.isNew;
    isHotSale = widget.isHotSale;
    isFrozen = widget.isFrozen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: Get.width * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: isHotSale,
              child: Container(
                alignment: Alignment.center,
                height: 15,
                width: Get.width * 0.1,
                decoration: BoxDecoration(
                    color: MyColors.orange_FF8800,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                  "Hot sale",
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              )),
          Visibility(
              visible: isNew,
              child: Container(
                alignment: Alignment.center,
                height: 15,
                width: Get.width * 0.1,
                margin: EdgeInsets.only(top: Get.width * 0.01),
                decoration: BoxDecoration(
                    color: MyColors.blue_00458C,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                  "New",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )),
          Visibility(
              visible: isFrozen,
              child: Container(
                height: 20,
                width: Get.width * 0.05,
                margin: EdgeInsets.only(
                  top: Get.width * 0.01,
                ),
                decoration: BoxDecoration(
                    color: MyColors.blue_6DA5EC, shape: BoxShape.circle),
                child: Icon(
                  Icons.ac_unit_outlined,
                  color: MyColors.blue_003E83,
                  size: 16,
                ),
              ))
        ],
      ),
    );
  }
}
