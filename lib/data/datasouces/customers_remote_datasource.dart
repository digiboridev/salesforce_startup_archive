import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/core/errors.dart';
import 'package:flutter/services.dart';
import 'package:salesforce/salesforce.dart';

abstract class CustomersRemoteDatasource {}

class CustomersRemoteDatasourceImpl implements CustomersRemoteDatasource {
  Future getCustomerById({required String customerId}) async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
        endPoint: ***REMOVED***Endpoint,
        path: '/customer/$customerId',
      ) as Map<String, dynamic>;

      if (response['success']) {
        // return UserDataModel.fromMap(response['result']);
      } else {
        throw ServerException(response['errorMsg']);
      }
    } on PlatformException catch (e) {
      print(e.message);
      throw ServerException(e.message ?? e.toString());
    }
  }
}
