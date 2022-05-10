import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/favorites/favorite_list_model.dart';
import 'package:salesforce/salesforce.dart';

abstract class FavoritesRemoteDatasource {
  Future<List<FavoriteListModel>> getFavoritesList(
      {required String customerSAP});
  Future addList(
      {required String customerSAP,
      required FavoriteListModel favoriteListModel});
}

class FavoritesRemoteDatasourceImpl implements FavoritesRemoteDatasource {
  Future addList(
      {required String customerSAP,
      required FavoriteListModel favoriteListModel}) async {
    var response = await SalesforcePlugin.sendRequest(
      endPoint: ***REMOVED***Endpoint,
      path: '/favorite/$customerSAP',
      method: 'POST',
      payload: favoriteListModel.toMap(),
    );

    if (response['success']) {
      return;
    } else {
      throw ServerException(response['errorMsg']);
    }
  }

  @override
  Future<List<FavoriteListModel>> getFavoritesList(
      {required String customerSAP}) async {
    var response = await SalesforcePlugin.sendRequest(
      endPoint: ***REMOVED***Endpoint,
      path: '/favorite/$customerSAP',
      method: 'GET',
    );

    if (response['success']) {
      List data = response['result'];
      List<FavoriteListModel> favoritesLists =
          data.map((e) => FavoriteListModel.fromMap(e)).toList();
      return favoritesLists;
    } else {
      throw ServerException(response['errorMsg']);
    }
  }
}
