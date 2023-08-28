import 'dart:ui';

import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/presentation/controllers/cart_controller.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  final double bottomBarHeight;
  BottomBar({
    Key? key,
    required this.bottomBarHeight,
  }) : super(key: key);

  final BottomBarController bottomBarController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: Get.width,
        height: bottomBarHeight,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: bottomBarHeight * 0.3,
                ),
                Obx(() {
                  return AnimatedCrossFade(
                    crossFadeState: bottomBarController.showCount.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 100),
                    firstCurve: Curves.linear,
                    secondCurve: Curves.linear,
                    firstChild: buildPricesRow(),
                    secondChild: buildButtonsRow(),
                  );
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient:
                                LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [MyColors.blue_00458C, MyColors.blue_0D63BB]),
                            borderRadius: BorderRadius.circular(Get.width * 0.15)),
                        child: GestureDetector(
                          onTap: () {
                            bottomBarController.changePage(newPageIndex: 3);
                          },
                          child: Image.asset(AssetImages.cart, width: Get.width * 0.06),
                        )),
                    if (cartController.cartItems.isNotEmpty)
                      Positioned(
                        left: -Get.width * 0.01,
                        child: Container(
                          padding: EdgeInsets.all(Get.width * 0.005),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(Get.width * 0.01)),
                          child: Text(
                            cartController.cartItems.length.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Container buildPricesRow() {
    return Container(
      key: Key('priceRow'),
      height: bottomBarHeight * 0.7,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          image: AssetImage('assets/images/bottombar_blue.png'),
        ),
      ),
      child: Row(
        children: [
          Spacer(),
          Obx(() {
            return buildCount(
                fill: cartController.frozenItemsPrice / cartController.totalPrice,
                text: 'Frozen: ' + cartController.frozenItemsPrice.toStringAsFixed(2) + ' / ' + cartController.totalPrice.toStringAsFixed(2));
          }),
          Spacer(
            flex: 2,
          ),
          Obx(() {
            return buildCount(
                fill: cartController.dryItemsPrice / cartController.totalPrice,
                text: 'Dry: ' + cartController.dryItemsPrice.toStringAsFixed(2) + ' / ' + cartController.totalPrice.toStringAsFixed(2));
          }),
          Spacer()
        ],
      ),
    );
  }

  Widget buildCount({required String text, required double fill}) {
    if (fill.isNaN) fill = 0;
    assert(fill <= 1 && fill >= 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(
          flex: 2,
        ),
        Container(
          width: Get.width * 0.3,
          height: Get.width * 0.02,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Get.width * 0.02)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: Colors.green,
              height: Get.width * 0.02,
              width: Get.width * 0.3 * fill,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        Spacer(),
      ],
    );
  }

  Widget buildButtonsRow() {
    return Stack(
      children: [
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              child: CustomPaint(
                size: Size(Get.width, bottomBarHeight * 0.7),
                painter: Hole(),
              ),
            )),
        Container(
          key: Key('btnRow'),
          height: bottomBarHeight * 0.7,
          decoration: BoxDecoration(
              image: DecorationImage(opacity: 0.7, fit: BoxFit.fitWidth, alignment: Alignment.topCenter, image: AssetImage('assets/images/bottombar.png'))),
          child: Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  bottomBarController.changePage(newPageIndex: 1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomBarController.currentPageIndex.value == 1
                        ? Image.asset(AssetImages.home_active, height: Get.width * 0.06)
                        : Image.asset(AssetImages.home, height: Get.width * 0.06),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),
                    Text(
                      'Home'.tr,
                      style: TextStyle(color: bottomBarController.currentPageIndex.value == 1 ? MyColors.blue_00458C : Colors.grey),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  bottomBarController.changePage(newPageIndex: 2);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomBarController.currentPageIndex.value == 2
                        ? Image.asset(AssetImages.fav_active, height: Get.width * 0.06)
                        : Image.asset(AssetImages.fav, height: Get.width * 0.06),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),
                    Text(
                      'Favorites'.tr,
                      style: TextStyle(color: bottomBarController.currentPageIndex.value == 2 ? MyColors.blue_00458C : Colors.grey),
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 4,
              ),
              GestureDetector(
                onTap: () {
                  bottomBarController.changePage(newPageIndex: 4);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomBarController.currentPageIndex.value == 4
                        ? Image.asset(AssetImages.catalog_active, height: Get.width * 0.06)
                        : Image.asset(AssetImages.catalog, height: Get.width * 0.06),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),
                    Text(
                      'Catalog'.tr,
                      style: TextStyle(color: bottomBarController.currentPageIndex.value == 4 ? MyColors.blue_00458C : Colors.grey),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  bottomBarController.changePage(newPageIndex: 5);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomBarController.currentPageIndex.value == 5
                        ? Image.asset(AssetImages.orders_active, height: Get.width * 0.06)
                        : Image.asset(AssetImages.orders, height: Get.width * 0.06),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),
                    Text(
                      'Order'.tr,
                      style: TextStyle(color: bottomBarController.currentPageIndex.value == 5 ? MyColors.blue_00458C : Colors.grey),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class Hole extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 6;
    double blurRadius = size.width / 50;
    canvas.drawCircle(
      Offset(size.width / 2, -size.height / 5),
      radius,
      Paint()
        ..blendMode = BlendMode.clear
        // The mask filter gives some fuziness to the cutout.
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius),
    );
  }

  @override
  bool shouldRepaint(Hole oldDelegate) => false;
}
