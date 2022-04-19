import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetUserDataSyncTime implements UseCase<DateTime, String> {
  final UserDataRepository userDataRepository;

  GetUserDataSyncTime(this.userDataRepository);

  @override
  Future<DateTime> call(userId) async {
    try {
      DateTime d = await userDataRepository.getUserDataSyncTime(userId: userId);
      return d;
    } catch (e) {
      return DateTime(1994);
    }
  }
}
