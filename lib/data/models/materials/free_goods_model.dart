import 'dart:convert';
import 'package:***REMOVED***/domain/entities/materials/free_goods.dart';

class FreeGoodsModel extends FreeGoods {
  FreeGoodsModel({
    required String SFId,
    required String QuantityUnitDisplay,
    required String QuantityUnit,
    required String MaterialId,
    required String GetQuantityUnitDisplay,
    required String GetQuantityUnit,
    required String GetQty,
    required String GetMaterialId,
    required num BuyQty,
  }) : super(
          SFId: SFId,
          QuantityUnitDisplay: QuantityUnitDisplay,
          QuantityUnit: QuantityUnit,
          MaterialId: MaterialId,
          GetQuantityUnitDisplay: GetQuantityUnitDisplay,
          GetQuantityUnit: GetQuantityUnit,
          GetQty: GetQty,
          GetMaterialId: GetMaterialId,
          BuyQty: BuyQty,
        );

  Map<String, dynamic> toMap() {
    return {
      'SFId': SFId,
      'QuantityUnitDisplay': QuantityUnitDisplay,
      'QuantityUnit': QuantityUnit,
      'MaterialId': MaterialId,
      'GetQuantityUnitDisplay': GetQuantityUnitDisplay,
      'GetQuantityUnit': GetQuantityUnit,
      'GetQty': GetQty,
      'GetMaterialId': GetMaterialId,
      'BuyQty': BuyQty,
    };
  }

  factory FreeGoodsModel.fromEntity(FreeGoods freeGoods) {
    return FreeGoodsModel(
      SFId: freeGoods.SFId,
      QuantityUnitDisplay: freeGoods.QuantityUnitDisplay,
      QuantityUnit: freeGoods.QuantityUnit,
      MaterialId: freeGoods.MaterialId,
      GetQuantityUnitDisplay: freeGoods.GetQuantityUnitDisplay,
      GetQuantityUnit: freeGoods.GetQuantityUnit,
      GetQty: freeGoods.GetQty,
      GetMaterialId: freeGoods.GetMaterialId,
      BuyQty: freeGoods.BuyQty,
    );
  }
  factory FreeGoodsModel.fromMap(Map<String, dynamic> map) {
    return FreeGoodsModel(
      SFId: map['SFId'],
      QuantityUnitDisplay: map['QuantityUnitDisplay'],
      QuantityUnit: map['QuantityUnit'],
      MaterialId: map['MaterialId'],
      GetQuantityUnitDisplay: map['GetQuantityUnitDisplay'],
      GetQuantityUnit: map['GetQuantityUnit'],
      GetQty: map['GetQty'],
      GetMaterialId: map['GetMaterialId'],
      BuyQty: map['BuyQty'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FreeGoodsModel.fromJson(String source) =>
      FreeGoodsModel.fromMap(json.decode(source));
}
