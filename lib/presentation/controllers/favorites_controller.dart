import 'package:***REMOVED***/domain/entities/favorites/favorite_list.dart';
import 'package:***REMOVED***/domain/services/cache_fetching_service.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/usecases/favorites/get_favorites_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/favorites/get_favorites_sync_time.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_states.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  // Dependency
  CustomerController _customerController = Get.find();
  CacheFetchingService _cacheFetchingService = Get.find();
  ConnectionService _connectionService = Get.find();

  // usecases
  GetFavoritesAndCache _getFavoritesAndCache = Get.find();
  GetFavoritesSyncTime _getFavoritesSyncTime = Get.find();

  // variables
  Rx<FavoritesState> _state = Rx(FSInitial());
  FavoritesState get state => _state.value;

  @override
  void onReady() {
    super.onReady();
    loadFavorites();
    // Listen to customer changes
    _customerController.selectedCustomerSAPStream.listen((String? customerSAP) {
      loadFavorites();
    });
  }

  Future loadFavorites() async {
    if (_customerController.selectedCustomerSAP == null) {
      _state.value = FSInitial();
      return;
    }

    _state.value = FSLoading();
    try {
      List<FavoriteList> favoriteLists = await _getFavoritesAndCache.call(
          GetFavoritesAndCacheParams(
              customerSAP: _customerController.selectedCustomerSAP!,
              hasConnection: _connectionService.hasConnection));

      _state.value = FSCommon(favoriteLists: favoriteLists);

      // Register in cache fetching service
      CacheUpdateEvent cacheUpdateEvent = CacheUpdateEvent(
          tag: 'catalog',
          updateActionCallback: updateFavorites,
          lastUpdateTimeCallback: getLastSync);
      _cacheFetchingService.registerEvent(cacheUpdateEvent: cacheUpdateEvent);
    } catch (e) {
      print('Load favorites error' + e.toString());
      _state.value =
          FSLoadingError(errorMsg: 'Load catalog error' + e.toString());
    }
  }

  Future updateFavorites() async {}

  Future<DateTime> getLastSync() async {
    return _getFavoritesSyncTime.call(_customerController.selectedCustomerSAP!);
  }
}
