import 'package:***REMOVED***/domain/entities/materials/alternative_item.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/services/cache_ferchig_service.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/domain/usecases/materials/get_materials_sync_time.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:get/get.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/domain/usecases/materials/get_materials_and_cache.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';

class MaterialsCatalogController extends GetxController {
  // Dependency
  CustomerController _customerController = Get.find();
  CacheFetchingService _cacheFetchingService = Get.find();
  ImageCachingService _imageCachingService = Get.find();
  ConnectionService _connectionService = Get.find();

  // usecases
  GetMaterialsAndCache _getMaterialsAndCache = Get.find();
  GetMaterialsSyncTime _getMaterialsSyncTime = Get.find();

  // variables
  Rx<MaterialsCatalogState> materialsCatalogState = Rx(MCSInitial());

  @override
  void onReady() {
    super.onReady();
    loadCatalog();
    // Listen to customer changes
    _customerController.selectedCustomerSAPStream.listen((String? customerSAP) {
      loadCatalog();
    });
  }

  Future loadCatalog() async {
    if (_customerController.selectedCustomerSAP == null) {
      materialsCatalogState.value = MCSInitial();
      return;
    }

    materialsCatalogState.value = MCSLoading();
    try {
      MaterialsCatalog catalog = await _getMaterialsAndCache.call(
          GetMaterialsAndCacheParams(
              customerSAP: _customerController.selectedCustomerSAP!,
              hasConnection: _connectionService.hasConnection));
      materialsCatalogState.value = MCSCommon(catalog: catalog);

      // Register in cache fetching service
      CacheUpdateEvent cacheUpdateEvent = CacheUpdateEvent(
          tag: 'catalog',
          updateActionCallback: updateCatalog,
          lastUpdateTimeCallback: getLastSync);
      _cacheFetchingService.registerEvent(cacheUpdateEvent: cacheUpdateEvent);

      // Perform images caching
      _imageCachingService.cacheBunch(uris: [
        ...catalog.brands.map((e) => Uri.parse(e.ImageUrl)),
        ...catalog.families.map((e) => Uri.parse(e.ImageUrl)),
        ...catalog.materials.map((e) => Uri.parse(e.ImageUrl))
      ]);
    } catch (e) {
      print('Load catalog error' + e.toString());
      materialsCatalogState.value =
          MCSLoadingError(errorMsg: 'Load catalog error' + e.toString());
    }
  }

  Future updateCatalog() async {
    try {
      MaterialsCatalog catalog = await _getMaterialsAndCache.call(
          GetMaterialsAndCacheParams(
              customerSAP: _customerController.selectedCustomerSAP!,
              hasConnection: _connectionService.hasConnection));
      materialsCatalogState.value = MCSCommon(catalog: catalog);
    } catch (e) {
      print('Update catalog error' + e.toString());
    }
  }

  Future<DateTime> getLastSync() async {
    return _getMaterialsSyncTime.call(_customerController.selectedCustomerSAP!);
  }

  List<Materiale> getAlternativeMaterials(
      {required List<AlternativeItem> altItems}) {
    MaterialsCatalogState state = materialsCatalogState.value;
    if (state is MCSCommon) {
      return state.catalog.materials
          .where(
              (element) => altItems.map((e) => e.SFId).contains(element.SFId))
          .toList();
    } else {
      throw Exception('Operation denied');
    }
  }
}
