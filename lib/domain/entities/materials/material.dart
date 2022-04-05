import 'package:***REMOVED***/domain/entities/materials/alternative_item.dart';
import 'package:***REMOVED***/domain/entities/materials/free_goods.dart';
import 'package:***REMOVED***/domain/entities/materials/pricing.dart';
import 'package:***REMOVED***/domain/entities/materials/supplementary_item.dart';
import 'package:equatable/equatable.dart';

class Material extends Equatable {
  final String WeightUnitDisplay;
  final num UnitPrice;
  final num UnitNetPrice;
  final String? Tags;
  final List<SupplementaryItem> SupplementaryItems;
  final String SFId;
  final num SalesUnitNumber;
  final String SalesUnitDisplay;
  final String SalesUnit;
  final String? RecommendationType;
  final String? RecommendationOrder;
  final String? ProductDescription;
  final List<Pricing> pricing;
  final num PalletCount;
  final String? NetWeight;
  final String Name;
  final num Multiplier;
  final num MinimumOrderQuantity;
  final String MaterialNumber;
  final String? Kashrut;
  final bool IsRecommended;
  final bool IsNew;
  final bool IsInStock;
  final bool IsHotSale;
  final bool IsFrozen;
  final num InnerCount;
  final String ImageUrl;
  final bool HasPromotion;
  final String? GrossWeight;
  final List<FreeGoods> freeGoods;
  final String? FamilyId;
  final String? ClassificationId;
  final String? Hierarchy4;
  final num CartonCount;
  final String? BrandId;
  final bool BlockForSaleApp;
  final bool BlockForReturn;
  final String Barcode;
  final num AverageQty;
  final List<AlternativeItem> alternativeItems;
  Material({
    required this.WeightUnitDisplay,
    required this.UnitPrice,
    required this.UnitNetPrice,
    required this.Tags,
    required this.SupplementaryItems,
    required this.SFId,
    required this.SalesUnitNumber,
    required this.SalesUnitDisplay,
    required this.SalesUnit,
    required this.RecommendationType,
    required this.RecommendationOrder,
    required this.ProductDescription,
    required this.pricing,
    required this.PalletCount,
    required this.NetWeight,
    required this.Name,
    required this.Multiplier,
    required this.MinimumOrderQuantity,
    required this.MaterialNumber,
    required this.Kashrut,
    required this.IsRecommended,
    required this.IsNew,
    required this.IsInStock,
    required this.IsHotSale,
    required this.IsFrozen,
    required this.InnerCount,
    required this.ImageUrl,
    required this.HasPromotion,
    required this.GrossWeight,
    required this.freeGoods,
    required this.FamilyId,
    required this.ClassificationId,
    required this.Hierarchy4,
    required this.CartonCount,
    required this.BrandId,
    required this.BlockForSaleApp,
    required this.BlockForReturn,
    required this.Barcode,
    required this.AverageQty,
    required this.alternativeItems,
  });

  @override
  List<Object> get props {
    return [
      WeightUnitDisplay,
      UnitPrice,
      UnitNetPrice,
      Tags ?? 0,
      SupplementaryItems,
      SFId,
      SalesUnitNumber,
      SalesUnitDisplay,
      SalesUnit,
      RecommendationType ?? 0,
      RecommendationOrder ?? 0,
      ProductDescription ?? 0,
      pricing,
      PalletCount,
      NetWeight ?? 0,
      Name,
      Multiplier,
      MinimumOrderQuantity,
      MaterialNumber,
      Kashrut ?? 0,
      IsRecommended,
      IsNew,
      IsInStock,
      IsHotSale,
      IsFrozen,
      InnerCount,
      ImageUrl,
      HasPromotion,
      GrossWeight ?? 0,
      freeGoods,
      FamilyId ?? 0,
      ClassificationId ?? 0,
      Hierarchy4 ?? 0,
      CartonCount,
      BrandId ?? 0,
      BlockForSaleApp,
      BlockForReturn,
      Barcode,
      AverageQty,
      alternativeItems,
    ];
  }

  @override
  String toString() {
    return 'Material(WeightUnitDisplay: $WeightUnitDisplay, UnitPrice: $UnitPrice, UnitNetPrice: $UnitNetPrice, Tags: $Tags, SupplementaryItems: $SupplementaryItems, SFId: $SFId, SalesUnitNumber: $SalesUnitNumber, SalesUnitDisplay: $SalesUnitDisplay, SalesUnit: $SalesUnit, RecommendationType: $RecommendationType, RecommendationOrder: $RecommendationOrder, ProductDescription: $ProductDescription, ricing: $pricing, PalletCount: $PalletCount, NetWeight: $NetWeight, Name: $Name, Multiplier: $Multiplier, MinimumOrderQuantity: $MinimumOrderQuantity, MaterialNumber: $MaterialNumber, Kashrut: $Kashrut, IsRecommended: $IsRecommended, IsNew: $IsNew, IsInStock: $IsInStock, IsHotSale: $IsHotSale, IsFrozen: $IsFrozen, InnerCount: $InnerCount, ImageUrl: $ImageUrl, HasPromotion: $HasPromotion, GrossWeight: $GrossWeight, freeGoods: $FreeGoods, FamilyId: $FamilyId, ClassificationId: $ClassificationId, Hierarchy4: $Hierarchy4, CartonCount: $CartonCount, BrandId: $BrandId, BlockForSaleApp: $BlockForSaleApp, BlockForReturn: $BlockForReturn, Barcode: $Barcode, AverageQty: $AverageQty, AlternativeItems: $alternativeItems)';
  }
}
