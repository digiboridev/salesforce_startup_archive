import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/search_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_loader.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/homepage/homepage_loader.dart';
import 'package:***REMOVED***/presentation/ui/screens/search_screen.dart';
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
  SearchController searchController = Get.put(SearchController());

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

  double headerHeight = Get.width * 0.4;
  final double bottomBarHeight = Get.width * 0.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F4F6),
        body: SafeArea(
          child: SizedBox.expand(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: headerHeight, bottom: bottomBarHeight * 0.3),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Obx(() {
                          return Stack(
                            children: [
                              buildPageView(),
                              if (searchController.showSearch.value)
                                SearchScreen()
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: BottomBar(
                    bottomBarHeight: bottomBarHeight,
                  ),
                ),
                MainScreenHeader(
                  headerHeight: headerHeight,
                )
              ],
            ),
          ),
        ));
  }

  PageView buildPageView() {
    return PageView(
      physics: BouncingScrollPhysics(),
      onPageChanged: (value) {
        bottomBarController.currentPageIndex.value = value + 1;
        if (value == 0) {
          if (headerHeight != Get.width * 0.4) {
            setState(() {
              headerHeight = Get.width * 0.4;
            });
          }
        } else {
          if (headerHeight != Get.width * 0.35) {
            setState(() {
              headerHeight = Get.width * 0.35;
            });
          }
        }
      },
      controller: pageController,
      children: [
        HomepageLoader(),
        Container(
          alignment: Alignment.center,
          color: Colors.red,
          child: Text('favorites'),
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.amber,
          child: Text('cart'),
        ),
        CatalogLoader(),
        Container(
          alignment: Alignment.center,
          color: Colors.amber,
          child: GestureDetector(
              onTap: () {
                Get.updateLocale(Locale('he'));
              },
              child: Text('hello'.tr)),
        ),
      ],
    );
  }
}
