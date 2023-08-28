import 'package:salesforce/salesforce.dart';
import 'package:salesforce.startup/data/models/auth_data_model.dart';
import 'package:salesforce.startup/domain/entities/auth_data.dart';

class SFSDKService {
  Future<AuthData?> get authData async {
    try {
      Map<String, dynamic> asd = await SalesforcePlugin.getAuthCredentials() as Map<String, dynamic>;
      AuthData authData = AuthDataModel.fromMap(asd);
      return authData;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() => SalesforcePlugin.logoutCurrentUser();

  Stream get authEventStream => SalesforcePlugin.authChannelStream;
}
