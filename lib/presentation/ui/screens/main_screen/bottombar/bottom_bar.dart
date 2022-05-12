import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/presentation/controllers/cart_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
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
                  // color: Colors.blue.withOpacity(0.2),
                ),
                Obx(() {
                  return AnimatedCrossFade(
                    crossFadeState: bottomBarController.showCount.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 300),
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeInOut,
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
                            color:
                                bottomBarController.currentPageIndex.value == 3
                                    ? MyColors.blue_00458C
                                    : Colors.blueGrey,
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.15)),
                        child: GestureDetector(
                          onTap: () {
                            bottomBarController.changePage(newPageIndex: 3);
                          },
                          child: Image.asset('assets/icons/cart.png',
                              width: Get.width * 0.06),
                        )),
                    if (cartController.cartItems.isNotEmpty)
                      Positioned(
                        left: -Get.width * 0.01,
                        child: Container(
                          padding: EdgeInsets.all(Get.width * 0.005),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.01)),
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
                fill:
                    cartController.frozenItemsPrice / cartController.totalPrice,
                text: 'Frozen: ' +
                    cartController.frozenItemsPrice.toStringAsFixed(2) +
                    ' / ' +
                    cartController.totalPrice.toStringAsFixed(2));
          }),
          Spacer(
            flex: 2,
          ),
          Obx(() {
            return buildCount(
                fill: cartController.dryItemsPrice / cartController.totalPrice,
                text: 'Dry: ' +
                    cartController.dryItemsPrice.toStringAsFixed(2) +
                    ' / ' +
                    cartController.totalPrice.toStringAsFixed(2));
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
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Get.width * 0.02)),
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

  Container buildButtonsRow() {
    return Container(
      key: Key('btnRow'),
      height: bottomBarHeight * 0.7,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              image: AssetImage('assets/images/bottombar.png'))),
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
                    ? Image.asset('assets/icons/home_active.png',
                        height: Get.width * 0.06)
                    : Image.asset('assets/icons/home.png',
                        height: Get.width * 0.06),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                Text(
                  'Home'.tr,
                  style: TextStyle(
                      color: bottomBarController.currentPageIndex.value == 1
                          ? MyColors.blue_00458C
                          : Colors.grey),
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
                    ? Image.asset('assets/icons/fav_active.png',
                        height: Get.width * 0.06)
                    : Image.asset('assets/icons/fav.png',
                        height: Get.width * 0.06),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                Text(
                  'Favorites'.tr,
                  style: TextStyle(
                      color: bottomBarController.currentPageIndex.value == 2
                          ? MyColors.blue_00458C
                          : Colors.grey),
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
                    ? Image.asset('assets/icons/catalog_active.png',
                        height: Get.width * 0.06)
                    : Image.asset('assets/icons/catalog.png',
                        height: Get.width * 0.06),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                Text(
                  'Catalog'.tr,
                  style: TextStyle(
                      color: bottomBarController.currentPageIndex.value == 4
                          ? MyColors.blue_00458C
                          : Colors.grey),
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
                    ? Image.asset('assets/icons/orders_active.png',
                        height: Get.width * 0.06)
                    : Image.asset('assets/icons/orders.png',
                        height: Get.width * 0.06),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                Text(
                  'Order'.tr,
                  style: TextStyle(
                      color: bottomBarController.currentPageIndex.value == 5
                          ? MyColors.blue_00458C
                          : Colors.grey),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
