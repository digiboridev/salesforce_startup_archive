import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/user_data_model.dart';
import 'package:get_storage/get_storage.dart';

abstract class UserDataLocalDatasource {
  Future<UserDataModel> getUserData({required String userId});
  Future setUserData(
      {required String userId, required UserDataModel userDataModel});
  Future setUserDataSyncTime(
      {required String userId, required DateTime dateTime});
  Future<DateTime> getUserDataSyncTime({required String userId});
}

class UserDataLocalDatasourceImpl implements UserDataLocalDatasource {
  final userDataBox = GetStorage('userDataBox');
  final syncBox = GetStorage('syncBox');

  @override
  Future<UserDataModel> getUserData({required String userId}) async {
    String? data = userDataBox.read(userId);

    if (data == null) {
      throw CacheException('No cached data for $userId');
    }

    return UserDataModel.fromJson(data);
  }

  @override
  Future setUserData(
      {required String userId, required UserDataModel userDataModel}) async {
    await userDataBox.write(userId, userDataModel.toJson());
  }

  @override
  Future setUserDataSyncTime(
      {required String userId, required DateTime dateTime}) async {
    await syncBox.write(userId, dateTime.millisecondsSinceEpoch);
  }

  @override
  Future<DateTime> getUserDataSyncTime({required String userId}) async {
    int? data = syncBox.read(userId);

    if (data == null) {
      throw CacheException('No sync time for $userId');
    }

    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
