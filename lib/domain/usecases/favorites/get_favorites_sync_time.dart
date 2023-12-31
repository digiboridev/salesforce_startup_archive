import 'package:salesforce.startup/data/repositories/favorites_repository.dart';
import 'package:salesforce.startup/domain/usecases/usecase.dart';

class GetFavoritesSyncTime implements UseCase<DateTime, String> {
  final FavoritesRepository favoritesRepository;

  GetFavoritesSyncTime(this.favoritesRepository);

  @override
  Future<DateTime> call(customerSAP) async {
    try {
      DateTime d = await favoritesRepository.getFavoritesSyncTime(customerSAP: customerSAP);
      return d;
    } catch (e) {
      return DateTime(1994);
    }
  }
}
