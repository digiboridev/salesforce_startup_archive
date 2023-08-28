import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/domain/entities/cart_item.dart';
import 'package:salesforce.startup/domain/entities/materials/material.dart';
import 'package:salesforce.startup/domain/entities/materials/unit_types.dart';
import 'package:salesforce.startup/domain/services/image_caching_service.dart';
import 'package:salesforce.startup/presentation/controllers/cart_controller.dart';
import 'package:salesforce.startup/presentation/controllers/customer_controller.dart';
import 'package:salesforce.startup/presentation/controllers/favorites_controller.dart';
import 'package:salesforce.startup/presentation/controllers/materials_catalog_controller.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller.dart';
import 'package:salesforce.startup/presentation/ui/widgets/cart_top_icon.dart';
import 'package:salesforce.startup/presentation/ui/widgets/product_options.dart';
import 'package:salesforce.startup/presentation/ui/screens/material_screen_dialog.dart';
import 'package:salesforce.startup/presentation/ui/widgets/material_components/focused_material_component.dart';
import 'package:salesforce.startup/presentation/ui/widgets/material_components/normal_material_component.dart';
import 'package:salesforce.startup/presentation/ui/widgets/material_components/outstock_material_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  MaterialsCatalogController materialsCatalogController = Get.find();
  CartController cartController = Get.find();

  CustomerController customerController = Get.find();
  UserDataController userDataController = Get.find();
  FavoritesController favoritesController = Get.find();

  bool get hidePrices {
    return customerController.selectedCustomer!.hidePrices;
  }

  num priceWithVAT({required num price}) {
    if (customerController.selectedCustomer!.showPriceWithVAT) {
      return price + customerController.selectedCustomer!.vat;
    } else {
      return price;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.material.pricing.isNotEmpty) {
      print('asd');
    }
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      body: SafeArea(
          bottom: false,
          child: Container(
            color: MyColors.white_F4F4F6,
            child: SizedBox.expand(
              child: Column(
                children: [buildHeader(), Expanded(child: buildBody())],
              ),
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
        if (materialsCatalogController.getAlternativeMaterials(altItems: widget.material.alternativeItems).isNotEmpty) buildSuggestions(),
        SizedBox(
          height: Get.width * 0.06,
        ),
      ],
    );
  }

  Widget buildSuggestions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: Get.width * 0.04, left: Get.width * 0.03, right: Get.width * 0.03),
              child: Text(
                'Substitutes for this product'.tr,
                style: TextStyle(fontSize: 20, color: MyColors.blue_003E7E),
              )),
          Container(
              width: Get.width,
              height: Get.width * 0.7,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: materialsCatalogController.getAlternativeMaterials(altItems: widget.material.alternativeItems).map((e) {
                  return Container(
                    margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
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
                          style: TextStyle(color: MyColors.blue_003E7E, fontSize: 17),
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
    if (!widget.material.IsInStock) {
      return OutStockMaterialComponent(
        materiale: widget.material,
      );
    } else {
      return Obx(() {
        CartItem? cartItem = cartController.getItemByNumber(materialNumber: widget.material.MaterialNumber);

        if (cartItem is CartItem) {
          return FocusedMaterialComponent(
            materiale: widget.material,
            cartItem: cartItem,
          );
        } else {
          return NormalMaterialComponent(
            materiale: widget.material,
            onlyButton: true,
          );
        }
      });
    }
  }

  Container buildMaterial() {
    return Container(
      width: Get.width,
      // height: Get.width * 1.6,
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
              margin: EdgeInsets.only(left: Get.width * 0.06, right: Get.width * 0.06, top: Get.width * 0.04, bottom: Get.width * 0.02),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
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
                          ProductOptions(isNew: true, isHotSale: true, optionType: ProductOptions.MATERIAL_SCREEN_TYPE, isFrozen: true),
                          Container(
                              width: Get.width * 0.5,
                              child: Text(
                                widget.material.Name,
                                style: TextStyle(
                                  color: MyColors.blue_003E7E,
                                  fontSize: Get.width * 0.05,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          Text(
                            "${'Code'.tr}: " + widget.material.SFId,
                            style: TextStyle(
                              color: MyColors.blue_003E7E,
                              fontSize: Get.width * 0.035,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text("${'Barcode'.tr}: " + widget.material.Barcode,
                              style: TextStyle(
                                color: MyColors.blue_003E7E,
                                fontSize: Get.width * 0.035,
                                fontWeight: FontWeight.w400,
                              )),
                          Text('${'Minimum order'.tr}: ' + widget.material.MinimumOrderQuantity.toString() + ' ' + widget.material.salesUnitType.text,
                              style: TextStyle(
                                color: MyColors.blue_003E7E,
                                fontSize: Get.width * 0.035,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.width * 0.06),
                    width: Get.width,
                    child: Row(
                      children: [
                        Text(
                          'About the product'.tr,
                          style: TextStyle(fontSize: 18, color: MyColors.blue_003E7E),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(Get.width * 0.03),
                    child: Text(widget.material.ProductDescription ?? 'No Description'),
                  ),
                  if (widget.material.freeGoods.isNotEmpty || widget.material.pricing.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.all(Get.width * 0.03),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: Get.width * 0.05,
                            width: Get.width * 0.05,
                            decoration: BoxDecoration(color: MyColors.blue_6DA5EC, shape: BoxShape.circle),
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
                            style: TextStyle(color: MyColors.blue_003E7E, fontSize: 18),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                        ],
                      ),
                    ),
                  if (widget.material.freeGoods.isNotEmpty || widget.material.pricing.isNotEmpty)
                    Container(
                      color: MyColors.blue_003E7E,
                      height: 1,
                      width: Get.width,
                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                    ),
                  if (widget.material.freeGoods.isNotEmpty || widget.material.pricing.isNotEmpty) buildFreeGodsAndPricing(),
                  if (widget.material.freeGoods.isNotEmpty || widget.material.pricing.isNotEmpty)
                    Container(
                      color: MyColors.blue_003E7E,
                      height: 1,
                      width: Get.width,
                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                    ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.width * 0.05, bottom: Get.width * 0.05),
                    child: pricesRow(),
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
                  margin: EdgeInsets.only(right: Get.width * 0.06, left: Get.width * 0.06),
                  width: Get.width * 0.09,
                  height: Get.width * 0.09,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 5)],
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

  Widget buildFreeGodsAndPricing() {
    List<Widget> rows = [];

    widget.material.freeGoods.forEach((freedog) {
      rows.add(Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Text(
                freedog.BuyQty.toString(),
                style: TextStyle(
                  color: MyColors.blue_0571E0,
                  fontSize: Get.width * 0.035,
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Text(
                UnitType.fromSalesUnit(freedog.QuantityUnit).text.tr,
                style: TextStyle(
                  color: MyColors.blue_0571E0,
                  fontSize: Get.width * 0.035,
                ),
              ),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              Text(
                freedog.GetQty.toString(),
                style: TextStyle(
                  color: MyColors.blue_0571E0,
                  fontSize: Get.width * 0.035,
                ),
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Text(
                UnitType.fromSalesUnit(freedog.GetQuantityUnit).text.tr,
                style: TextStyle(
                  color: MyColors.blue_0571E0,
                  fontSize: Get.width * 0.035,
                ),
              ),
            ],
          ))
        ],
      ));
    });

    widget.material.pricing.forEach(
      (pricing) {
        pricing.scales.forEach((scale) {
          rows.add(Row(
            children: [
              Expanded(
                  child: Row(
                // textDirection: TextDirection.rtl,
                children: [
                  Text(
                    scale.ScaleQuantityFrom.toString(),
                    style: TextStyle(
                      color: MyColors.blue_0571E0,
                      fontSize: Get.width * 0.035,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Text(
                    UnitType.fromSalesUnit(scale.Unit).text.tr,
                    style: TextStyle(
                      color: MyColors.blue_0571E0,
                      fontSize: Get.width * 0.035,
                    ),
                  ),
                ],
              )),
              if (pricing.IsPercentage)
                Expanded(
                    child: Row(
                  children: [
                    Text(
                      scale.Rate.toStringAsFixed(0),
                      style: TextStyle(
                        color: MyColors.blue_0571E0,
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                    Text(
                      '%',
                      style: TextStyle(
                        color: MyColors.blue_0571E0,
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      'off',
                      style: TextStyle(
                        color: MyColors.blue_0571E0,
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                  ],
                )),
              if (!pricing.IsPercentage)
                Expanded(
                    child: Row(
                  children: [
                    Text(
                      scale.Rate.toStringAsFixed(0),
                      style: TextStyle(
                        color: MyColors.blue_0571E0,
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                    Text(
                      '₪',
                      style: TextStyle(
                        color: MyColors.blue_0571E0,
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      'off'.tr,
                      style: TextStyle(
                        color: MyColors.blue_0571E0,
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                  ],
                )),
            ],
          ));
        });
      },
    );

    return Container(
      margin: EdgeInsets.only(left: Get.width * 0.07, right: Get.width * 0.07, top: Get.width * 0.03, bottom: Get.width * 0.03),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Shop'.tr,
                  style: TextStyle(
                    color: MyColors.blue_0050A2,
                    fontSize: Get.width * 0.04,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Get'.tr,
                  style: TextStyle(
                    color: MyColors.blue_0050A2,
                    fontSize: Get.width * 0.04,
                  ),
                ),
              )
            ],
          ),
          ...rows
        ],
      ),
    );
  }

  Widget pricesRow() {
    if (hidePrices) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Quantity".tr,
            style: TextStyle(color: MyColors.blue_0050A2, fontSize: 17),
          ),
          Text(
              "${widget.material.countByUnitType(widget.material.avaliableUnitTtypes.first)} ${'units per'.tr} ${widget.material.avaliableUnitTtypes.first.text.tr}",
              style: TextStyle(color: MyColors.blue_0571E0, fontSize: 20)),
        ],
      );
    } else {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quantity".tr,
                style: TextStyle(
                  color: MyColors.blue_0050A2,
                  fontSize: Get.width * 0.04,
                ),
              ),
              Text(
                "${widget.material.countByUnitType(widget.material.avaliableUnitTtypes.first)}" +
                    " ${'units per'.tr} ${widget.material.avaliableUnitTtypes.first.text.tr}",
                style: TextStyle(
                  color: MyColors.blue_0571E0,
                  fontSize: Get.width * 0.045,
                ),
              )
            ],
          ),
          Spacer(),
          Container(
            height: Get.width * 0.09,
            width: 1,
            color: Colors.grey,
          ),
          Spacer(),
          Visibility(
              visible: (widget.material.UnitPrice != 0 && !hidePrices),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Price per Unit".tr,
                      style: TextStyle(
                        color: MyColors.blue_0050A2,
                        fontSize: Get.width * 0.04,
                      )),
                  Row(children: [
                    Row(
                      children: [
                        Text(
                          userDataController.currencyKey,
                          style: TextStyle(
                            color: MyColors.blue_0571E0,
                            fontSize: Get.width * 0.04,
                          ),
                        ),
                        Text(
                          priceWithVAT(price: widget.material.UnitNetPrice).toString(),
                          style: TextStyle(
                            color: MyColors.blue_0571E0,
                            fontSize: Get.width * 0.045,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Stack(
                      children: [
                        Row(
                          children: [
                            Text(
                              userDataController.currencyKey,
                              style: TextStyle(
                                color: MyColors.gray_8B9298,
                                fontSize: Get.width * 0.04,
                              ),
                            ),
                            Text(
                              priceWithVAT(price: widget.material.UnitPrice).toString(),
                              style: TextStyle(
                                color: MyColors.gray_8B9298,
                                fontSize: Get.width * 0.045,
                              ),
                            ),
                          ],
                        ),
                        Positioned.fill(
                          child: Container(
                            alignment: Alignment.center,
                            height: 2.4,
                            child: Container(
                              height: 0.8,
                              // width: Get.width*0.13,
                              color: MyColors.gray_8B9298,
                              margin: EdgeInsets.all(0.5),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                ],
              )),
          Spacer(),
        ],
      );
    }
  }

  Widget buildHeader() {
    return Container(
      height: Get.width * 0.3,
      color: MyColors.blue_00458C,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Directionality.of(context) == TextDirection.rtl ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  AssetImages.startupLogo,
                  width: Get.width * 0.3,
                ),
              ),
              Hero(
                tag: 'contact_btn',
                child: Image.asset(
                  AssetImages.contactButton,
                  width: Get.width * 0.05,
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
