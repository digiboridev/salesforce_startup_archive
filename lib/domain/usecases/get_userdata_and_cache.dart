import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetUserDataAndCache implements UseCase<UserData, String> {
  final UserDataRepository userDataRepository;

  GetUserDataAndCache(this.userDataRepository);

  @override
  Future<UserData> call(userId) async {
    try {
      UserData remoteUserData = await userDataRepository.getRemoteUserData;

      userDataRepository.setLocalUserData(
          userId: userId, userData: remoteUserData);
      userDataRepository.setUserDataSyncTime(
          userId: userId, dateTime: DateTime.now());
      return remoteUserData;
    } catch (e) {
      return userDataRepository.getLocalUserData(userId: userId);
    }
  }
}
