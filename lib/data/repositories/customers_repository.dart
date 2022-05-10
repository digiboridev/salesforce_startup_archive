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

  Future setCustomerSyncTime(
      {required String customerSAP, required DateTime dateTime});

  Future<DateTime> getCustomerSyncTime({required String customerSAP});
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

  @override
  Future<Customer> getRemoteCustomerBySAP({required String customerSAP}) =>
      customersRemoteDatasource.getCustomerBySAP(customerSAP: customerSAP);

  @override
  Future<Customer> getLocalCustomerBySAP({required String customerSAP}) =>
      customersLocalDatasource.getCustomerBySAP(customerSAP: customerSAP);

  @override
  Future setLocalCustomerBySAP(
          {required String customerSAP, required Customer customer}) =>
      customersLocalDatasource.setCustomer(
          customerSAP: customerSAP,
          customerModel: CustomerModel.fromEntity(customer));

  @override
  Future setCustomerSyncTime(
          {required String customerSAP, required DateTime dateTime}) =>
      customersLocalDatasource.setCustomerSyncTime(
          customerSAP: customerSAP, dateTime: dateTime);

  @override
  Future<DateTime> getCustomerSyncTime({required String customerSAP}) =>
      customersLocalDatasource.getCustomerSyncTime(customerSAP: customerSAP);
}
