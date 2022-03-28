import 'dart:async';

import 'package:***REMOVED***/data/datasouces/customers_remote_datasource.dart';
import 'package:***REMOVED***/domain/entities/related_consumer.dart';
import 'package:***REMOVED***/domain/usecases/get_selected_customer_id.dart';
import 'package:***REMOVED***/domain/usecases/set_selected_customer_id.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  // dependencies
  UserDataController _userDataController = Get.find();

  // Usecases
  GetSelectedCustomerId _getSelectedCustomerId = Get.find();
  SetSelectedCustomerId _setSelectedCustomerId = Get.find();

  // Any non autocloseable streams
  List<StreamSubscription> _subs = [];

  // variables
  RxList<RelatedConsumer> _relatedConsumers = RxList();

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

      String? selectedCustomerId = await _getSelectedCustomerId
          .call(GetSelectedCustomerIdParams(userId: uds.userData.sFUserId));

      if (selectedCustomerId is! String) {
        selectedCustomerId = uds.userData.relatedCustomers.first.customerId;
        _setSelectedCustomerId.call(SetSelectedCustomerIdParams(
            userId: uds.userData.sFUserId, customerId: selectedCustomerId));
      }

      loadCustomer(customerId: selectedCustomerId);
    } else {
      // clear all data
      _relatedConsumers.clear();
    }
  }

  loadCustomer({required String customerId}) async {
    print(DateTime.parse('2021-10-21'));
    try {
      await CustomersRemoteDatasourceImpl()
          .getCustomerById(customerId: customerId);
    } catch (e) {
      print(e);
    }
  }
}
