import 'package:***REMOVED***/domain/services/cache_ferchig_service.dart';
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
    load();
    // Listen to customer changes
    _customerController.selectedCustomerSAPStream.listen((String? customerSAP) {
      load();
    });
  }

  Future load() async {}
}
