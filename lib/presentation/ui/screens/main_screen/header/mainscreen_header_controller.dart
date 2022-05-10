import 'package:***REMOVED***/presentation/ui/screens/main_screen/bottombar/bottom_bar_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_states.dart';
import 'package:get/get.dart';

class MainScreeenHeaderController extends GetxController {
  BottomBarController bottomBarController = Get.find();
  Rx<MainScreeenHeaderState> mainScreeenHeaderState = Rx(MSHShowCommon());
  RxBool enableBrunchSelection = RxBool(false);

  @override
  void onReady() {
    super.onReady();

    // Listen to page changes
    handlePageIndex(pageIndex: bottomBarController.currentPageIndex.value);
    bottomBarController.currentPageIndex.listen((pageIndex) {
      handlePageIndex(pageIndex: pageIndex);
    });
  }

  // Change some parameters on various pages
  handlePageIndex({required int pageIndex}) {
    switch (pageIndex) {
      case 1:
        enableBrunchSelection.value = true;
        break;
      default:
        enableBrunchSelection.value = false;
    }
  }

  Future hideAnother() async {
    if (mainScreeenHeaderState.value is! MSHShowCommon) {
      hide();
      await 0.3.delay();
    }
  }

  showContactus() async {
    if (mainScreeenHeaderState.value is MSHShowContactus) {
      hide();
      return;
    }
    await hideAnother();
    mainScreeenHeaderState.value = MSHShowContactus();
  }

  showBrunchSelection() async {
    if (mainScreeenHeaderState.value is MSHShowBrunch) {
      hide();
      return;
    }
    await hideAnother();
    mainScreeenHeaderState.value = MSHShowBrunch();
  }

  showSearch() async {
    await hideAnother();
    mainScreeenHeaderState.value = MSHShowSearch();
  }

  hide() {
    mainScreeenHeaderState.value = MSHShowCommon();
  }
}
