import 'package:salesforce.startup/core/errors.dart';
import 'package:salesforce.startup/data/models/contact_us_data_model.dart';
import 'package:get_storage/get_storage.dart';

abstract class ContactUsLocalDatasource {
  Future<ContactUsataModel> get getContactUs;
  Future setContactUs({required ContactUsataModel contactUsataModel});
}

class ContactUsLocalDatasourceImpl implements ContactUsLocalDatasource {
  final box = GetStorage('ContactUsBox');

  @override
  Future<ContactUsataModel> get getContactUs async {
    String? data = box.read('contactus');

    if (data == null) {
      throw CacheException('No cached contactus data');
    }

    return ContactUsataModel.fromJson(data);
  }

  Future setContactUs({required ContactUsataModel contactUsataModel}) async {
    await box.write('contactus', contactUsataModel.toJson());
  }
}
