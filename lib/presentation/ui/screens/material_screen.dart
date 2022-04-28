import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/presentation/controllers/material_count_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/product_options.dart';
import 'package:***REMOVED***/presentation/ui/screens/material_screen_dialog.dart';
import 'package:***REMOVED***/presentation/ui/widgets/loaders/points_loader.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/focused_material_component.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/normal_material_component.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_components/outstock_material_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/services/image_caching_service.dart';
import '../widgets/cart_top_icon.dart';

class MaterialScreen extends StatefulWidget {
  final Materiale material;

  MaterialScreen({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  late MaterialCountController materialCountController;
  MaterialsCatalogController materialsCatalogController = Get.find();

  @override
  void initState() {
    super.initState();
    materialCountController = Get.put(
        MaterialCountController(material: widget.material),
        tag: widget.material.hashCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F6),
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          children: [buildHeader(), Expanded(child: buildBody())],
        ),
      )),
    );
  }

  Widget buildBody() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: Get.width * 0.02,
        ),
        buildMaterial(),
        SizedBox(
          height: Get.width * 0.06,
        ),
        if (materialsCatalogController
            .getAlternativeMaterials(altItems: widget.material.alternativeItems)
            .isNotEmpty)
          buildSuggestions(),
        SizedBox(
          height: Get.width * 0.06,
        ),
      ],
    );
  }

  Widget buildSuggestions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: Get.width * 0.04,
                  left: Get.width * 0.03,
                  right: Get.width * 0.03),
              child: Text(
                'Substitutes for this product'.tr,
                style: TextStyle(fontSize: 20, color: MyColors.blue_003E7E),
              )),
          Container(
              width: Get.width,
              height: Get.width * 0.7,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: materialsCatalogController
                    .getAlternativeMaterials(
                        altItems: widget.material.alternativeItems)
                    .map((e) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: Get.width * 0.05, right: Get.width * 0.05),
                    width: Get.width * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedImage(
                          Url: e.ImageUrl,
                          width: Get.width * 0.15,
                          height: Get.width * 0.3,
                        ),
                        Text(
                          e.Name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyColors.blue_003E7E, fontSize: 17),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }

  Widget getMaterialComponent() {
    return Obx(() {
      print(materialCountController.unit_count);
      if (!widget.material.IsInStock) {
        return OutStockMaterialComponent(
          isUpdate: widget.material.didSubscribedToInventoryAlert,
        );
      }
      if (materialCountController.unit_count > 0) {
        return FocusedMaterialComponent(
            materialCountController: materialCountController,
            materiale: widget.material);
      } else {
        return NormalMaterialComponent(
            materiale: widget.material,
            materialCountController: materialCountController);
      }
    });
  }

  Container buildMaterial() {
    return Container(
      width: Get.width,
      // height: Get.width * 1.6,
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              margin: EdgeInsets.only(
                  left: Get.width * 0.06,
                  right: Get.width * 0.06,
                  top: Get.width * 0.04,
                  bottom: Get.width * 0.02),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.03, right: Get.width * 0.03),
                        child: GestureDetector(
                            onTap: showPhotoDialog,
                            child: CachedImage(
                              Url: widget.material.ImageUrl,
                              width: Get.width * 0.20,
                              height: Get.width * 0.25,
                            )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.width * 0.01,
                          ),
                          ProductOptions(
                              isNew: true,
                              isHotSale: true,
                              optionType: ProductOptions.MATERIAL_SCREEN_TYPE,
                              isFrozen: true),
                          SizedBox(
                            height: Get.width * 0.01,
                          ),
                          Container(
                              width: Get.width * 0.5,
                              child: Text(
                                widget.material.Name,
                                style: TextStyle(
                                    color: MyColors.blue_003E7E, fontSize: 18),
                              )),
                          SizedBox(
                            height: Get.width * 0.025,
                          ),
                          Text(
                            "${'Code'.tr}: " + widget.material.SFId,
                            style: TextStyle(
                              color: MyColors.blue_003E7E,
                            ),
                          ),
                          SizedBox(
                            height: Get.width * 0.01,
                          ),
                          Text("${'Barcode'.tr}: " + widget.material.Barcode,
                              style: TextStyle(
                                color: MyColors.blue_003E7E,
                              )),
                          SizedBox(
                            height: Get.width * 0.01,
                          ),
                          Text(
                              '${'Minimum order'.tr}: ' +
                                  widget.material.MinimumOrderQuantity
                                      .toString() +
                                  ' ' +
                                  widget.material.salesUnitType.text,
                              style: TextStyle(
                                color: MyColors.blue_003E7E,
                              )),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Get.width * 0.03,
                        right: Get.width * 0.03,
                        top: Get.width * 0.06),
                    width: Get.width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About the product'.tr,
                      style:
                          TextStyle(fontSize: 18, color: MyColors.blue_003E7E),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(Get.width * 0.03),
                    child: Text(
                        widget.material.ProductDescription ?? 'No Description'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Get.width * 0.03),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: Get.width * 0.05,
                          width: Get.width * 0.05,
                          decoration: BoxDecoration(
                              color: MyColors.blue_6DA5EC,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text(
                          "The Rabbinical Society".tr,
                          style: TextStyle(
                              color: MyColors.blue_003E7E, fontSize: 18),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: MyColors.blue_003E7E,
                    height: 1,
                    width: Get.width,
                    margin: EdgeInsets.only(
                        left: Get.width * 0.03, right: Get.width * 0.03),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: Get.width * 0.07,
                        right: Get.width * 0.07,
                        top: Get.width * 0.03,
                        bottom: Get.width * 0.03),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Shop".tr,
                              style: TextStyle(
                                  fontSize: 16, color: MyColors.blue_0050A2),
                            ),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text('3 surfaces',
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.blue_0571E0)),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text('3 surfaces',
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.blue_0571E0)),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text('3 surfaces',
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.blue_0571E0)),
                          ],
                        ),
                        SizedBox(
                          width: Get.width * 0.2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Get".tr,
                              style: TextStyle(
                                  fontSize: 16, color: MyColors.blue_0050A2),
                            ),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text("Gift Pallets",
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.blue_0571E0)),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text("25% off",
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.blue_0571E0)),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text("Cardboard Gift",
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.blue_0571E0)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: MyColors.blue_003E7E,
                    height: 1,
                    width: Get.width,
                    margin: EdgeInsets.only(
                        left: Get.width * 0.03, right: Get.width * 0.03),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.03,
                        right: Get.width * 0.03,
                        top: Get.width * 0.05,
                        bottom: Get.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity".tr,
                          style: TextStyle(
                              color: MyColors.blue_0050A2, fontSize: 17),
                        ),
                        Text(
                            "${widget.material.countByUnitType(widget.material.avaliableUnitTtypes.first)} ${'units per'.tr} ${widget.material.avaliableUnitTtypes.first.text.tr}",
                            style: TextStyle(
                                color: MyColors.blue_0571E0, fontSize: 20)),
                      ],
                    ),
                  ),
                  getMaterialComponent(),
                ],
              )),
          SizedBox(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      right: Get.width * 0.06, left: Get.width * 0.06),
                  width: Get.width * 0.09,
                  height: Get.width * 0.09,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 1,
                            blurRadius: 5)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Get.width * 0.1)),
                  child: CartTopIcon(
                    type: CartTopIcon.favorite_select_type,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      height: Get.width * 0.3,
      color: Color(0xff00458C),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'contact_btn',
                child: Image.asset(
                  'assets/icons/contact.png',
                  width: Get.width * 0.05,
                ),
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/***REMOVED***_logo.png',
                  width: Get.width * 0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  void showPhotoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return MaterialScreenDialog(image_uri: widget.material.ImageUrl);
        });
  }
}
