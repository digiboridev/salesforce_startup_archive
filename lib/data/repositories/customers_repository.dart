import 'package:***REMOVED***/data/datasouces/customers_local_datasource.dart';

abstract class CustomersRepository {
  Future<String> getSelectedCustomerId({required String userId});
  Future setSelectedCustomerId(
      {required String userId, required String consumerId});
}

class CustomersRepositoryImpl implements CustomersRepository {
  final CustomersLocalDatasource customersLocalDatasource;

  CustomersRepositoryImpl({
    required this.customersLocalDatasource,
  });

  @override
  Future<String> getSelectedCustomerId({required String userId}) =>
      customersLocalDatasource.getSelectedCustomerId(userId: userId);

  @override
  Future setSelectedCustomerId(
          {required String userId, required String consumerId}) =>
      customersLocalDatasource.setSelectedCustomerId(
          userId: userId, consumerId: consumerId);
}
