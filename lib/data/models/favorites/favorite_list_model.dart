import 'dart:convert';
import 'package:***REMOVED***/data/models/favorites/favorite_item_model.dart';
import 'package:***REMOVED***/domain/entities/favorites/favorite_list.dart';

class FavoriteListModel extends FavoriteList {
  @override
  final List<FavoriteItemModel> favoriteItems;

  FavoriteListModel({
    required String sFId,
    required String listName,
    required bool isAllList,
    required List<FavoriteItemModel> this.favoriteItems,
  }) : super(
            sFId: sFId,
            listName: listName,
            favoriteItems: favoriteItems,
            isAllList: isAllList);

  Map<String, dynamic> toMap() {
    return {
      'SFId': sFId,
      'listName': listName,
      'IsAllList': isAllList,
      'FavoriteItems': favoriteItems.map((x) => x.toMap()).toList(),
    };
  }

  factory FavoriteListModel.fromMap(Map<String, dynamic> map) {
    return FavoriteListModel(
      sFId: map['SFId'],
      listName: map['listName'],
      isAllList: map['IsAllList'],
      favoriteItems: List<FavoriteItemModel>.from(
          map['FavoriteItems']?.map((x) => FavoriteItemModel.fromMap(x)) ??
              const []),
    );
  }

  factory FavoriteListModel.fromEntity(FavoriteList favoriteList) {
    return FavoriteListModel(
      sFId: favoriteList.sFId,
      listName: favoriteList.listName,
      isAllList: favoriteList.isAllList,
      favoriteItems: favoriteList.favoriteItems
          .map((e) => FavoriteItemModel.fromEntity(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteListModel.fromJson(String source) =>
      FavoriteListModel.fromMap(json.decode(source));
}
