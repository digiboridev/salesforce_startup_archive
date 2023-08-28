import 'package:salesforce.startup/data/repositories/contact_us_repository.dart';
import 'package:salesforce.startup/domain/entities/contact_us_data.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';

class GetContactusAndCache implements UseCase<ContactUsData, NoParams> {
  final ContactUsRepository contactUsRepository;

  GetContactusAndCache(this.contactUsRepository);

  @override
  Future<ContactUsData> call(params) async {
    try {
      ContactUsData remoteData = await contactUsRepository.getRemoteContactUs;

      contactUsRepository.setLocalContactUs(contactUsData: remoteData);
      return remoteData;
    } catch (e) {
      return contactUsRepository.getLocalContactUs;
    }
  }
}
