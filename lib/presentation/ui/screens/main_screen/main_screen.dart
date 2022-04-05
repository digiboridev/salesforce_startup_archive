import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_wrapper.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_loader.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/homepage/homepage.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MaterialsCatalogController materialsCatalogController =
      Get.put(MaterialsCatalogController());

  late final BottomBarController bottomBarController;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    bottomBarController = Get.put(BottomBarController());
    pageController = PageController(
        initialPage: bottomBarController.currentPageIndex.value - 1);
    bottomBarController.futureIndex.listen((event) {
      pageController.animateToPage(event - 1,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  final double headerHeight = Get.width * 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: SizedBox.expand(
            child: BottomBarWrapper(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: headerHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: buildPageView(),
                        ),
                      ],
                    ),
                  ),
                  MainScreenHeader(
                    headerHeight: headerHeight,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  PageView buildPageView() {
    return PageView(
      onPageChanged: (value) =>
          bottomBarController.currentPageIndex.value = value + 1,
      controller: pageController,
      children: [
        Container(
          alignment: Alignment.center,
          color: Colors.amber,
          child: Text('orders'),
        ),
        CatalogLoader(),
        Container(
          alignment: Alignment.center,
          color: Colors.amber,
          child: Text('cart'),
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.red,
          child: Text('favorites'),
        ),
        HomePage(),
      ],
    );
  }
}
