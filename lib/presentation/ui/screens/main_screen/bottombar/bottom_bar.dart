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
        width: Get.width,
        height: bottomBarHeight,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: bottomBarHeight * 0.25,
                  color: Colors.blue.withOpacity(0.2),
                ),
                Container(
                  height: bottomBarHeight * 0.75,
                  color: Colors.yellow,
                  child: Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          bottomBarController.changePage(newPageIndex: 1);
                        },
                        child: Text(
                          'Order',
                          style: TextStyle(
                              color: bottomBarController.currentPageIndex == 1
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          bottomBarController.changePage(newPageIndex: 2);
                        },
                        child: Text(
                          'Catalog',
                          style: TextStyle(
                              color: bottomBarController.currentPageIndex == 2
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          bottomBarController.changePage(newPageIndex: 4);
                        },
                        child: Text(
                          'Favorites',
                          style: TextStyle(
                              color: bottomBarController.currentPageIndex == 4
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          bottomBarController.changePage(newPageIndex: 5);
                        },
                        child: Text(
                          'Mohe',
                          style: TextStyle(
                              color: bottomBarController.currentPageIndex == 5
                                  ? Colors.white
                                  : Colors.black),
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
                    color: Colors.blueGrey,
                    child: GestureDetector(
                      onTap: () {
                        bottomBarController.changePage(newPageIndex: 3);
                      },
                      child: Text(
                        'Cart',
                        style: TextStyle(
                            color: bottomBarController.currentPageIndex == 3
                                ? Colors.white
                                : Colors.black),
                      ),
                    ))
              ],
            )
          ],
        ),
      );
    });
  }
}
