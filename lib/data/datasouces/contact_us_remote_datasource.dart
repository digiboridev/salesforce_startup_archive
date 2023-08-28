import 'package:salesforce.startup/core/constants.dart';
import 'package:salesforce.startup/core/errors.dart';
import 'package:salesforce.startup/data/models/contact_us_data_model.dart';
import 'package:salesforce/salesforce.dart';

abstract class ContactUsRemoteDatasource {
  Future<ContactUsataModel> get getContactUs;
}

class ContactUsRemoteDatasourceImpl implements ContactUsRemoteDatasource {
  @override
  Future<ContactUsataModel> get getContactUs async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
        endPoint: startupEndpoint,
        path: '/login/getContactUs',
      ) as Map<String, dynamic>;
      if (response['success']) {
        return ContactUsataModel.fromMap(response['result']);
      } else {
        throw ServerException(response['errorMsg']);
      }
    } catch (e) {
      print(e);
      throw ServerException('Connection error');
    }
  }
}
