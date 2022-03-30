import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/core/languages.dart';
import 'package:***REMOVED***/data/models/user_data_model.dart';
import 'package:salesforce/salesforce.dart';

abstract class UserDataRemoteDatasource {
  Future<UserDataModel> get getUserData;
  Future<void> acceptLegalDoc();
  Future<void> changeLanguage({required Languages lang});
  Future<void> changePassword(
      {required String oldPass, required String newPass});
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
      print(e);
      throw ServerException('Internal error');
    }
  }

  @override
  Future<void> acceptLegalDoc() async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
          endPoint: ***REMOVED***Endpoint,
          path: '/me/accept',
          method: 'POST',
          payload: {}) as Map<String, dynamic>;
      if (response['success']) {
        return;
      } else {
        throw ServerException(response['errorMsg']);
      }
    } catch (e) {
      throw ServerException('Internal error');
    }
  }

  @override
  Future<void> changeLanguage({required Languages lang}) async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
          endPoint: ***REMOVED***Endpoint,
          path: '/me/changeLang',
          method: 'POST',
          payload: {"langCode": lang.identifier}) as Map<String, dynamic>;
      if (response['success']) {
        return;
      } else {
        throw ServerException(response['errorMsg']);
      }
    } catch (e) {
      throw ServerException('Internal error');
    }
  }

  @override
  Future<void> changePassword(
      {required String oldPass, required String newPass}) async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
              endPoint: ***REMOVED***Endpoint,
              path: '/newPassword',
              method: 'POST',
              payload: {"newPassword": newPass, "oldPassword": oldPass})
          as Map<String, dynamic>;
      if (response['success']) {
        return;
      } else {
        throw ServerException(response['errorMsg']);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
