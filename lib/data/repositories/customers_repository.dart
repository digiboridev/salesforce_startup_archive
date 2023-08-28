import 'package:salesforce.startup/data/datasouces/customers_local_datasource.dart';
import 'package:salesforce.startup/data/datasouces/customers_remote_datasource.dart';
import 'package:salesforce.startup/data/models/customer_model.dart';
import 'package:salesforce.startup/data/models/sync_data.dart';
import 'package:salesforce.startup/domain/entities/customer.dart';

abstract class CustomersRepository {
  Future<String> getSelectedCustomerSAP({required String userId});

  Future setSelectedCustomerSAP({required String userId, required String customerSAP});

  Future<Customer> getRemoteCustomerBySAP({required String customerSAP});

  Future<Customer> getLocalCustomerBySAP({required String customerSAP});

  Future setLocalCustomerBySAP({required String customerSAP, required Customer customer});

  Future setCustomerSyncData({required String customerSAP, required SyncData syncData});

  Future<SyncData> getCustomerSyncData({required String customerSAP});
}

class CustomersRepositoryImpl implements CustomersRepository {
  final CustomersLocalDatasource customersLocalDatasource;
  final CustomersRemoteDatasource customersRemoteDatasource;

  CustomersRepositoryImpl({
    required this.customersLocalDatasource,
    required this.customersRemoteDatasource,
  });

  @override
  Future<String> getSelectedCustomerSAP({required String userId}) => customersLocalDatasource.getSelectedCustomerSAP(userId: userId);

  @override
  Future setSelectedCustomerSAP({required String userId, required String customerSAP}) =>
      customersLocalDatasource.setSelectedCustomerSAP(userId: userId, customerSAP: customerSAP);

  @override
  Future<Customer> getRemoteCustomerBySAP({required String customerSAP}) => customersRemoteDatasource.getCustomerBySAP(customerSAP: customerSAP);

  @override
  Future<Customer> getLocalCustomerBySAP({required String customerSAP}) => customersLocalDatasource.getCustomerBySAP(customerSAP: customerSAP);

  @override
  Future setLocalCustomerBySAP({required String customerSAP, required Customer customer}) =>
      customersLocalDatasource.setCustomer(customerSAP: customerSAP, customerModel: CustomerModel.fromEntity(customer));

  @override
  Future setCustomerSyncData({required String customerSAP, required SyncData syncData}) =>
      customersLocalDatasource.setCustomerSyncData(customerSAP: customerSAP, syncData: syncData);

  @override
  Future<SyncData> getCustomerSyncData({required String customerSAP}) => customersLocalDatasource.getCustomerSyncData(customerSAP: customerSAP);
}
