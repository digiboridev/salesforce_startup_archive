import 'package:equatable/equatable.dart';
import 'package:***REMOVED***/domain/entities/favorites/favorite_item.dart';

class FavoriteList extends Equatable {
  final String sFId;
  final String listName;
  final List<FavoriteItem> favoriteItems;
  FavoriteList({
    required this.sFId,
    required this.listName,
    required this.favoriteItems,
  });

  @override
  List<Object> get props => [sFId, listName, favoriteItems];

  @override
  String toString() =>
      'FavoriteList(sFId: $sFId, listName: $listName, favoriteItems: $favoriteItems)';
}
