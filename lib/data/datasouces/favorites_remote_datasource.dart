import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/core/errors.dart';
import 'package:salesforce/salesforce.dart';

abstract class FavoritesRemoteDatasource {}

class FavoritesRemoteDatasourceImpl implements FavoritesRemoteDatasource {
  Future getFavoritesList({required String customerSAP}) async {
    try {
      var response = await SalesforcePlugin.sendRequest(
        endPoint: ***REMOVED***Endpoint,
        path: '/favorite/$customerSAP',
        method: 'POST',
        payload: {"listName": "list name 1", "FavoriteItems": []},
      );
      print(response);
      // if (response['success']) {
      // } else {
      //   throw ServerException(response['errorMsg']);
      // }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
