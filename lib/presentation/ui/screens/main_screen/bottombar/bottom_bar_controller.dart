import 'dart:async';

import 'package:***REMOVED***/presentation/controllers/cart_controller.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  CartController _cartController = Get.find();

  final int pages = 5;
  RxInt currentPageIndex = 1.obs;
  RxInt futureIndex = 1.obs;
  RxBool showCount = RxBool(false);
  Timer? t;

  changePage({required int newPageIndex}) {
    if (newPageIndex < 1 || newPageIndex > pages) {
      throw Exception('Unsupported index');
    }
    futureIndex.value = newPageIndex;
  }

  // Show counter for 3 seconds
  showCountUi() {
    if (t is Timer) {
      t!.cancel();
    }
    showCount.value = true;
    t = Timer(Duration(seconds: 3), () => showCount.value = false);
  }

  @override
  void onReady() {
    super.onReady();

    // Listen to card changes
    _cartController.cartItemsStream.listen((event) {
      showCountUi();
    });
  }
}
