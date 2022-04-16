import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageLoader extends StatefulWidget {
  HomepageLoader({Key? key}) : super(key: key);

  @override
  State<HomepageLoader> createState() => _HomepageLoaderState();
}

class _HomepageLoaderState extends State<HomepageLoader>
    with AutomaticKeepAliveClientMixin {
  final MaterialsCatalogController materialsCatalogController = Get.find();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      MaterialsCatalogState state =
          materialsCatalogController.materialsCatalogState.value;

      if (state is MCSCommon) {
        return HomePage(
          key: ObjectKey(state.catalog),
          materialsCatalog: state.catalog,
        );
      } else if (state is MCSLoadingError) {
        return Container(
          child: Center(
            child: Column(
              children: [
                Text('Materials loading error'),
                SizedBox(
                  height: Get.width * 0.06,
                ),
                Text(state.errorMsg),
                SizedBox(
                  height: Get.width * 0.06,
                ),
                GestureDetector(
                  onTap: () => materialsCatalogController.loadCatalog(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(Get.width * 0.06)),
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: Get.width * 0.03),
                    child: Text('try again'.tr),
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
