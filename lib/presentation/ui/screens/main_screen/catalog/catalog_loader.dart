import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/presentation/controllers/materials_catalog_controller.dart';
import 'package:salesforce.startup/presentation/controllers/materials_catalog_states.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/catalog/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogLoader extends StatefulWidget {
  CatalogLoader({Key? key}) : super(key: key);

  @override
  State<CatalogLoader> createState() => _CatalogLoaderState();
}

class _CatalogLoaderState extends State<CatalogLoader> with AutomaticKeepAliveClientMixin {
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
      MaterialsCatalogState state = materialsCatalogController.materialsCatalogState.value;

      if (state is MCSCommon) {
        return CatalogPage(
          key: ObjectKey(state.catalog),
          materialsCatalog: state.catalog,
        );
      } else {
        return Container(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(Get.width * 0.06),
              alignment: Alignment.center,
              color: MyColors.white_F4F4F6,
              child: Image.asset(AssetImages.loading_circle),
            ),
          ),
        );
      }
    });
  }
}
