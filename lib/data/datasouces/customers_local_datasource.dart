import 'dart:convert';

import 'package:***REMOVED***/data/models/sync_data.dart';
import 'package:get_storage/get_storage.dart';

import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/customer_model.dart';

abstract class CustomersLocalDatasource {
  Future<String> getSelectedCustomerSAP({required String userId});

  Future setSelectedCustomerSAP(
      {required String userId, required String customerSAP});

  Future setCustomer(
      {required String customerSAP, required CustomerModel customerModel});

  Future<CustomerModel> getCustomerBySAP({required String customerSAP});

  Future setCustomerSyncData({
    required String customerSAP,
    required SyncData syncData,
  });

  Future<SyncData> getCustomerSyncData({required String customerSAP});
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
  Future setCustomerSyncData({
    required String customerSAP,
    required SyncData syncData,
  }) async {
    await customerSyncBox.write(customerSAP, syncData.toJson());
  }

  @override
  Future<SyncData> getCustomerSyncData({required String customerSAP}) async {
    String? data = customerSyncBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No sync data for $customerSAP');
    }

    return SyncData.fromJson(data);
  }
}
