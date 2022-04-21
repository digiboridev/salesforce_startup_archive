import 'dart:convert';
import 'package:***REMOVED***/data/models/favorites/favorite_item_model.dart';
import 'package:***REMOVED***/domain/entities/favorites/favorite_list.dart';

class FavoriteListModel extends FavoriteList {
  @override
  final List<FavoriteItemModel> favoriteItems;

  FavoriteListModel(
      {required String sFId,
      required String listName,
      required List<FavoriteItemModel> this.favoriteItems})
      : super(sFId: sFId, listName: listName, favoriteItems: favoriteItems);

  Map<String, dynamic> toMap() {
    return {
      'SFId': sFId,
      'listName': listName,
      'FavoriteItems': favoriteItems.map((x) => x.toMap()).toList(),
    };
  }

  factory FavoriteListModel.fromMap(Map<String, dynamic> map) {
    return FavoriteListModel(
      sFId: map['SFId'],
      listName: map['listName'],
      favoriteItems: List<FavoriteItemModel>.from(
          map['FavoriteItems']?.map((x) => FavoriteItemModel.fromMap(x)) ??
              const []),
    );
  }

  factory FavoriteListModel.fromEntity(FavoriteList favoriteList) {
    return FavoriteListModel(
      sFId: favoriteList.sFId,
      listName: favoriteList.listName,
      favoriteItems: favoriteList.favoriteItems
          .map((e) => FavoriteItemModel.fromEntity(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteListModel.fromJson(String source) =>
      FavoriteListModel.fromMap(json.decode(source));
}
