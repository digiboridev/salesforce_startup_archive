import 'package:***REMOVED***/domain/entities/favorites/favorite_item.dart';
import 'package:***REMOVED***/domain/entities/favorites/favorite_list.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/unit_types.dart';
import 'package:***REMOVED***/domain/services/cache_fetching_service.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/usecases/favorites/get_favorites_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/favorites/get_favorites_sync_time.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/favorites/belogn_list.dart';
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
      // CacheUpdateEvent cacheUpdateEvent = CacheUpdateEvent(
      //     tag: 'catalog',
      //     updateActionCallback: updateFavorites,
      //     lastUpdateTimeCallback: getLastSync);
      // _cacheFetchingService.registerEvent(cacheUpdateEvent: cacheUpdateEvent);
    } catch (e) {
      print('Load favorites error' + e.toString());
      _state.value =
          FSLoadingError(errorMsg: 'Load catalog error' + e.toString());
    }
  }

  // Future updateFavorites() async {}

  Future<DateTime> getLastSync() async {
    return _getFavoritesSyncTime.call(_customerController.selectedCustomerSAP!);
  }

  // changeData({required List<FavoriteList> favoriteLists}) {
  //   if (state is FSCommon) {
  //     _state.value = FSCommon(favoriteLists: favoriteLists);
  //   } else {
  //     Get.snackbar('Error', 'Favorites not ready');
  //   }
  // }
  bool isMaterialInFavorite({required Materiale material}) {
    FavoritesState s = state;

    if (s is FSCommon) {
      for (FavoriteList fl in s.favoriteLists) {
        for (FavoriteItem fi in fl.favoriteItems) {
          if (fi.materialNumber == material.MaterialNumber) {
            return true;
          }
        }
      }
    }
    return false;
  }

  addNewBlancList({required String listName}) {
    FavoritesState s = state;

    if (s is FSCommon) {
      List<FavoriteList> currentLists = List<FavoriteList>.of(s.favoriteLists);

      currentLists.add(FavoriteList(
          favoriteItems: [], listName: listName, sFId: '', isAllList: false));

      _state.value = FSCommon(favoriteLists: currentLists);
    } else {
      Get.snackbar('Error', 'Favorites not ready');
    }
  }

  addItemToAllList({required Materiale material}) {
    FavoritesState s = state;

    if (s is FSCommon) {
      List<FavoriteList> currentLists = List<FavoriteList>.of(s.favoriteLists);

      int indexAllList =
          currentLists.indexWhere((element) => element.isAllList);

      if (indexAllList != -1) {
        FavoriteList allList = currentLists.elementAt(indexAllList);

        FavoriteList newallList = allList.copyWith(
          favoriteItems: List<FavoriteItem>.of(allList.favoriteItems)
            ..add(
              FavoriteItem(
                  materialNumber: material.MaterialNumber,
                  sFId: material.SFId,
                  unit: material.SalesUnit,
                  quantity: material.MinimumOrderQuantity),
            ),
        );
        currentLists[indexAllList] = newallList;
      }

      _state.value = FSCommon(favoriteLists: currentLists);
    } else {
      Get.snackbar('Error', 'Favorites not ready');
    }
  }

  changeItemInList(
      {required String listId,
      required String materialNumber,
      required int count,
      required UnitType unitType}) {
    FavoritesState s = state;

    if (s is FSCommon) {
      List<FavoriteList> currentLists = List<FavoriteList>.of(s.favoriteLists);

      int index = currentLists.indexWhere((element) => element.sFId == listId);

      if (index != -1) {
        FavoriteList list = currentLists.elementAt(index);

        List<FavoriteItem> items = List<FavoriteItem>.of(list.favoriteItems);

        items[
            items.indexWhere(
                (element) => element.materialNumber == materialNumber)] = items
            .firstWhere((element) => element.materialNumber == materialNumber)
            .copyWith(quantity: count, unit: unitType.salesUnitString);

        FavoriteList newaList = list.copyWith(
          favoriteItems: items,
        );
        currentLists[index] = newaList;
      }
      print(_state.value == FSCommon(favoriteLists: currentLists));
      print('asd');
      _state.value = FSCommon(favoriteLists: currentLists);
    } else {
      Get.snackbar('Error', 'Favorites not ready');
    }
  }

  Future showBelongEdit({required Materiale material}) async {
    FavoritesState s = state;
    if (s is FSCommon) {
      List<FavoriteList>? editedFavList = await Get.bottomSheet(BelongList(
        favoriteLists: s.favoriteLists,
        material: material,
      ));

      if (editedFavList is List<FavoriteList>) {
        // TODO send to api then update
        _state.value = FSCommon(favoriteLists: editedFavList);
      }
    }
  }
}
