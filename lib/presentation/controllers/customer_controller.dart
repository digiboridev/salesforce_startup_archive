import 'dart:async';
import 'package:***REMOVED***/domain/entities/customer.dart';
import 'package:***REMOVED***/domain/entities/related_consumer.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/usecases/get_customers_and_cache.dart';
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
  GetCustomersAndCache _getCustomersAndCache = Get.find();

  // Any non autocloseable streams
  List<StreamSubscription> _subs = [];

  // variables
  RxList<RelatedConsumer> _relatedConsumers = RxList();
  RxnString _selectedCustomerSAP = RxnString();

  RxList<Customer> _relatedConsumersEntities = RxList();
  List<Customer> get relatedConsumersEntities => _relatedConsumersEntities;

  RxnString _customerLoadingError = RxnString();
  String? get customerLoadingError => _customerLoadingError.value;

  Customer? get selectedCustomer => _relatedConsumersEntities.firstWhere(
        (element) => element.customerSAPNumber == _selectedCustomerSAP.value,
      );

  @override
  void onReady() {
    super.onReady();
    // Listen to user data
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

  // Update all on user data change
  handleUserDataState({required UserDataState userDataState}) async {
    UserDataState uds = userDataState;
    if (uds is UserDataCommonState) {
      _relatedConsumers.value = uds.userData.relatedCustomers;
      loadCustomers();
    } else {
      // clear all data
      _relatedConsumers.clear();
      _relatedConsumersEntities.clear();
      _selectedCustomerSAP.value = null;
    }
  }

  // Load full customer data
  Future<void> loadCustomers() async {
    _customerLoadingError.value = null;
    try {
      // Get all customers by related list
      List<Customer> c = await _getCustomersAndCache.call(
          GetCustomersAndCacheParams(
              customersSAP: _relatedConsumers
                  .map((element) => element.customerSAPNumber)
                  .toList(),
              userId: _userDataController.authData!.userId));
      _relatedConsumersEntities.value = c;

      // Get saved selection
      _selectedCustomerSAP.value = await _getSelectedCustomerSAP.call(
          GetSelectedCustomerSAPParams(
              userId: _userDataController.authData!.userId));

      // Select customer on first time or related list changes
      if (_selectedCustomerSAP.value is! String ||
          !c
              .map((element) => element.customerSAPNumber)
              .contains(_selectedCustomerSAP.value)) {
        // select
        _selectedCustomerSAP.value = c.first.customerSAPNumber;
        // save
        _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(
            userId: _userDataController.authData!.userId,
            customerSAP: _selectedCustomerSAP.value!));
      }
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

    try {
      // Switch
      _selectedCustomerSAP.value = customerSAP;
      // save
      _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(
          userId: _userDataController.authData!.userId,
          customerSAP: _selectedCustomerSAP.value!));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
