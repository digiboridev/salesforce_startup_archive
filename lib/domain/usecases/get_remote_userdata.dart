import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetRemoteUserData implements UseCase<UserData, Null> {
  final UserDataRepository userDataRepository;

  GetRemoteUserData(this.userDataRepository);

  @override
  Future<UserData> call(noparams) async {
    return userDataRepository.getRemoteUserData;
  }
}
