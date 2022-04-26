import 'dart:io';

import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/data/models/auth_data_model.dart';
import 'package:***REMOVED***/domain/entities/auth_data.dart';

import 'package:salesforce/salesforce.dart';

class SFSDKService {
  Future<AuthData?> get authData async {
    try {
      Map<String, dynamic> asd =
          await SalesforcePlugin.getAuthCredentials() as Map<String, dynamic>;
      AuthData authData = AuthDataModel.fromMap(asd);
      return authData;
    } catch (e) {
      return null;
    }
  }

  Future checkVersion() async {
    String platform = '';
    if (Platform.isAndroid) {
      platform = 'Android';
    } else if (Platform.isIOS) {
      platform = 'Ios';
    } else {
      throw Exception('Unsupported platform');
    }

    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
        endPoint: ***REMOVED***,
        path: '/DiplomatAppVersion/V2/Android',
        method: 'GET',
      ) as Map<String, dynamic>;
      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() => SalesforcePlugin.logoutCurrentUser();

  Stream get authEventStream => SalesforcePlugin.authChannelStream;
}
