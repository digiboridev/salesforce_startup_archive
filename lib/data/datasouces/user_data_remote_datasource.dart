import 'package:***REMOVED***/data/models/user_data_model.dart';
import 'package:salesforce/salesforce.dart';

abstract class UserDataRemoteDatasource {
  Future<UserDataModel> get getUserData;
}

class UserDataRemoteDatasourceImpl implements UserDataRemoteDatasource {
  @override
  Future<UserDataModel> get getUserData async {
    Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
      endPoint: '***REMOVED***',
      path: '/me',
    ) as Map<String, dynamic>;

    if (response['success']) {
      return UserDataModel.fromMap(response['result']);
    } else {
      throw Exception(response['errorMsg']);
    }
  }
}
