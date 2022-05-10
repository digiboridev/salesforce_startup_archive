import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetUserDataAndCache
    implements UseCase<UserData, GetUserDataAndCacheParams> {
  final UserDataRepository userDataRepository;

  GetUserDataAndCache(this.userDataRepository);

  @override
  Future<UserData> call(GetUserDataAndCacheParams params) async {
    if (params.hasConnection) {
      try {
        UserData remoteUserData = await userDataRepository.getRemoteUserData;
        userDataRepository.setLocalUserData(
            userId: params.userId, userData: remoteUserData);
        userDataRepository.setUserDataSyncTime(
            userId: params.userId, dateTime: DateTime.now());

        return remoteUserData;
      } catch (e) {
        return _loadFromCache(userId: params.userId);
      }
    } else {
      return _loadFromCache(userId: params.userId);
    }
  }

  Future<UserData> _loadFromCache({required String userId}) async {
    if (await _cacheUpToDate(userId: userId)) {
      return userDataRepository.getLocalUserData(userId: userId);
    } else {
      throw InternalException('No connection and valid cache');
    }
  }

  Future<bool> _cacheUpToDate({required String userId}) async {
    try {
      DateTime lastSync =
          await userDataRepository.getUserDataSyncTime(userId: userId);
      Duration diff = DateTime.now().difference(lastSync);

      if (diff.inMinutes < 30) {
        return true;
      }
    } catch (e) {
      print('No user data cache');
    }
    return false;
  }
}

class GetUserDataAndCacheParams {
  final String userId;
  final bool hasConnection;
  GetUserDataAndCacheParams({
    required this.userId,
    required this.hasConnection,
  });
}
