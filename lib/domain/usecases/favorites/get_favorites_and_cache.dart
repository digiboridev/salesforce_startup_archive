import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/repositories/favorites_repository.dart';
import 'package:***REMOVED***/domain/entities/favorites/favorite_list.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';

class GetFavoritesAndCache
    implements UseCase<List<FavoriteList>, GetFavoritesAndCacheParams> {
  final FavoritesRepository favoritesRepository;

  GetFavoritesAndCache(this.favoritesRepository);

  @override
  Future<List<FavoriteList>> call(GetFavoritesAndCacheParams params) async {
    if (params.hasConnection) {
      try {
        List<FavoriteList> remoteFavoriteLists = await favoritesRepository
            .getFavoritesListRemote(customerSAP: params.customerSAP);

        favoritesRepository.setFavoritesListsLocal(
            customerSAP: params.customerSAP,
            favoriteslists: remoteFavoriteLists);

        favoritesRepository.setFavoritesSyncTime(
            customerSAP: params.customerSAP, dateTime: DateTime.now());
        return remoteFavoriteLists;
      } catch (e) {
        return _loadCache(customerSAP: params.customerSAP);
      }
    } else {
      return _loadCache(customerSAP: params.customerSAP);
    }
  }

  Future<List<FavoriteList>> _loadCache({required String customerSAP}) async {
    if (await _cacheUpToDate(customerSAP: customerSAP)) {
      return favoritesRepository.getFavoritesListLocal(
          customerSAP: customerSAP);
    } else {
      throw InternalException(
          'Unable to load favorites list for consumer $customerSAP');
    }
  }

  Future<bool> _cacheUpToDate({required String customerSAP}) async {
    try {
      DateTime lastSync = await favoritesRepository.getFavoritesSyncTime(
          customerSAP: customerSAP);
      Duration diff = DateTime.now().difference(lastSync);

      if (diff.inMinutes < 30) {
        return true;
      }
    } catch (e) {
      print('No favorites list cache');
    }
    return false;
  }
}

class GetFavoritesAndCacheParams {
  final String customerSAP;
  final bool hasConnection;
  GetFavoritesAndCacheParams({
    required this.customerSAP,
    required this.hasConnection,
  });
}
