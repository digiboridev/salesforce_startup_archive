import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/presentation/controllers/favorites_controller.dart';
import 'package:salesforce.startup/presentation/controllers/favorites_states.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/favorites/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesLoader extends StatefulWidget {
  FavoritesLoader({Key? key}) : super(key: key);

  @override
  State<FavoritesLoader> createState() => _FavoritesLoaderState();
}

class _FavoritesLoaderState extends State<FavoritesLoader> with AutomaticKeepAliveClientMixin {
  final FavoritesController favoritesController = Get.find();

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
      FavoritesState state = favoritesController.state;

      if (state is FSCommon) {
        return FavoritesPage(
            // favoriteLists: state.favoriteLists,
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
