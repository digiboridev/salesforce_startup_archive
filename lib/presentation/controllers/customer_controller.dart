import 'dart:async';
import 'package:***REMOVED***/domain/entities/customer.dart';
import 'package:***REMOVED***/domain/entities/related_consumer.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/usecases/get_customer_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/get_selected_customer_sap.dart';
import 'package:***REMOVED***/domain/usecases/set_selected_customer_sap.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  // dependencies
  UserDataController _userDataController = Get.find();
  ConnectionService _connectionService = Get.find();

  // Usecases
  GetSelectedCustomerSAP _getSelectedCustomerSAP = Get.find();
  SetSelectedCustomerSAP _setSelectedCustomerSAP = Get.find();
  GetCustomerAndCache _getCustomerAndCache = Get.find();

  // Any non autocloseable streams
  List<StreamSubscription> _subs = [];

  // variables
  RxList<RelatedConsumer> _relatedConsumers = RxList();
  List<RelatedConsumer> get relatedConsumers => _relatedConsumers;

  RxnString _selectedCustomerSAP = RxnString();
  String? get selectedCustomerSAP => _selectedCustomerSAP.value;

  Rxn<Customer> _selectedCustomer = Rxn<Customer>();
  Customer? get selectedCustomer => _selectedCustomer.value;

  RxnString _customerLoadingError = RxnString();
  String? get customerLoadingError => _customerLoadingError.value;

  @override
  void onReady() {
    super.onReady();
    print('Consumer controller ready');

    // Bind userData
    handleUserDataState(
        userDataState: _userDataController.userDataStateStream.value);
    StreamSubscription userDataSub = _userDataController.userDataStateStream
        .listen((event) => handleUserDataState(userDataState: event));

    _subs.add(userDataSub);
  }

  @override
  void onClose() {
    super.onClose();
    // Cancel all stream on dispose
    _subs.forEach((sub) => sub.cancel());
  }

  handleUserDataState({required UserDataState userDataState}) async {
    UserDataState uds = userDataState;

    if (uds is UserDataCommonState) {
      _relatedConsumers.value = uds.userData.relatedCustomers;

      // Load selected customer from cache
      // if not pick the first one

      _selectedCustomerSAP.value = await _getSelectedCustomerSAP
          .call(GetSelectedCustomerSAPParams(userId: uds.userData.sFUserId));

      if (_selectedCustomerSAP.value is! String) {
        _selectedCustomerSAP.value =
            uds.userData.relatedCustomers.first.customerSAPNumber;

        _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(
            userId: uds.userData.sFUserId,
            customerSAP: _selectedCustomerSAP.value!));
      }

      loadCustomer();
    } else {
      // clear all data
      _relatedConsumers.clear();
      _selectedCustomerSAP.value = null;
      _selectedCustomer.value = null;
    }
  }

  // Load full customer data
  Future<void> loadCustomer() async {
    _customerLoadingError.value = null;
    try {
      Customer c = await _getCustomerAndCache.call(
          GetCustomerAndCacheParams(customerSAP: _selectedCustomerSAP.value!));
      _selectedCustomer.value = c;
    } catch (e) {
      _customerLoadingError.value = e.toString();
      print(e.toString());
    }
  }

  Future<void> switchCustomer({required String customerSAP}) async {
    // Restrict on offline mode
    if (!_connectionService.hasConnection) {
      Get.snackbar('Error', 'Restricted operation for offline mode');
      return;
    }

    Get.defaultDialog(
        onWillPop: () async => false,
        title: '',
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: CircularProgressIndicator());

    try {
      Customer c = await _getCustomerAndCache
          .call(GetCustomerAndCacheParams(customerSAP: customerSAP));
      _selectedCustomer.value = c;
      _selectedCustomerSAP.value = customerSAP;
      await _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(
          userId: _userDataController.authData!.userId,
          customerSAP: _selectedCustomerSAP.value!));
      await 0.1.delay();
      Get.back();
    } catch (e) {
      await 0.1.delay();
      Get.back();
      await 0.1.delay();
      Get.snackbar('Error', e.toString());
    }
  }
}
