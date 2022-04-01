import 'package:get/get.dart';

class BottomBarController extends GetxController {
  final int pages = 5;
  RxInt currentPageIndex = 1.obs;
  RxInt futureIndex = 1.obs;

  changePage({required int newPageIndex}) {
    if (newPageIndex < 1 || newPageIndex > pages) {
      throw Exception('Unsupported index');
    }
    futureIndex.value = newPageIndex;
  }
}
