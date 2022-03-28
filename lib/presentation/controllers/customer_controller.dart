import 'dart:async';

import 'package:***REMOVED***/data/datasouces/customers_remote_datasource.dart';
import 'package:***REMOVED***/data/models/customer_model.dart';
import 'package:***REMOVED***/domain/entities/related_consumer.dart';
import 'package:***REMOVED***/domain/usecases/get_selected_customer_sap.dart';
import 'package:***REMOVED***/domain/usecases/set_selected_customer_sap.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  // dependencies
  UserDataController _userDataController = Get.find();

  // Usecases
  GetSelectedCustomerSAP _getSelectedCustomerSAP = Get.find();
  SetSelectedCustomerSAP _setSelectedCustomerSAP = Get.find();

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

      String? selectedCustomerSap = await _getSelectedCustomerSAP
          .call(GetSelectedCustomerSAPParams(userId: uds.userData.sFUserId));
      // selectedCustomerSap = null;
      if (selectedCustomerSap is! String) {
        selectedCustomerSap =
            uds.userData.relatedCustomers.first.customerSAPNumber;
        _setSelectedCustomerSAP.call(SetSelectedCustomerSAPParams(
            userId: uds.userData.sFUserId, customerSAP: selectedCustomerSap));
      }

      loadCustomer(customerSAP: selectedCustomerSap);
    } else {
      // clear all data
      _relatedConsumers.clear();
    }
  }

  loadCustomer({required String customerSAP}) async {
    CustomerModel c = await CustomersRemoteDatasourceImpl()
        .getCustomerById(customerSAP: customerSAP);
    print(c);
  }
}
