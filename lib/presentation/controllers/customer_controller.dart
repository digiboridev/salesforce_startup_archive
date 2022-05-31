import 'dart:async';
import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/data/models/sync_data.dart';
import 'package:***REMOVED***/domain/entities/customer.dart';
import 'package:***REMOVED***/domain/entities/related_consumer.dart';
import 'package:***REMOVED***/domain/services/cache_fetching_service.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/usecases/customer/get_customer_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/customer/get_customer_sync_data.dart';
import 'package:***REMOVED***/domain/usecases/customer/get_selected_customer_sap.dart';
import 'package:***REMOVED***/domain/usecases/customer/set_selected_customer_sap.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/default_dialog.dart';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/info_bottomsheet.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  // dependencies
  UserDataController _userDataController = Get.find();
  ConnectionService _connectionService = Get.find();
  CacheFetchingService _cacheFetchingService = Get.find();

  // Usecases
  GetSelectedCustomerSAP _getSelectedCustomerSAP = Get.find();
  SetSelectedCustomerSAP _setSelectedCustomerSAP = Get.find();
  GetCustomerAndCache _getCustomerAndCache = Get.find();
  GetCustomerSyncData _getCustomerSyncData = Get.find();

  // variables
  RxList<RelatedConsumer> _relatedConsumers = RxList();
  List<RelatedConsumer> get relatedConsumers => _relatedConsumers;

  RxnString _selectedCustomerSAP = RxnString();
  String? get selectedCustomerSAP => _selectedCustomerSAP.value;
  Stream<String?> get selectedCustomerSAPStream => _selectedCustomerSAP.stream;

  RxnString _customerLoadingError = RxnString();
  String? get customerLoadingError => _customerLoadingError.value;

  Rxn<Customer> _selectedCustomer = Rxn<Customer>();
  Customer? get selectedCustomer => _selectedCustomer.value;

  @override
  void onReady() {
    super.onReady();
    // Listen to user data
    handleUserDataState(
        userDataState: _userDataController.userDataStateStream.value);
    _userDataController.userDataStateStream
        .listen((event) => handleUserDataState(userDataState: event));
  }

  // Update all on user data change
  handleUserDataState({required UserDataState userDataState}) async {
    UserDataState uds = userDataState;
    if (uds is UserDataCommonState) {
      _relatedConsumers.value = uds.userData.relatedCustomers;
      loadCustomers();
    } else {
      // clear all data
      _relatedConsumers.clear();
      _selectedCustomer.value = null;
      _selectedCustomerSAP.value = null;
    }
  }

  // Load full customer data
  Future<void> loadCustomers() async {
    _customerLoadingError.value = null;
    try {
      // Get saved selection
      _selectedCustomerSAP.value = await _getSelectedCustomerSAP.call(
          GetSelectedCustomerSAPParams(
              userId: _userDataController.authData!.userId));

      // Select customer on first time or related list changes
      if (_selectedCustomerSAP.value is! String ||
          !_relatedConsumers
              .map((element) => element.customerSAPNumber)
              .contains(_selectedCustomerSAP.value)) {
        // select
        _selectedCustomerSAP.value = _relatedConsumers.first.customerSAPNumber;
        // save
        _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(
            userId: _userDataController.authData!.userId,
            customerSAP: _selectedCustomerSAP.value!));
      }

      // load data
      _selectedCustomer.value = await _getCustomerAndCache.call(
          GetCustomerAndCacheParams(
              customerSAP: _selectedCustomerSAP.value!,
              hasConnetrion: _connectionService.hasConnection,
              locale: Get.locale!.languageCode));

      // Register in cache fetching service
      CacheUpdateEvent cacheUpdateEvent = CacheUpdateEvent(
          tag: 'customer',
          updateActionCallback: updateCustomerData,
          lastUpdateTimeCallback: getLastSync);
      _cacheFetchingService.registerEvent(cacheUpdateEvent: cacheUpdateEvent);
    } catch (e) {
      _customerLoadingError.value = e.toString();
      print(e.toString());
      Get.bottomSheet(
        InfoBottomSheet(
            headerText: 'Error while load customer data',
            mainText: e.toString(),
            actions: [
              InfoAction(
                  text: 'Retry',
                  callback: () {
                    Get.back();
                    loadCustomers();
                  })
            ],
            headerIconPath: AssetImages.info),
        isDismissible: false,
      );
    }
  }

  Future<DateTime> getLastSync() async {
    SyncData syncData =
        await _getCustomerSyncData.call(_selectedCustomerSAP.value!);
    return syncData.syncDateTime;
  }

  Future updateCustomerData() async {
    try {
      Customer c = await _getCustomerAndCache.call(GetCustomerAndCacheParams(
          locale: Get.locale!.languageCode,
          customerSAP: _selectedCustomerSAP.value!,
          hasConnetrion: _connectionService.hasConnection));
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
      _selectedCustomer.value = await _getCustomerAndCache.call(
          GetCustomerAndCacheParams(
              locale: Get.locale!.languageCode,
              customerSAP: customerSAP,
              hasConnetrion: _connectionService.hasConnection));

      // Switch
      _selectedCustomerSAP.value = customerSAP;
      // save
      _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(
          userId: _userDataController.authData!.userId,
          customerSAP: _selectedCustomerSAP.value!));

      Get.until((route) => !Get.isDialogOpen!);
    } catch (e) {
      Get.until((route) => !Get.isDialogOpen!);
      // Get.snackbar('Error', e.toString());
      Get.bottomSheet(InfoBottomSheet(
          headerText: 'Error',
          mainText: e.toString(),
          actions: [InfoAction(text: 'Ok', callback: () => Get.back())],
          headerIconPath: AssetImages.info));
    }
  }
}
