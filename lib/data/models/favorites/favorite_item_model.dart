import 'dart:convert';

import 'package:***REMOVED***/domain/entities/favorites/favorite_item.dart';

class FavoriteItemModel extends FavoriteItem {
  FavoriteItemModel(
      {required String materialNumber,
      required String sFId,
      required String unit,
      required num quantity})
      : super(
            materialNumber: materialNumber,
            sFId: sFId,
            unit: unit,
            quantity: quantity);

  Map<String, dynamic> toMap() {
    return {
      'MaterialNumber': materialNumber,
      'SFId': sFId,
      'Unit': unit,
      'Quantity': quantity.toString(),
    };
  }

  factory FavoriteItemModel.fromMap(Map<String, dynamic> map) {
    return FavoriteItemModel(
      materialNumber: map['MaterialNumber'],
      sFId: map['SFId'],
      unit: map['Unit'],
      quantity: int.tryParse(map['Quantity']) ?? 0,
    );
  }

  factory FavoriteItemModel.fromEntity(FavoriteItem favoriteItem) {
    return FavoriteItemModel(
      materialNumber: favoriteItem.materialNumber,
      sFId: favoriteItem.sFId,
      unit: favoriteItem.unit,
      quantity: favoriteItem.quantity,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteItemModel.fromJson(String source) =>
      FavoriteItemModel.fromMap(json.decode(source));
}
