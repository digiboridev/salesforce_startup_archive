import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/user_data_model.dart';
import 'package:salesforce/salesforce.dart';

abstract class UserDataRemoteDatasource {
  Future<UserDataModel> get getUserData;
  Future<bool> acceptLegalDoc();
}

class UserDataRemoteDatasourceImpl implements UserDataRemoteDatasource {
  @override
  Future<UserDataModel> get getUserData async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
        endPoint: ***REMOVED***Endpoint,
        path: '/me',
      ) as Map<String, dynamic>;

      if (response['success']) {
        return UserDataModel.fromMap(response['result']);
      } else {
        throw ServerException(response['errorMsg']);
      }
    } catch (e) {
      throw ServerException('Internal error');
    }
  }

  @override
  Future<bool> acceptLegalDoc() async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
          endPoint: ***REMOVED***Endpoint,
          path: '/me/accept',
          method: 'POST',
          payload: {}) as Map<String, dynamic>;
      if (response['success']) {
        return true;
      } else {
        throw ServerException(response['errorMsg']);
      }
    } catch (e) {
      throw ServerException('Internal error');
    }
  }
}
