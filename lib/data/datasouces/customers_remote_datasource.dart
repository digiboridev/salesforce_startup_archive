import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/customer_model.dart';
import 'package:flutter/services.dart';
import 'package:salesforce/salesforce.dart';

abstract class CustomersRemoteDatasource {}

class CustomersRemoteDatasourceImpl implements CustomersRemoteDatasource {
  Future<CustomerModel> getCustomerById({required String customerSAP}) async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
        endPoint: ***REMOVED***Endpoint,
        path: '/customer/$customerSAP',
      ) as Map<String, dynamic>;

      if (response['success']) {
        return CustomerModel.fromMap(response['result']);
      } else {
        throw ServerException(response['errorMsg']);
      }
    } on PlatformException catch (e) {
      throw ServerException(e.message ?? e.toString());
    }
  }
}
