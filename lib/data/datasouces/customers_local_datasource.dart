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
}

class CustomersLocalDatasourceImpl implements CustomersLocalDatasource {
  final sapBox = GetStorage('CustomerSAP');
  final customerBox = GetStorage('Customers');

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
    await customerBox.write(customerSAP, customerModel.toJson());
  }

  @override
  Future<CustomerModel> getCustomerBySAP({required String customerSAP}) async {
    String? data = customerBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No chached data for customer: $customerSAP');
    }

    return CustomerModel.fromJson(data);
  }
}
