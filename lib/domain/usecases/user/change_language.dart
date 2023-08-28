import 'package:salesforce.startup/core/languages.dart';
import 'package:salesforce.startup/data/repositories/user_data_repository.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';

class ChangeLanguage implements UseCase<void, ChangeLanguageParams> {
  final UserDataRepository userDataRepository;

  ChangeLanguage(this.userDataRepository);

  @override
  Future<void> call(ChangeLanguageParams params) async {
    return userDataRepository.changeLanguage(lang: params.lang);
  }
}

class ChangeLanguageParams {
  final Languages lang;
  ChangeLanguageParams({
    required this.lang,
  });
}
