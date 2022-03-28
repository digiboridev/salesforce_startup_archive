import 'package:***REMOVED***/core/errors.dart';
import 'package:get_storage/get_storage.dart';

abstract class CustomersLocalDatasource {
  Future<String> getSelectedCustomerId({required String userId});
  Future setSelectedCustomerId(
      {required String userId, required String consumerId});
}

class CustomersLocalDatasourceImpl implements CustomersLocalDatasource {
  final box = GetStorage('Customers');

  @override
  Future<String> getSelectedCustomerId({required String userId}) async {
    String? data = box.read(userId);

    if (data == null) {
      throw CacheException('No selected consumer for user: $userId');
    }

    return data;
  }

  Future setSelectedCustomerId(
      {required String userId, required String consumerId}) async {
    await box.write(userId, consumerId);
  }
}
