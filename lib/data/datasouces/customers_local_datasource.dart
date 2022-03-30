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

  // Future<void> setCustomersList(
  //     {required String userId, required List<CustomerModel> customers});

  // Future<List<CustomerModel>> getCustomersList({required String userId});
}

class CustomersLocalDatasourceImpl implements CustomersLocalDatasource {
  final sapBox = GetStorage('customerSAP');
  final customersBox = GetStorage('customers');

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

  // @override
  // Future<void> setCustomersList(
  //     {required String userId, required List<CustomerModel> customers}) async {
  //   await customersBox.write(userId, customers.map((e) => e.toJson()).toList());
  // }

  // @override
  // Future<List<CustomerModel>> getCustomersList({required String userId}) async {
  //   List? data = customersBox.read(userId);

  //   if (data == null) {
  //     throw CacheException('No chached cuctomers for: $userId');
  //   }

  //   return data.map((e) => CustomerModel.fromJson(e)).toList();
  // }
}
