import 'dart:async';
import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/unit_types.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_page_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/material_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCount extends StatefulWidget {
  final MaterialCardController cardController;
  ProductCount({required this.cardController});
  @override
  State<StatefulWidget> createState() => ProductCountState();
}

class ProductCountState extends State<ProductCount> {
  late CatalogPageController controller = Get.find();
  late TextEditingController textEditingController;
  // List<String> box_list = ['Pallet', 'Carton', 'Inner', 'Unit'];
  // List<Widget> box_widget_list = [];
  // bool palletSelect = true;
  // bool cartonSelect = false;
  // bool innerSelect = false;
  // bool unitSelect = false;
  // String boxType = '';
  // String new_type = '';
  // int unit_count = 0;

  StreamSubscription? _countSub;
  @override
  void initState() {
    // material = widget.cardController.material;
    // unit_count = widget.cardController.unit_count.value;
    // controller = widget.controller;
    // boxType = widget.cardController.box_type.value;
    // new_type = boxType;

    textEditingController = TextEditingController(
        text: widget.cardController.unit_count.toString());

    _countSub = widget.cardController.unit_countStream.listen((p0) {
      textEditingController.text = p0.toString();
    });
    // textEditingController.text =
    //     widget.cardController.product_count.value.toString();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_countSub is StreamSubscription) _countSub!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // box_widget_list = <Widget>[
    // InkWell(
    //     onTap: () {
    //       setState(() {
    //         setAllFalse();
    //         palletSelect = true;
    //         new_type = 'Pallet';
    //         unit_count = material.PalletCount.toInt();
    //       });
    //     },
    //     child: boxTypes(text: 'Pallet', isSelect: palletSelect)),
    //   InkWell(
    //       onTap: () {
    //         setState(() {
    //           setAllFalse();
    //           cartonSelect = true;
    //           new_type = 'Carton';
    //           unit_count = material.CartonCount.toInt();
    //         });
    //       },
    //       child: boxTypes(text: 'Carton', isSelect: cartonSelect)),
    //   InkWell(
    //       onTap: () {
    //         setState(() {
    //           setAllFalse();
    //           innerSelect = true;
    //           new_type = 'Inner';
    //           unit_count = material.InnerCount.toInt();
    //         });
    //       },
    //       child: boxTypes(text: 'Inner', isSelect: innerSelect)),
    //   InkWell(
    //       onTap: () {
    //         setState(() {
    //           setAllFalse();
    //           unitSelect = true;
    //           new_type = 'Unit';
    //           unit_count = 1;
    //         });
    //       },
    //       child: boxTypes(text: 'Unit', isSelect: unitSelect))
    // ];

    // if (boxType == 'Pallet') {
    //   box_list = ['Pallet'];
    //   box_widget_list.removeLast();
    //   box_widget_list.removeLast();
    //   box_widget_list.removeLast();
    // }
    // if (boxType == 'Carton') {
    //   box_list = ['Pallet', 'Carton'];
    //   box_widget_list.removeLast();
    //   box_widget_list.removeLast();
    // }
    // if (boxType == 'Inner') {
    //   box_list = ['Pallet', 'Carton', 'Inner'];
    //   box_widget_list.removeLast();
    // }
    // if (boxType == 'Unit') {
    //   box_list = ['Pallet', 'Carton', 'Inner', 'Unit'];
    // }

    return WillPopScope(
        onWillPop: () async {
          controller.closeOverlay();
          return false;
        },
        child: Container(
            // height: Get.height - 200,a
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Get.width * 0.05),
                    topLeft: Radius.circular(Get.width * 0.05))),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.1,
                              right: Get.width * 0.1,
                              top: Get.width * 0.05),
                          child: Text(
                            "${widget.cardController.material.Name}",
                            style: TextStyle(
                                fontSize: 20, color: MyColors.blue_00458C),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: MyColors.blue_E8EEF6,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Get.width * 0.06))),
                            height: 52,
                            margin: EdgeInsets.only(
                                left: Get.width * 0.05,
                                right: Get.width * 0.05,
                                top: Get.width * 0.05,
                                bottom: Get.width * 0.05),
                            child: Obx(() => Row(
                                  children: widget.cardController.material
                                      .avaliableUnitTtypes
                                      .map((e) {
                                    return InkWell(
                                        onTap: () {
                                          // setState(() {
                                          //   setAllFalse();
                                          //   palletSelect = true;
                                          //   new_type = 'Pallet';
                                          //   unit_count =
                                          //       material.PalletCount.toInt();
                                          // });
                                          widget.cardController.setUnitType(
                                              unitType: UnitType.fromSalesUnit(
                                                  e.salesUnitString));
                                        },
                                        child: boxTypes(
                                            text: e.text,
                                            isSelect: e.runtimeType ==
                                                widget.cardController.unitType
                                                    .runtimeType));
                                  }).toList(),
                                ))),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.cardController.increaseCount();
                              },
                              child: Container(
                                child: Image.asset(
                                  "assets/icons/plus.png",
                                  width: Get.width * 0.06,
                                  height: Get.width * 0.06,
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                //  margin: EdgeInsets.only(left: Get.width*0.2, right: Get.width*0.2),
                                width: Get.width * 0.65,
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.1,
                                    right: Get.width * 0.1),
                                height: 76,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  cursorHeight: 0,
                                  cursorWidth: 0,
                                  cursorColor: Colors.white,
                                  cursorRadius: Radius.zero,
                                  maxLength: 3,
                                  textAlign: TextAlign.center,
                                  controller: textEditingController,
                                  style: TextStyle(
                                      fontSize: Get.width * 0.2,
                                      color: MyColors.blue_00458C),
                                  decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      enabledBorder: null,
                                      disabledBorder: null),
                                  // initialValue: ,
                                )),
                            InkWell(
                              onTap: () {
                                widget.cardController.decreaseCount();
                              },
                              child: Container(
                                child: Image.asset(
                                  "assets/icons/minus.png",
                                  width: Get.width * 0.06,
                                  height: Get.width * 0.06,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Get.width * 0.1,
                              right: Get.width * 0.1,
                              top: Get.width * 0.03),
                          color: MyColors.blue_00458C,
                          height: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: Get.width * 0.03,
                                left: Get.width * 0.1,
                                right: Get.width * 0.1),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Text(
                                    "Quantity ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: MyColors.blue_0050A2),
                                  ),
                                  Obx(() => Text(
                                      "${widget.cardController.material.countByUnitType(widget.cardController.unitType).toString()} units in ${widget.cardController.unitType.text}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: MyColors.blue_0571E0))),
                                ]),
                                InkWell(
                                    onTap: () =>
                                        widget.cardController.resetCount(),
                                    child: Text(
                                      "Zero",
                                      style: TextStyle(
                                          color: MyColors.gray_707070,
                                          decoration: TextDecoration.underline,
                                          fontSize: 20),
                                    ))
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                // Spacer(),
                InkWell(
                  onTap: () {
                    controller.closeOverlay();
                    // widget.cardController.select_box_type.value =
                    //     new_type;
                    // if (new_type == "Carton") {
                    //   widget.cardController.unit_count.value =
                    //       material.CartonCount.toInt();
                    // }
                    // if (new_type == "Pallet") {
                    //   widget.cardController.unit_count.value =
                    //       material.PalletCount.toInt();
                    // }
                    // if (new_type == "Inner") {
                    //   widget.cardController.unit_count.value =
                    //       material.InnerCount.toInt();
                    // }
                    // if (new_type == "Unit") {
                    //   widget.cardController.unit_count.value = 1;
                    // }

                    // widget.cardController
                    //     .setUnitCount(boxType: new_type);
                    // controller.closeProductCountScreen();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width,
                    height: Get.width * 0.15,
                    color: MyColors.blue_00458C,
                    child: Text(
                      "אישור",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.2,
                )
              ],
            )));
  }

  Widget boxTypes({required String text, required isSelect}) {
    return isSelect
        ? Container(
            width: Get.width * 0.225,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: MyColors.blue_003E7E,
                borderRadius:
                    BorderRadius.all(Radius.circular(Get.width * 0.06))),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          )
        : Container(
            width: Get.width * 0.225,
            //margin: EdgeInsets.only(left: Get.width*0.06, right:Get.width*0.06),
            alignment: Alignment.center,
            height: 52,
            child: Text(text));
  }

  // void setAllFalse() {
  //   setState(() {
  //     palletSelect = false;
  //     cartonSelect = false;
  //     innerSelect = false;
  //     unitSelect = false;
  //   });
  // }
}
