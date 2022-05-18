import 'dart:convert';
import 'package:***REMOVED***/data/models/materials/alternative_item_model.dart';
import 'package:***REMOVED***/data/models/materials/free_goods_model.dart';
import 'package:***REMOVED***/data/models/materials/pricing_model.dart';
import 'package:***REMOVED***/data/models/materials/supplementary_item_model.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:get/get.dart';

class MaterialModel extends Materiale {
  @override
  final List<SupplementaryItemModel> SupplementaryItems;
  @override
  final List<PricingModel> pricing;
  @override
  final List<FreeGoodsModel> freeGoods;
  @override
  final List<AlternativeItemModel> alternativeItems;

  MaterialModel({
    required String WeightUnitDisplay,
    required num UnitPrice,
    required num UnitNetPrice,
    required String? Tags,
    required List<SupplementaryItemModel> this.SupplementaryItems,
    required String SFId,
    required num SalesUnitNumber,
    required String SalesUnitDisplay,
    required String SalesUnit,
    required num? RecommendationType,
    required num? RecommendationOrder,
    required String? ProductDescription,
    required List<PricingModel> this.pricing,
    required num PalletCount,
    required String? NetWeight,
    required String Name,
    required num Multiplier,
    required num MinimumOrderQuantity,
    required String MaterialNumber,
    required String? Kashrut,
    required bool IsRecommended,
    required bool IsNew,
    required bool IsInStock,
    required bool IsHotSale,
    required bool IsFrozen,
    required num InnerCount,
    required String ImageUrl,
    required bool HasPromotion,
    required String? GrossWeight,
    required List<FreeGoodsModel> this.freeGoods,
    required String? FamilyId,
    required String? ClassificationId,
    required String? Hierarchy4,
    required num CartonCount,
    required String? BrandId,
    required bool BlockForSaleApp,
    required bool BlockForReturn,
    required String Barcode,
    required num AverageQty,
    required List<AlternativeItemModel> this.alternativeItems,
    required RxBool didSubscribedToInventoryAlert,
  }) : super(
          WeightUnitDisplay: WeightUnitDisplay,
          UnitPrice: UnitPrice,
          UnitNetPrice: UnitNetPrice,
          Tags: Tags,
          SupplementaryItems: SupplementaryItems,
          SFId: SFId,
          SalesUnitNumber: SalesUnitNumber,
          SalesUnitDisplay: SalesUnitDisplay,
          SalesUnit: SalesUnit,
          RecommendationType: RecommendationType,
          RecommendationOrder: RecommendationOrder,
          ProductDescription: ProductDescription,
          pricing: pricing,
          PalletCount: PalletCount,
          NetWeight: NetWeight,
          Name: Name,
          Multiplier: Multiplier,
          MinimumOrderQuantity: MinimumOrderQuantity,
          MaterialNumber: MaterialNumber,
          Kashrut: Kashrut,
          IsRecommended: IsRecommended,
          IsNew: IsNew,
          IsInStock: IsInStock,
          IsHotSale: IsHotSale,
          IsFrozen: IsFrozen,
          InnerCount: InnerCount,
          ImageUrl: ImageUrl,
          HasPromotion: HasPromotion,
          GrossWeight: GrossWeight,
          freeGoods: freeGoods,
          FamilyId: FamilyId,
          ClassificationId: ClassificationId,
          Hierarchy4: Hierarchy4,
          CartonCount: CartonCount,
          BrandId: BrandId,
          BlockForSaleApp: BlockForSaleApp,
          BlockForReturn: BlockForReturn,
          Barcode: Barcode,
          AverageQty: AverageQty,
          alternativeItems: alternativeItems,
          didSubscribedToInventoryAlert: didSubscribedToInventoryAlert,
        );

  Map<String, dynamic> toMap() {
    return {
      'WeightUnitDisplay': WeightUnitDisplay,
      'UnitPrice': UnitPrice,
      'UnitNetPrice': UnitNetPrice,
      'Tags': Tags,
      'SupplementaryItems': SupplementaryItems.map((x) => x.toMap()).toList(),
      'SFId': SFId,
      'SalesUnitNumber': SalesUnitNumber,
      'SalesUnitDisplay': SalesUnitDisplay,
      'SalesUnit': SalesUnit,
      'RecommendationType': RecommendationType,
      'RecommendationOrder': RecommendationOrder,
      'ProductDescription': ProductDescription,
      'Pricing': pricing.map((x) => x.toMap()).toList(),
      'PalletCount': PalletCount,
      'NetWeight': NetWeight,
      'Name': Name,
      'Multiplier': Multiplier,
      'MinimumOrderQuantity': MinimumOrderQuantity,
      'MaterialNumber': MaterialNumber,
      'Kashrut': Kashrut,
      'IsRecommended': IsRecommended,
      'IsNew': IsNew,
      'IsInStock': IsInStock,
      'IsHotSale': IsHotSale,
      'IsFrozen': IsFrozen,
      'InnerCount': InnerCount,
      'ImageUrl': ImageUrl,
      'HasPromotion': HasPromotion,
      'GrossWeight': GrossWeight,
      'FreeGoods': freeGoods.map((x) => x.toMap()).toList(),
      'FamilyId': FamilyId,
      'ClassificationId': ClassificationId,
      'Hierarchy4': Hierarchy4,
      'CartonCount': CartonCount,
      'BrandId': BrandId,
      'BlockForSaleApp': BlockForSaleApp,
      'BlockForReturn': BlockForReturn,
      'Barcode': Barcode,
      'AverageQty': AverageQty,
      'AlternativeItems': alternativeItems.map((x) => x.toMap()).toList(),
      'didSubscribedToInventoryAlert': didSubscribedToInventoryAlert.value,
    };
  }

