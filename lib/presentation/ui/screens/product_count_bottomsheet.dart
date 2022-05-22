import 'package:***REMOVED***/core/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/unit_types.dart';

class ProductCountBottomSheet extends StatefulWidget {
  final Materiale material;
  final int initialCount;
  final UnitType initialUnitType;
  ProductCountBottomSheet({
    Key? key,
    required this.material,
    required this.initialCount,
    required this.initialUnitType,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => ProductCountBottomSheetState();
}

class ProductCountBottomSheetState extends State<ProductCountBottomSheet> {
  late TextEditingController textEditingController;
  late UnitType unitType;

  @override
  void initState() {
    textEditingController =
        TextEditingController(text: widget.initialCount.toString());

    unitType = widget.initialUnitType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white_F4F4F6,
      child: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: Get.width * 0.1,
              width: Get.width * 0.1,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.clear,
                color: MyColors.gray_979797,
              ),
            )),
        Expanded(
          child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Get.width * 0.05),
                      topLeft: Radius.circular(Get.width * 0.05))),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.1,
                            right: Get.width * 0.1,
                            top: Get.width * 0.05),
                        child: Text(
                          "${widget.material.Name}",
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
                        child: Row(
                          children:
                              widget.material.avaliableUnitTtypes.map((e) {
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    unitType = UnitType.fromSalesUnit(
                                        e.salesUnitString);
                                  });
                                },
                                child: boxTypes(
                                    text: "${e.text.tr}",
                                    isSelect:
                                        e.runtimeType == unitType.runtimeType));
                          }).toList(),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              int currentCount =
                                  int.tryParse(textEditingController.text) ?? 0;
                              ++currentCount;

                              textEditingController.text =
                                  currentCount.toString();
                            },
                            child: Container(
                              child: Image.asset(
                                AssetImages.plus,
                                width: Get.width * 0.06,
                                height: Get.width * 0.06,
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
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
                              int currentCount =
                                  int.tryParse(textEditingController.text) ?? 0;

                              if (currentCount > 0) {
                                --currentCount;
                              }

                              textEditingController.text =
                                  currentCount.toString();
                            },
                            child: Container(
                              child: Image.asset(
                                AssetImages.minus,
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
                                  "${'Quantity'.tr} ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: MyColors.blue_0050A2),
                                ),
                                Text(
                                    "${widget.material.countByUnitType(unitType).toString().tr} ${'units in'.tr} ${unitType.text.tr}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: MyColors.blue_0571E0)),
                              ]),
                              InkWell(
                                  onTap: () {
                                    textEditingController.text = 0.toString();
                                  },
                                  child: Text(
                                    "Zero".tr,
                                    style: TextStyle(
                                        color: MyColors.gray_707070,
                                        decoration: TextDecoration.underline,
                                        fontSize: 20),
                                  ))
                            ],
                          )),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back(result: {
                        unitType: int.tryParse(textEditingController.text) ?? 0
                      });
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
                ],
              )),
        ),
      ],
    );
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
            alignment: Alignment.center,
            height: 52,
            child: Text(text));
  }
}
