import 'package:salesforce.startup/core/constants.dart';
import 'package:salesforce.startup/core/errors.dart';
import 'package:salesforce.startup/data/models/customer_model.dart';
import 'package:flutter/services.dart';
import 'package:salesforce/salesforce.dart';

abstract class CustomersRemoteDatasource {
  Future<CustomerModel> getCustomerBySAP({required String customerSAP});
}

class CustomersRemoteDatasourceImpl implements CustomersRemoteDatasource {
  Future<CustomerModel> getCustomerBySAP({required String customerSAP}) async {
    try {
      Map<String, dynamic> response = await SalesforcePlugin.sendRequest(
        endPoint: startupEndpoint,
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