  factory MaterialModel.fromMap(Map<String, dynamic> map) {
    return MaterialModel(
      WeightUnitDisplay: map['WeightUnitDisplay'],
      UnitPrice: map['UnitPrice'],
      UnitNetPrice: map['UnitNetPrice'],
      Tags: map['Tags'],
      SupplementaryItems: List<SupplementaryItemModel>.from(
          map['SupplementaryItems']
              .map((x) => SupplementaryItemModel.fromMap(x))),
      SFId: map['SFId'],
      SalesUnitNumber: map['SalesUnitNumber'],
      SalesUnitDisplay: map['SalesUnitDisplay'],
      SalesUnit: map['SalesUnit'],
      RecommendationType: map['RecommendationType'],
      RecommendationOrder: map['RecommendationOrder'],
      ProductDescription: map['ProductDescription'],
      pricing: List<PricingModel>.from(
          map['Pricing']?.map((x) => PricingModel.fromMap(x)) ?? []),
      PalletCount: map['PalletCount'],
      NetWeight: map['NetWeight'],
      Name: map['Name'],
      Multiplier: map['Multiplier'],
      MinimumOrderQuantity: map['MinimumOrderQuantity'],
      MaterialNumber: map['MaterialNumber'],
      Kashrut: map['Kashrut'],
      IsRecommended: map['IsRecommended'],
      IsNew: map['IsNew'],
      IsInStock: map['IsInStock'],
      IsHotSale: map['IsHotSale'],
      IsFrozen: map['IsFrozen'],
      InnerCount: map['InnerCount'],
      ImageUrl: map['ImageUrl'],
      HasPromotion: map['HasPromotion'],
      GrossWeight: map['GrossWeight'],
      freeGoods: List<FreeGoodsModel>.from(
          map['FreeGoods']?.map((x) => FreeGoodsModel.fromMap(x)) ?? []),
      FamilyId: map['FamilyId'],
      ClassificationId: map['ClassificationId'],
      Hierarchy4: map['Hierarchy4'],
      CartonCount: map['CartonCount'],
      BrandId: map['BrandId'],
      BlockForSaleApp: map['BlockForSaleApp'],
      BlockForReturn: map['BlockForReturn'],
      Barcode: map['Barcode'],
      AverageQty: map['AverageQty'],
      alternativeItems: List<AlternativeItemModel>.from(map['AlternativeItems']
              ?.map((x) => AlternativeItemModel.fromMap(x)) ??
          []),
      didSubscribedToInventoryAlert:
          RxBool(map['didSubscribedToInventoryAlert']),
    );
  }

  factory MaterialModel.fromEntity(Materiale materialModel) {
    return MaterialModel(
      WeightUnitDisplay: materialModel.WeightUnitDisplay,
      UnitPrice: materialModel.UnitPrice,
      UnitNetPrice: materialModel.UnitNetPrice,
      Tags: materialModel.Tags,
      SupplementaryItems: materialModel.SupplementaryItems.map(
          (e) => SupplementaryItemModel.fromEntity(e)).toList(),
      SFId: materialModel.SFId,
      SalesUnitNumber: materialModel.SalesUnitNumber,
      SalesUnitDisplay: materialModel.SalesUnitDisplay,
      SalesUnit: materialModel.SalesUnit,
      RecommendationType: materialModel.RecommendationType,
      RecommendationOrder: materialModel.RecommendationOrder,
      ProductDescription: materialModel.ProductDescription,
      pricing:
          materialModel.pricing.map((e) => PricingModel.fromEntity(e)).toList(),
      PalletCount: materialModel.PalletCount,
      NetWeight: materialModel.NetWeight,
      Name: materialModel.Name,
      Multiplier: materialModel.Multiplier,
      MinimumOrderQuantity: materialModel.MinimumOrderQuantity,
      MaterialNumber: materialModel.MaterialNumber,
      Kashrut: materialModel.Kashrut,
      IsRecommended: materialModel.IsRecommended,
      IsNew: materialModel.IsNew,
      IsInStock: materialModel.IsInStock,
      IsHotSale: materialModel.IsHotSale,
      IsFrozen: materialModel.IsFrozen,
      InnerCount: materialModel.InnerCount,
      ImageUrl: materialModel.ImageUrl,
      HasPromotion: materialModel.HasPromotion,
      GrossWeight: materialModel.GrossWeight,
      freeGoods: materialModel.freeGoods
          .map((e) => FreeGoodsModel.fromEntity(e))
          .toList(),
      FamilyId: materialModel.FamilyId,
      ClassificationId: materialModel.ClassificationId,
      Hierarchy4: materialModel.Hierarchy4,
      CartonCount: materialModel.CartonCount,
      BrandId: materialModel.BrandId,
      BlockForSaleApp: materialModel.BlockForSaleApp,
      BlockForReturn: materialModel.BlockForReturn,
      Barcode: materialModel.Barcode,
      AverageQty: materialModel.AverageQty,
      alternativeItems: materialModel.alternativeItems
          .map((e) => AlternativeItemModel.fromEntity(e))
          .toList(),
      didSubscribedToInventoryAlert:
          materialModel.didSubscribedToInventoryAlert,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaterialModel.fromJson(String source) =>
      MaterialModel.fromMap(json.decode(source));
}
