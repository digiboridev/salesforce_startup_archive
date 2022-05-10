import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/customer_model.dart';
import 'package:get_storage/get_storage.dart';

abstract class CustomersLocalDatasource {
  Future<String> getSelectedCustomerSAP({required String userId});

  Future setSelectedCustomerSAP(
      {required String userId, required String customerSAP});

  Future setCustomer(
      {required String customerSAP, required CustomerModel customerModel});

  Future<CustomerModel> getCustomerBySAP({required String customerSAP});

  Future setCustomerSyncTime(
      {required String customerSAP, required DateTime dateTime});

  Future<DateTime> getCustomerSyncTime({required String customerSAP});
}

class CustomersLocalDatasourceImpl implements CustomersLocalDatasource {
  final customersBox = GetStorage('customers');
  final sapBox = GetStorage('customerSAP');
  final customerSyncBox = GetStorage('customersSyncBox');

  @override
  Future<String> getSelectedCustomerSAP({required String userId}) async {
    String? data = sapBox.read(userId);

    if (data == null) {
      throw CacheException('No selected consumer for user: $userId');
    }

    return data;
  }

  @override
  Future setSelectedCustomerSAP(
      {required String userId, required String customerSAP}) async {
    await sapBox.write(userId, customerSAP);
  }

  @override
  Future setCustomer(
      {required String customerSAP,
      required CustomerModel customerModel}) async {
    await customersBox.write(customerSAP, customerModel.toJson());
  }

  @override
  Future<CustomerModel> getCustomerBySAP({required String customerSAP}) async {
    String? data = customersBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No chached data for customer: $customerSAP');
    }

    return CustomerModel.fromJson(data);
  }

  @override
  Future setCustomerSyncTime(
      {required String customerSAP, required DateTime dateTime}) async {
    await customerSyncBox.write(customerSAP, dateTime.millisecondsSinceEpoch);
  }

  @override
  Future<DateTime> getCustomerSyncTime({required String customerSAP}) async {
    int? data = customerSyncBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No sync time for $customerSAP');
    }

    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
