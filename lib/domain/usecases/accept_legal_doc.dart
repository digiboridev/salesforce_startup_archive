import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class AcceptLegalDoc implements UseCase<bool, Null> {
  final UserDataRepository userDataRepository;

  AcceptLegalDoc(this.userDataRepository);

  @override
  Future<bool> call(noparams) async {
    return userDataRepository.acceptLegalDoc();
  }
}
