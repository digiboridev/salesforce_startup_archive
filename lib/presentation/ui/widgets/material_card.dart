import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/entities/cart_item.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/controllers/cart_controller.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_controller.dart';
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
  // late MaterialCountController materialCountController;
  CartController cartController = Get.find();

  UserDataController userDataController = Get.find();
  CustomerController customerController = Get.find();
  FavoritesController favoritesController = Get.find();

  // @override
  // void initState() {
  //   materialCountController = Get.put(
  //       MaterialCountController(
  //         material: widget.materiale,
  //       ),
  //       tag: widget.materiale.hashCode.toString());
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   Get.delete<MaterialCountController>(
  //       tag: widget.materiale.hashCode.toString());
  // }

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
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.03),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  Spacer(),
                                  Container(
                                    height: Get.width * 0.09,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  Spacer(),
                                  Visibility(
                                      visible:
                                          (widget.materiale.UnitPrice != 0 &&
                                              !hidePrices),
                                      child: Column(
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
                                                      color:
                                                          MyColors.blue_0571E0,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  priceWithVAT(
                                                          price: widget
                                                              .materiale
                                                              .UnitNetPrice)
                                                      .toString(),
                                                  style: TextStyle(
                                                      color:
                                                          MyColors.blue_0571E0,
                                                      fontSize: 12),
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
                                                      userDataController
                                                          .currencyKey,
                                                      style: TextStyle(
                                                          color: MyColors
                                                              .gray_8B9298),
                                                    ),
                                                    Text(
                                                      priceWithVAT(
                                                              price: widget
                                                                  .materiale
                                                                  .UnitPrice)
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: MyColors
                                                              .gray_8B9298),
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
                                                      color:
                                                          MyColors.gray_8B9298,
                                                      margin:
                                                          EdgeInsets.all(0.5),
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
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 1,
                              blurRadius: 10)
                        ],
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

  Widget buildTopIcon() {
    if (widget.insideFavorites) {
      return CartTopIcon(
        type: CartTopIcon.menu_type,
      );
    } else if (widget.insideCart) {
      return GestureDetector(
        onTap: () => cartController.removeItem(
            materialNumber: widget.materiale.MaterialNumber),
        child: CartTopIcon(
          type: CartTopIcon.close_type,
        ),
      );
    } else {
      return Obx(() {
        if (favoritesController.isMaterialInFavorite(
            material: widget.materiale)) {
          return CartTopIcon(
            type: CartTopIcon.favorite_select_type,
          );
        } else {
          return GestureDetector(
            onTap: () => favoritesController.addItemToAllList(
                material: widget.materiale),
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
        print(cartController.cartItems);
        CartItem? cartItem = cartController.getItemByNumber(
            materialNumber: widget.materiale.MaterialNumber);

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
