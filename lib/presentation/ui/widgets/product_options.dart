import 'package:***REMOVED***/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductOptions extends StatefulWidget {
  final bool isNew;
  final bool isHotSale;
  final bool isFrozen;
  final String optionType;
  static const CARD_TYPE = "OPTION_CARD_TYPE";
  static const MATERIAL_SCREEN_TYPE = "OPTION_MATERIAL_SCREEN_TYPE";

  ProductOptions(
      {required this.isNew, required this.isHotSale,
        required this.optionType,
        required this.isFrozen});
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
    return widget.optionType == ProductOptions.CARD_TYPE? Container(
      height: 15,
      width: Get.width * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        buildSale(),
         buildNew(),
         buildFrozen()
        ],
      ),
    ):Container(
      height: 30,
      alignment: Alignment.center,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      buildNew(),
      SizedBox(width: Get.width*0.01,),
      buildSale(),
      SizedBox(width: Get.width*0.01,),
      buildFrozen()
    ],),);
  }
  Widget buildSale(){
    return   Visibility(
        visible: isHotSale,
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: Get.width * 0.1,
          decoration: BoxDecoration(
              color: MyColors.orange_FF8800,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Text(
           "Hot sale".tr,
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ));
  }
  Widget buildNew(){
    return  Visibility(
        visible: isNew,
        child: Container(
          alignment: Alignment.center,
          height: 15,
          width: Get.width * 0.1,
          decoration: BoxDecoration(
              color: MyColors.blue_00458C,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Text(
            "New".tr,
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
    ));
  }
  Widget buildFrozen(){
    return  Visibility(
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
        ));
  }
}
