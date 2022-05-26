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

  Future changePage({required int newPageIndex}) {
    if (newPageIndex < 1 || newPageIndex > pages) {
      throw Exception('Unsupported index');
    }
    Completer _completer = new Completer();

    StreamSubscription? sub;

    handle(int p0) {
      if (p0 == newPageIndex) {
        _completer.complete();
        if (sub is StreamSubscription) {
          sub.cancel();
        }
      }
    }

    // complete future on page changed
    sub = currentPageIndex.listen((p0) {
      handle(p0);
    });

    if (futureIndex.value == newPageIndex) {
      // force listeners to update if value the same
      futureIndex.refresh();
    } else {
      futureIndex.value = newPageIndex;
    }

    return _completer.future;
  }

  Future goToCatalog() async {
    await changePage(newPageIndex: 4);
  }

  Future goToFavorites() async {
    await changePage(newPageIndex: 2);
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
