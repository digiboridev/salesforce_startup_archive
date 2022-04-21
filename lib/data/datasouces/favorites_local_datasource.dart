import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/favorites/favorite_list_model.dart';
import 'package:get_storage/get_storage.dart';

abstract class FavoritesLocalDatasource {
  Future<List<FavoriteListModel>> getFavoritesLists(
      {required String customerSAP});

  Future setFavoritesLists(
      {required String customerSAP,
      required List<FavoriteListModel> favoriteslists});

  Future setFavoritesListsSyncTime(
      {required String customerSAP, required DateTime dateTime});

  Future<DateTime> getFavoritesListsSyncTime({required String customerSAP});
}

class FavoritesLocalDatasourceImpl implements FavoritesLocalDatasource {
  final favoritesBox = GetStorage('favoritesBox');
  final favoritesSyncBox = GetStorage('favoritesSyncBox');

  @override
  Future<List<FavoriteListModel>> getFavoritesLists(
      {required String customerSAP}) async {
    List? data = favoritesBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No cached favoriteslists for $customerSAP');
    }

    List<FavoriteListModel> favoritesLists =
        data.map((e) => FavoriteListModel.fromJson(e)).toList();
    return favoritesLists;
  }

  @override
  Future setFavoritesLists(
      {required String customerSAP,
      required List<FavoriteListModel> favoriteslists}) async {
    await favoritesBox.write(
        customerSAP, favoriteslists.map((e) => e.toJson()).toList());
  }

  @override
  Future setFavoritesListsSyncTime(
      {required String customerSAP, required DateTime dateTime}) async {
    await favoritesSyncBox.write(customerSAP, dateTime.millisecondsSinceEpoch);
  }

  @override
  Future<DateTime> getFavoritesListsSyncTime(
      {required String customerSAP}) async {
    int? data = favoritesSyncBox.read(customerSAP);

    if (data == null) {
      throw CacheException('No favoriteslists sync time for $customerSAP');
    }

    return DateTime.fromMillisecondsSinceEpoch(data);
  }
}
