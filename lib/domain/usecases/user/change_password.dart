import 'package:salesforce.startup/data/repositories/user_data_repository.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';

class ChangePassword implements UseCase<void, ChangePasswordParams> {
  final UserDataRepository userDataRepository;

  ChangePassword(this.userDataRepository);

  @override
  Future<void> call(params) async {
    return userDataRepository.changePassword(oldPass: params.oldPass, newPass: params.newPass);
  }
}

class ChangePasswordParams {
  final String oldPass;
  final String newPass;
  ChangePasswordParams({
    required this.oldPass,
    required this.newPass,
  });
}
