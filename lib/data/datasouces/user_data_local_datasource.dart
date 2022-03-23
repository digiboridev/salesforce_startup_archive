import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/user_data_model.dart';
import 'package:get_storage/get_storage.dart';

abstract class UserDataLocalDatasource {
  Future<UserDataModel> getUserData({required String userId});
  Future setUserData(
      {required String userId, required UserDataModel userDataModel});
}

class UserDataLocalDatasourceImpl implements UserDataLocalDatasource {
  final box = GetStorage('UserData');

  @override
  Future<UserDataModel> getUserData({required String userId}) async {
    Map<String, dynamic>? data = box.read(userId);

    if (data == null) {
      throw CacheException('No cached data for $userId');
    }

    return UserDataModel.fromMap(data);
  }

  Future setUserData(
      {required String userId, required UserDataModel userDataModel}) async {
    await box.write(userId, userDataModel.toMap());
  }
}
