import 'package:salesforce.startup/data/datasouces/favorites_local_datasource.dart';
import 'package:salesforce.startup/data/datasouces/favorites_remote_datasource.dart';
import 'package:salesforce.startup/data/models/favorites/favorite_list_model.dart';
import 'package:salesforce.startup/domain/entities/favorites/favorite_list.dart';

abstract class FavoritesRepository {
  Future<List<FavoriteList>> getFavoritesListRemote({required String customerSAP});

  Future addListRemote({required String customerSAP, required FavoriteList favoriteList});

  Future<List<FavoriteList>> getFavoritesListLocal({required customerSAP});

  Future setFavoritesListsLocal({required String customerSAP, required List<FavoriteList> favoriteslists});

  Future<DateTime> getFavoritesSyncTime({required String customerSAP});

  Future setFavoritesSyncTime({required String customerSAP, required DateTime dateTime});
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDatasource favoritesRemoteDatasource;
  final FavoritesLocalDatasource favoritesLocalDatasource;
  FavoritesRepositoryImpl({
    required this.favoritesRemoteDatasource,
    required this.favoritesLocalDatasource,
  });

  @override
  Future<List<FavoriteList>> getFavoritesListRemote({required String customerSAP}) => favoritesRemoteDatasource.getFavoritesList(customerSAP: customerSAP);

  @override
  Future addListRemote({required String customerSAP, required FavoriteList favoriteList}) =>
      favoritesRemoteDatasource.addList(customerSAP: customerSAP, favoriteListModel: FavoriteListModel.fromEntity(favoriteList));

  @override
  Future<List<FavoriteList>> getFavoritesListLocal({required customerSAP}) => favoritesLocalDatasource.getFavoritesLists(customerSAP: customerSAP);

  @override
  Future setFavoritesListsLocal({required String customerSAP, required List<FavoriteList> favoriteslists}) =>
      favoritesLocalDatasource.setFavoritesLists(customerSAP: customerSAP, favoriteslists: favoriteslists.map((e) => FavoriteListModel.fromEntity(e)).toList());

  @override
  Future<DateTime> getFavoritesSyncTime({required String customerSAP}) => favoritesLocalDatasource.getFavoritesListsSyncTime(customerSAP: customerSAP);

  @override
  Future setFavoritesSyncTime({required String customerSAP, required DateTime dateTime}) =>
      favoritesLocalDatasource.setFavoritesListsSyncTime(customerSAP: customerSAP, dateTime: dateTime);
}
