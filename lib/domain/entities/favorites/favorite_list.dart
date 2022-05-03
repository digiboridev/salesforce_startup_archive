import 'package:equatable/equatable.dart';

import 'package:***REMOVED***/domain/entities/favorites/favorite_item.dart';

class FavoriteList extends Equatable {
  final String sFId;
  final String listName;
  final bool isAllList;
  final List<FavoriteItem> favoriteItems;
  FavoriteList({
    required this.sFId,
    required this.listName,
    required this.favoriteItems,
    required this.isAllList,
  });

  @override
  List<Object> get props => [sFId, listName, isAllList, favoriteItems];

  @override
  String toString() {
    return 'FavoriteList(sFId: $sFId, listName: $listName, isAllList: $isAllList, favoriteItems: $favoriteItems)';
  }

  FavoriteList copyWith({
    String? sFId,
    String? listName,
    bool? isAllList,
    List<FavoriteItem>? favoriteItems,
  }) {
    return FavoriteList(
      sFId: sFId ?? this.sFId,
      listName: listName ?? this.listName,
      isAllList: isAllList ?? this.isAllList,
      favoriteItems: favoriteItems ?? this.favoriteItems,
    );
  }
}
