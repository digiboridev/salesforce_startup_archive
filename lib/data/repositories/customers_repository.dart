import 'package:***REMOVED***/data/datasouces/customers_local_datasource.dart';

abstract class CustomersRepository {
  Future<String> getSelectedCustomerSAP({required String userId});
  Future setSelectedCustomerSAP(
      {required String userId, required String customerSAP});
}

class CustomersRepositoryImpl implements CustomersRepository {
  final CustomersLocalDatasource customersLocalDatasource;

  CustomersRepositoryImpl({
    required this.customersLocalDatasource,
  });

  @override
  Future<String> getSelectedCustomerSAP({required String userId}) =>
      customersLocalDatasource.getSelectedCustomerId(userId: userId);

  @override
  Future setSelectedCustomerSAP(
          {required String userId, required String customerSAP}) =>
      customersLocalDatasource.setSelectedCustomerId(
          userId: userId, consumerId: customerSAP);
}
