import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/controllers/material_count_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/cart_top_icon.dart';
import 'package:***REMOVED***/presentation/ui/widgets/product_options.dart';
import 'package:***REMOVED***/presentation/ui/screens/material_screen.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/focused_material_component.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/normal_material_component.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/outstock_material_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialCard extends StatefulWidget {
  final Materiale materiale;
  const MaterialCard({Key? key, required this.materiale}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MaterialCardState();
}

class MaterialCardState extends State<MaterialCard> {
  late MaterialCountController materialCountController;
  UserDataController userDataController = Get.find();

  @override
  void initState() {
    materialCountController = Get.put(
        MaterialCountController(material: widget.materiale),
        tag: widget.materiale.hashCode.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<MaterialCountController>(
        tag: widget.materiale.hashCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            () => MaterialScreen(
                  material: widget.materiale,
                ),
            transition: Transition.cupertino);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.04))),
        margin: EdgeInsets.only(
            bottom: Get.width * 0.025,
            left: Get.width * 0.025,
            top: Get.width * 0.05,
            right: Get.width * 0.025),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                SizedBox(
                  height: Get.width * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(Get.width * 0.01),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 10)
                            ]),
                        child: CachedImage(
                          Url: widget.materiale.ImageUrl,
                          width: Get.width * 0.25,
                          height: Get.width * 0.25,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              widget.materiale.Name,
                              style: TextStyle(color: MyColors.blue_003E7E),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Quantity".tr,
                                      style: TextStyle(
                                          color: MyColors.blue_0050A2,
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: Get.width * 0.02,
                                    ),
                                    Text(
                                      "${widget.materiale.countByUnitType(widget.materiale.avaliableUnitTtypes.first)} ${'units per'.tr} ${widget.materiale.avaliableUnitTtypes.first.text.tr}",
                                      style: TextStyle(
                                          color: MyColors.blue_0571E0,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                                Visibility(
                                    visible: (widget.materiale.UnitPrice != 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: Get.width * 0.04,
                                              right: Get.width * 0.04),
                                          height: Get.width * 0.09,
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Price per Unit".tr,
                                                style: TextStyle(
                                                    color: MyColors.blue_0050A2,
                                                    fontSize: 12)),
                                            SizedBox(
                                              height: Get.width * 0.02,
                                            ),
                                            Row(children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    userDataController
                                                        .currencyKey,
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .blue_0571E0,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    "${widget.materiale.UnitNetPrice}",
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .blue_0571E0,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              Container(
                                                  width: 50,
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    fit: StackFit.loose,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      Get.width *
                                                                          0.00),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                userDataController
                                                                    .currencyKey,
                                                                style: TextStyle(
                                                                    color: MyColors
                                                                        .gray_8B9298),
                                                              ),
                                                              Text(
                                                                "${widget.materiale.UnitPrice}",
                                                                style: TextStyle(
                                                                    color: MyColors
                                                                        .gray_8B9298),
                                                              ),
                                                            ],
                                                          )),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 2.4,
                                                        //width: Get.width*0.11,
                                                        margin: EdgeInsets.only(
                                                            top: 7,
                                                            left: 5,
                                                            right: 5),
                                                        color: Colors.white,
                                                        child: Container(
                                                          height: 0.8,
                                                          // width: Get.width*0.13,
                                                          color: MyColors
                                                              .gray_8B9298,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  0.5),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                            ]),
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            )
                          ])),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                Container(child: getMaterialComponent()),
                SizedBox(
                    // height: Get.width * 0.05,
                    ),
              ],
            ),
            Positioned(
              top: -(Get.width * 0.05),
              left: -Get.width * 0.02,
              child: SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: Get.width * 0.1,
                      height: Get.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Get.width * 0.1)),
                      child: CartTopIcon(
                        type: CartTopIcon.favorite_type,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: Get.width * 0.08,
              left: (Get.width * 0.027),
              child: Container(
                // color: Colors.red,
                width: Get.width * 0.1,
                height: Get.width * 0.2,
                child: ProductOptions(
                  isHotSale: widget.materiale.IsHotSale,
                  isNew: widget.materiale.IsNew,
                  isFrozen: widget.materiale.IsFrozen,
                  optionType: ProductOptions.CARD_TYPE,
                ),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }

  Widget getMaterialComponent() {
    return Obx(() {
      var asd = materialCountController.unit_count;
      if (!widget.materiale.IsInStock) {
        return OutStockMaterialComponent(
          isUpdate: widget.materiale.didSubscribedToInventoryAlert,
        );
      } else if (materialCountController.unit_count > 0) {
        return FocusedMaterialComponent(
            materialCountController: materialCountController,
            materiale: widget.materiale);
      } else {
        return NormalMaterialComponent(
            materiale: widget.materiale,
            materialCountController: materialCountController);
      }
    });
  }
}
