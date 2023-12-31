import 'dart:async';
import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/data/models/sync_data.dart';
import 'package:salesforce.startup/domain/entities/customer.dart';
import 'package:salesforce.startup/domain/entities/related_consumer.dart';
import 'package:salesforce.startup/domain/entities/user_data.dart';
import 'package:salesforce.startup/domain/services/cache_fetching_service.dart';
import 'package:salesforce.startup/domain/services/connections_service.dart';
import 'package:salesforce.startup/domain/services/location_service.dart';
import 'package:salesforce.startup/domain/usecases/customer/get_customer_and_cache.dart';
import 'package:salesforce.startup/domain/usecases/customer/get_customer_sync_data.dart';
import 'package:salesforce.startup/domain/usecases/customer/get_selected_customer_sap.dart';
import 'package:salesforce.startup/domain/usecases/customer/set_selected_customer_sap.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller_states.dart';
import 'package:salesforce.startup/presentation/ui/widgets/dialogs/default_dialog.dart';
import 'package:salesforce.startup/presentation/ui/widgets/dialogs/info_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  // dependencies
  UserDataController _userDataController = Get.find();
  ConnectionService _connectionService = Get.find();
  CacheFetchingService _cacheFetchingService = Get.find();
  LocationService _locationService = Get.find();

  // Usecases
  GetSelectedCustomerSAP _getSelectedCustomerSAP = Get.find();
  SetSelectedCustomerSAP _setSelectedCustomerSAP = Get.find();
  GetCustomerAndCache _getCustomerAndCache = Get.find();
  GetCustomerSyncData _getCustomerSyncData = Get.find();

  // variables
  RxList<RelatedConsumer> _relatedConsumers = RxList();
  List<RelatedConsumer> get relatedConsumers => _relatedConsumers;

  Rxn<RelatedConsumer> _closestRelatedConsumer = Rxn();
  RelatedConsumer? get closestRelatedConsumer => _closestRelatedConsumer.value;

  RxnString _selectedCustomerSAP = RxnString();
  String? get selectedCustomerSAP => _selectedCustomerSAP.value;
  Stream<String?> get selectedCustomerSAPStream => _selectedCustomerSAP.stream;

  // RxnString _customerLoadingError = RxnString();
  // String? get customerLoadingError => _customerLoadingError.value;

  Rxn<Customer> _selectedCustomer = Rxn<Customer>();
  Customer? get selectedCustomer => _selectedCustomer.value;

  @override
  void onReady() {
    super.onReady();
    // Listen to user data
    handleUserDataState(userDataState: _userDataController.userDataState);
    _userDataController.userDataStateStream.listen((event) => handleUserDataState(userDataState: event));
  }

  // Update all on user data change
  handleUserDataState({required UserDataState userDataState}) async {
    UserDataState uds = userDataState;
    if (uds is UserDataCommonState) {
      _relatedConsumers.value = uds.userData.relatedCustomers;
      try {
        await _locationService.getUserPosition();
      } catch (e) {
        print('Location determine error: ' + e.toString());
      }
      loadCustomers(userData: uds.userData);
    } else {
      // clear all data
      _relatedConsumers.clear();
      _selectedCustomer.value = null;
      _selectedCustomerSAP.value = null;
      _closestRelatedConsumer.value = null;
    }
  }

  // Load full customer data
  Future<void> loadCustomers({required UserData userData}) async {
    // _customerLoadingError.value = null;

    // Determine closest consumer
    if (_locationService.lastPosition is Position) {
      _closestRelatedConsumer.value =
          userData.closestRelatedCustomer(lattitude: _locationService.lastPosition!.latitude, longtitude: _locationService.lastPosition!.longitude);
    }

    try {
      // Get saved selection
      _selectedCustomerSAP.value = await _getSelectedCustomerSAP.call(GetSelectedCustomerSAPParams(userId: _userDataController.authData!.userId));

      // Select customer durning first time or related list changes
      if (_selectedCustomerSAP.value is! String ||
          !userData.relatedCustomers.map((element) => element.customerSAPNumber).contains(_selectedCustomerSAP.value)) {
        // select closest if possible, if not select first one
        _selectedCustomerSAP.value = closestRelatedConsumer?.customerSAPNumber ?? userData.relatedCustomers.first.customerSAPNumber;

        // save selected customer
        _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(userId: _userDataController.authData!.userId, customerSAP: _selectedCustomerSAP.value!));
      }

      // load data
      _selectedCustomer.value = await _getCustomerAndCache.call(GetCustomerAndCacheParams(
          customerSAP: _selectedCustomerSAP.value!, hasConnetrion: _connectionService.hasConnection, locale: Get.locale!.languageCode));

      // Register in cache fetching service
      CacheUpdateEvent cacheUpdateEvent = CacheUpdateEvent(tag: 'customer', updateActionCallback: updateCustomerData, lastUpdateTimeCallback: getLastSync);
      _cacheFetchingService.registerEvent(cacheUpdateEvent: cacheUpdateEvent);
    } catch (e) {
      // _customerLoadingError.value = e.toString();
      print(e.toString());

      // Show error popup with retry
      Get.bottomSheet(
        WillPopScope(
          onWillPop: () async => false,
          child: InfoBottomSheet(
              headerText: 'Error while load customer data',
              mainText: e.toString(),
              actions: [
                InfoAction(
                    text: 'Retry',
                    callback: () {
                      Get.back();
                      loadCustomers(userData: userData);
                    })
              ],
              headerIconPath: AssetImages.info),
        ),
        isDismissible: false,
      );
    }
  }

  Future<DateTime> getLastSync() async {
    SyncData syncData = await _getCustomerSyncData.call(_selectedCustomerSAP.value!);
    return syncData.syncDateTime;
  }

  Future updateCustomerData() async {
    try {
      Customer c = await _getCustomerAndCache.call(GetCustomerAndCacheParams(
          locale: Get.locale!.languageCode, customerSAP: _selectedCustomerSAP.value!, hasConnetrion: _connectionService.hasConnection));
      _selectedCustomer.value = c;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> switchCustomer({required String customerSAP}) async {
    // Restrict on offline mode
    if (!_connectionService.hasConnection) {
      // Get.snackbar('Error', 'Restricted operation for offline mode');
      Get.bottomSheet(InfoBottomSheet(
          headerText: 'No internet connection',
          mainText: 'This action is rescticted for offline mode',
          actions: [InfoAction(text: 'Ok', callback: () => Get.back())],
          headerIconPath: AssetImages.info));
      return;
    }

    try {
      // Show loading dialog
      defaultDialog();

      // load data
      _selectedCustomer.value = await _getCustomerAndCache
          .call(GetCustomerAndCacheParams(locale: Get.locale!.languageCode, customerSAP: customerSAP, hasConnetrion: _connectionService.hasConnection));

      // Switch
      _selectedCustomerSAP.value = customerSAP;
      // save
      _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(userId: _userDataController.authData!.userId, customerSAP: _selectedCustomerSAP.value!));

      Get.until((route) => !Get.isDialogOpen!);
    } catch (e) {
      Get.until((route) => !Get.isDialogOpen!);
      // Get.snackbar('Error', e.toString());
      Get.bottomSheet(InfoBottomSheet(
          headerText: 'Error'.tr, mainText: e.toString(), actions: [InfoAction(text: 'Ok', callback: () => Get.back())], headerIconPath: AssetImages.info));
    }
  }
}
