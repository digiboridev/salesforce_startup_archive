import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/data/models/sync_data.dart';
import 'package:salesforce.startup/domain/entities/materials/alternative_item.dart';
import 'package:salesforce.startup/domain/entities/materials/material.dart';
import 'package:salesforce.startup/domain/services/cache_fetching_service.dart';
import 'package:salesforce.startup/domain/services/connections_service.dart';
import 'package:salesforce.startup/domain/services/image_caching_service.dart';
import 'package:salesforce.startup/domain/usecases/materials/get_materials_sync_data.dart';
import 'package:salesforce.startup/domain/usecases/materials/subscribe_to_material.dart';
import 'package:salesforce.startup/presentation/controllers/materials_catalog_states.dart';
import 'package:salesforce.startup/presentation/ui/widgets/dialogs/info_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:salesforce.startup/domain/entities/materials/materials_catalog.dart';
import 'package:salesforce.startup/domain/usecases/materials/get_materials_and_cache.dart';
import 'package:salesforce.startup/presentation/controllers/customer_controller.dart';

class MaterialsCatalogController extends GetxController {
  // Dependency
  CustomerController _customerController = Get.find();
  CacheFetchingService _cacheFetchingService = Get.find();
  ImageCachingService _imageCachingService = Get.find();
  ConnectionService _connectionService = Get.find();

  // usecases
  GetMaterialsAndCache _getMaterialsAndCache = Get.find();
  GetMaterialsSyncData _getMaterialsSyncData = Get.find();
  SubscribeToMaterial _subscribeToMaterial = Get.find();

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

  // Perform full load with loading states
  // Uses for initial loading, or auth changes
  Future loadCatalog() async {
    if (_customerController.selectedCustomerSAP == null) {
      materialsCatalogState.value = MCSInitial();
      return;
    }

    materialsCatalogState.value = MCSLoading();

    // delay to force context refresh on momentary load
    await Future.delayed(Duration(milliseconds: 10));

    try {
      // Load catalog data
      MaterialsCatalog catalog = await _getMaterialsAndCache.call(GetMaterialsAndCacheParams(
        customerSAP: _customerController.selectedCustomerSAP!,
        hasConnection: _connectionService.hasConnection,
        locale: Get.locale!.languageCode,
      ));
      // emmit state
      materialsCatalogState.value = MCSCommon(catalog: catalog);

      // Register in cache fetching service
      CacheUpdateEvent cacheUpdateEvent = CacheUpdateEvent(tag: 'catalog', updateActionCallback: updateCatalog, lastUpdateTimeCallback: getLastSync);
      _cacheFetchingService.registerEvent(cacheUpdateEvent: cacheUpdateEvent);

      // Perform images caching
      _imageCachingService.cacheBunch(uris: [
        ...catalog.brands.map((e) => Uri.parse(e.ImageUrl)),
        ...catalog.families.map((e) => Uri.parse(e.ImageUrl)),
        ...catalog.materials.map((e) => Uri.parse(e.ImageUrl))
      ]);
    } catch (e) {
      print('Load catalog error' + e.toString());
      materialsCatalogState.value = MCSLoadingError(errorMsg: 'Load catalog error' + e.toString());

      Get.bottomSheet(
        WillPopScope(
          onWillPop: () async => false,
          child: InfoBottomSheet(
              headerText: 'Error while load catalog',
              mainText: e.toString(),
              actions: [
                InfoAction(
                    text: 'Retry',
                    callback: () {
                      Get.back();
                      loadCatalog();
                    })
              ],
              headerIconPath: AssetImages.info),
        ),
        isDismissible: false,
      );
    }
  }

  // Perform only update of data, without side states
  Future updateCatalog() async {
    try {
      MaterialsCatalog catalog = await _getMaterialsAndCache.call(GetMaterialsAndCacheParams(
        customerSAP: _customerController.selectedCustomerSAP!,
        hasConnection: _connectionService.hasConnection,
        locale: Get.locale!.languageCode,
      ));
      materialsCatalogState.value = MCSCommon(catalog: catalog);
    } catch (e) {
      print('Update catalog error' + e.toString());
    }
  }

  Future<DateTime> getLastSync() async {
    SyncData syncData = await _getMaterialsSyncData.call(_customerController.selectedCustomerSAP!);
    return syncData.syncDateTime;
  }

  List<Materiale> getAlternativeMaterials({required List<AlternativeItem> altItems}) {
    MaterialsCatalogState state = materialsCatalogState.value;
    if (state is MCSCommon) {
      // List<String> asd = state.catalog.materials.map((e) => e.SFId).toList();
      // List<String> asd2 = altItems.map((e) => e.SFId).toList();

      // print('asd');

      return state.catalog.materials.where((element) => altItems.map((e) => e.SFId).contains(element.SFId)).toList();
    } else {
      throw Exception('Operation denied');
    }
  }

  Future subscribeToMaterial({required Materiale material}) async {
    if (_connectionService.hasConnection) {
      try {
        await _subscribeToMaterial
            .call(SubscribeToMaterialParams(customerSAP: _customerController.selectedCustomerSAP!, materialNumber: material.MaterialNumber));
        material.didSubscribedToInventoryAlert.value = true;
      } catch (e) {
        Get.bottomSheet(InfoBottomSheet(
            headerText: 'Error'.tr, mainText: e.toString(), actions: [InfoAction(text: 'Ok', callback: () => Get.back())], headerIconPath: AssetImages.info));
      }
    } else {
      // Get.snackbar('Error', 'Restricted for offline mode'.tr);
      Get.bottomSheet(InfoBottomSheet(
          headerText: 'No internet connection',
          mainText: 'This action is rescticted for offline mode',
          actions: [InfoAction(text: 'Ok', callback: () => Get.back())],
          headerIconPath: AssetImages.info));
    }
  }
}
