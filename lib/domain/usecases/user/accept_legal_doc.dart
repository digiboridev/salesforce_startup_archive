import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class AcceptLegalDoc implements UseCase<void, NoParams> {
  final UserDataRepository userDataRepository;

  AcceptLegalDoc(this.userDataRepository);

  @override
  Future<void> call(NoParams noParams) async {
    return userDataRepository.acceptLegalDoc();
  }
}
