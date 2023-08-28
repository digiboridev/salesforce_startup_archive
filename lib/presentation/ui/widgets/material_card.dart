import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/domain/entities/cart_item.dart';
import 'package:salesforce.startup/domain/entities/materials/material.dart';
import 'package:salesforce.startup/domain/entities/materials/unit_types.dart';
import 'package:salesforce.startup/domain/services/image_caching_service.dart';
import 'package:salesforce.startup/presentation/controllers/cart_controller.dart';
import 'package:salesforce.startup/presentation/controllers/customer_controller.dart';
import 'package:salesforce.startup/presentation/controllers/favorites_controller.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller.dart';
import 'package:salesforce.startup/presentation/ui/widgets/cart_top_icon.dart';
import 'package:salesforce.startup/presentation/ui/widgets/product_options.dart';
import 'package:salesforce.startup/presentation/ui/screens/material_screen.dart';
import 'package:salesforce.startup/presentation/ui/widgets/material_components/focused_material_component.dart';
import 'package:salesforce.startup/presentation/ui/widgets/material_components/normal_material_component.dart';
import 'package:salesforce.startup/presentation/ui/widgets/material_components/outstock_material_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialCard extends StatefulWidget {
  final Materiale materiale;
  final bool insideFavorites;
  final bool insideCart;
  MaterialCard({
    Key? key,
    required this.materiale,
    this.insideFavorites = false,
    this.insideCart = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MaterialCardState();
}

class MaterialCardState extends State<MaterialCard> {
  CartController cartController = Get.find();

  UserDataController userDataController = Get.find();
  FavoritesController favoritesController = Get.find();
  CustomerController customerController = Get.find();
  bool ignoreBonus = false;

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
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.04))),
      margin: EdgeInsets.only(bottom: Get.width * 0.025, left: Get.width * 0.025, top: Get.width * 0.05, right: Get.width * 0.025),
      // clipBehavior: Clip.antiAlias,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
              onTap: () {
                if (!(widget.insideFavorites || widget.insideCart)) {
                  Get.to(
                      () => MaterialScreen(
                            material: widget.materiale,
                          ),
                      transition: Transition.cupertino);
                }
              },
              child: Column(
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
                              borderRadius: BorderRadius.circular(Get.width * 0.03),
                              boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 10)]),
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
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            widget.materiale.Name,
                            // 'Jacobs Kosher Passover Nescafe with Kernels',

                            style: TextStyle(height: 1, color: MyColors.blue_003E7E, fontSize: Get.width * 0.045, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: Get.width * 0.03,
                          ),
                          pricesRow()
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
                  buildBonusesRow()
                ],
              )),
          Positioned(
            top: -(Get.width * 0.05),
            left: Get.width * 0,
            right: Get.width * 0,
            child: SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: Get.width * 0.1,
                    height: Get.width * 0.1,
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 10)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Get.width * 0.1)),
                    child: buildTopIcon(),
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
    );
  }

  Widget buildBonusesRow() {
    return Obx(() {
      CartItem? cartItem = cartController.getItemByNumber(materialNumber: widget.materiale.MaterialNumber);

      List<String> reachedScales = [];

      if (cartItem is CartItem) {
        widget.materiale.pricing.forEach(
          (pricing) {
            pricing.scales.forEach((scales) {
              if (scales.Unit == cartItem.unit && cartItem.quantity >= scales.ScaleQuantityFrom) {
                if (pricing.IsPercentage) {
                  reachedScales.add('You got ' + scales.Rate.toString() + ' % ' + 'off'.tr);
                } else {
                  reachedScales.add('You got ' + scales.Rate.toString() + ' ₪ ' + 'off'.tr);
                }
              }
            });
          },
        );
      }

      List<String> avaliableScales = [];

      if (cartItem is CartItem) {
        widget.materiale.pricing.forEach(
          (pricing) {
            pricing.scales.forEach((scales) {
              if (scales.Unit == cartItem.unit && cartItem.quantity < scales.ScaleQuantityFrom) {
                if (pricing.IsPercentage) {
                  avaliableScales.add('Buy ' +
                      scales.ScaleQuantityFrom.toString() +
                      ' ' +
                      UnitType.fromSalesUnit(scales.Unit).text.tr +
                      ' get ' +
                      scales.Rate.toString() +
                      ' % ' +
                      'off'.tr);
                } else {
                  avaliableScales.add('Buy ' +
                      scales.ScaleQuantityFrom.toString() +
                      ' ' +
                      UnitType.fromSalesUnit(scales.Unit).text.tr +
                      ' get ' +
                      scales.Rate.toString() +
                      ' ₪ ' +
                      'off'.tr);
                }
              }
            });
          },
        );
      }

      if (reachedScales.isNotEmpty) {
        return Container(
            height: Get.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Get.width * 0.03),
                bottomRight: Radius.circular(Get.width * 0.03),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffFFBD00), Color(0xffFF8800)],
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                Spacer(),
                Image.asset(
                  AssetImages.have_new_list,
                  width: Get.height * 0.03,
                ),
                Spacer(
                  flex: 5,
                ),
                Text(
                  reachedScales.last,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width * 0.04,
                  ),
                ),
                Spacer(
                  flex: 5,
                ),
                Image.asset(
                  AssetImages.have_new_list,
                  width: Get.height * 0.03,
                ),
                Spacer(),
              ],
            ));
      } else {
        if (avaliableScales.isNotEmpty && !ignoreBonus) {
          return Container(
              height: Get.width * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Get.width * 0.03),
                  bottomRight: Radius.circular(Get.width * 0.03),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffFFBD00), Color(0xffFF8800)],
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    'SALE!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    AssetImages.sale,
                    width: Get.height * 0.03,
                  ),
                  Spacer(),
                  Text(
                    avaliableScales.first,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.04,
                    ),
                  ),
                  Spacer(
                    flex: 10,
                  ),
                  GestureDetector(
                    onTap: () => setState(() => ignoreBonus = true),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: Get.width * 0.04,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ));
        }
      }

      return SizedBox();
    });
  }

  Row pricesRow() {
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
                fontWeight: FontWeight.w500,
              ),
            ),
            // SizedBox(
            //   height: Get.width * 0.02,
            // ),
            Text(
              widget.materiale.countByUnitType(widget.materiale.avaliableUnitTtypes.first).toString() +
                  " " +
                  'units per'.tr +
                  " " +
                  widget.materiale.avaliableUnitTtypes.first.text.tr,
              style: TextStyle(
                color: MyColors.blue_0571E0,
                fontSize: Get.width * 0.035,
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
            visible: (widget.materiale.UnitPrice != 0 && !hidePrices),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price per Unit".tr,
                    style: TextStyle(
                      color: MyColors.blue_0050A2,
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w500,
                    )),
                // SizedBox(
                //   height: Get.width * 0.02,
                // ),
                Row(children: [
                  Row(
                    children: [
                      Text(
                        userDataController.currencyKey,
                        style: TextStyle(
                          color: MyColors.blue_0571E0,
                          fontSize: Get.width * 0.035,
                        ),
                      ),
                      Text(
                        priceWithVAT(price: widget.materiale.UnitNetPrice).toString(),
                        style: TextStyle(
                          color: MyColors.blue_0571E0,
                          fontSize: Get.width * 0.035,
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
                              fontSize: Get.width * 0.035,
                            ),
                          ),
                          Text(
                            priceWithVAT(price: widget.materiale.UnitPrice).toString(),
                            style: TextStyle(
                              color: MyColors.gray_8B9298,
                              fontSize: Get.width * 0.035,
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

  Widget buildTopIcon() {
    if (widget.insideFavorites) {
      return GestureDetector(
        onTap: () => favoritesController.showBelongEdit(material: widget.materiale),
        child: CartTopIcon(
          type: CartTopIcon.menu_type,
        ),
      );
    } else if (widget.insideCart) {
      return GestureDetector(
        onTap: () => cartController.removeItem(materialNumber: widget.materiale.MaterialNumber),
        child: CartTopIcon(
          type: CartTopIcon.close_type,
        ),
      );
    } else {
      return Obx(() {
        if (favoritesController.isMaterialInFavorite(material: widget.materiale)) {
          return CartTopIcon(
            type: CartTopIcon.favorite_select_type,
          );
        } else {
          return GestureDetector(
            onTap: () => favoritesController.addItemToAllList(material: widget.materiale),
            child: CartTopIcon(
              type: CartTopIcon.favorite_type,
            ),
          );
        }
      });
    }
  }

  Widget getMaterialComponent() {
    if (!widget.materiale.IsInStock) {
      return OutStockMaterialComponent(
        materiale: widget.materiale,
      );
    } else {
      return Obx(() {
        CartItem? cartItem = cartController.getItemByNumber(materialNumber: widget.materiale.MaterialNumber);

        if (cartItem is CartItem) {
          return FocusedMaterialComponent(
            materiale: widget.materiale,
            cartItem: cartItem,
          );
        } else {
          return NormalMaterialComponent(
            materiale: widget.materiale,
          );
        }
      });
    }
  }
}
