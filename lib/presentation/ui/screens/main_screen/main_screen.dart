import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_wrapper.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox.expand(
        child: BottomBarWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (value) =>
                      bottomBarController.currentPageIndex.value = value + 1,
                  controller: pageController,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: Colors.amber,
                      child: Text('orders'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Text('catalog'),
                    ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
