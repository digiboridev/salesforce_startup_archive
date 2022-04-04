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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        // color: Colors.red,
        width: Get.width,
        height: bottomBarHeight,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: bottomBarHeight * 0.4,
                  // color: Colors.blue.withOpacity(0.2),
                ),
                Container(
                  height: bottomBarHeight * 0.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
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
                                ? Image.asset('assets/icons/orders_active.png',
                                    height: Get.width * 0.06)
                                : Image.asset('assets/icons/orders.png',
                                    height: Get.width * 0.06),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text(
                              'Order',
                              style: TextStyle(
                                  color: bottomBarController
                                              .currentPageIndex.value ==
                                          1
                                      ? Color(0xff00458C)
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
                                ? Image.asset('assets/icons/catalog_active.png',
                                    height: Get.width * 0.06)
                                : Image.asset('assets/icons/catalog.png',
                                    height: Get.width * 0.06),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text(
                              'Catalog',
                              style: TextStyle(
                                  color: bottomBarController
                                              .currentPageIndex.value ==
                                          2
                                      ? Color(0xff00458C)
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
                                ? Image.asset('assets/icons/fav_active.png',
                                    height: Get.width * 0.06)
                                : Image.asset('assets/icons/fav.png',
                                    height: Get.width * 0.06),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text(
                              'Favorites',
                              style: TextStyle(
                                  color: bottomBarController
                                              .currentPageIndex.value ==
                                          4
                                      ? Color(0xff00458C)
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
                                ? Image.asset('assets/icons/home_active.png',
                                    height: Get.width * 0.06)
                                : Image.asset('assets/icons/home.png',
                                    height: Get.width * 0.06),
                            SizedBox(
                              height: Get.width * 0.01,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                  color: bottomBarController
                                              .currentPageIndex.value ==
                                          5
                                      ? Color(0xff00458C)
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: Get.width * 0.15,
                    width: Get.width * 0.15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: bottomBarController.currentPageIndex.value == 3
                            ? Color(0xff00458C)
                            : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(Get.width * 0.15)),
                    child: GestureDetector(
                      onTap: () {
                        bottomBarController.changePage(newPageIndex: 3);
                      },
                      child: Image.asset('assets/icons/cart.png',
                          width: Get.width * 0.06),
                    ))
              ],
            )
          ],
        ),
      );
    });
  }
}
