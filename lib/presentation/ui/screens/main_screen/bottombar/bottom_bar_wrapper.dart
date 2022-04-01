import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarWrapper extends StatelessWidget {
  final Widget child;
  BottomBarWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final double bottomBarHeight = Get.width * 0.2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: child),
            SizedBox(
              height: bottomBarHeight * 0.75,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: BottomBar(
            bottomBarHeight: bottomBarHeight,
          ),
        )
      ],
    );
  }
}
