import 'package:***REMOVED***/data/datasouces/customers_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/customers_remote_datasource.dart';
import 'package:***REMOVED***/data/models/customer_model.dart';
import 'package:***REMOVED***/domain/entities/customer.dart';

abstract class CustomersRepository {
  Future<String> getSelectedCustomerSAP({required String userId});
  Future setSelectedCustomerSAP(
      {required String userId, required String customerSAP});
  Future<Customer> getRemoteCustomerBySAP({required String customerSAP});
  Future<Customer> getLocalCustomerBySAP({required String customerSAP});
  Future setLocalCustomerBySAP(
      {required String customerSAP, required Customer customer});
  // Future<void> setCustomersListToCache(
  //     {required String userId, required List<Customer> customers});
  // Future<List<Customer>> getCustomersListFromCache({required String userId});
}

class CustomersRepositoryImpl implements CustomersRepository {
  final CustomersLocalDatasource customersLocalDatasource;
  final CustomersRemoteDatasource customersRemoteDatasource;

  CustomersRepositoryImpl({
    required this.customersLocalDatasource,
    required this.customersRemoteDatasource,
  });

  @override
  Future<String> getSelectedCustomerSAP({required String userId}) =>
      customersLocalDatasource.getSelectedCustomerSAP(userId: userId);

  @override
  Future setSelectedCustomerSAP(
          {required String userId, required String customerSAP}) =>
      customersLocalDatasource.setSelectedCustomerSAP(
          userId: userId, customerSAP: customerSAP);

  Future<Customer> getRemoteCustomerBySAP({required String customerSAP}) =>
      customersRemoteDatasource.getCustomerBySAP(customerSAP: customerSAP);

  Future<Customer> getLocalCustomerBySAP({required String customerSAP}) =>
      customersLocalDatasource.getCustomerBySAP(customerSAP: customerSAP);

  Future setLocalCustomerBySAP(
          {required String customerSAP, required Customer customer}) =>
      customersLocalDatasource.setCustomer(
          customerSAP: customerSAP,
          customerModel: CustomerModel.fromEntity(customer));

  // Future<void> setCustomersListToCache(
  //         {required String userId, required List<Customer> customers}) =>
  //     customersLocalDatasource.setCustomersList(
  //         userId: userId,
  //         customers:
  //             customers.map((e) => CustomerModel.fromEntity(e)).toList());

  // Future<List<Customer>> getCustomersListFromCache({required String userId}) =>
  //     customersLocalDatasource.getCustomersList(userId: userId);
}
