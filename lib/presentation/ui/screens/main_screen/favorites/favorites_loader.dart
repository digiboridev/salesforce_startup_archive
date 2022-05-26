import 'package:***REMOVED***/presentation/controllers/favorites_controller.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/favorites/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesLoader extends StatefulWidget {
  FavoritesLoader({Key? key}) : super(key: key);

  @override
  State<FavoritesLoader> createState() => _FavoritesLoaderState();
}

class _FavoritesLoaderState extends State<FavoritesLoader>
    with AutomaticKeepAliveClientMixin {
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
      } else if (state is FSLoadingError) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Favorites loading error'.tr),
              SizedBox(
                height: Get.width * 0.06,
              ),
              Text(state.errorMsg),
              SizedBox(
                height: Get.width * 0.06,
              ),
              GestureDetector(
                onTap: () => favoritesController.loadFavorites(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(Get.width * 0.06)),
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.1, vertical: Get.width * 0.03),
                  child: Text('try again'.tr),
                ),
              )
            ],
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
