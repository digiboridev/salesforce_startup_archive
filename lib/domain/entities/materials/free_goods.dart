import 'package:equatable/equatable.dart';

class FreeGoods extends Equatable {
  final String SFId;
  final String QuantityUnitDisplay;
  final String QuantityUnit;
  final String MaterialId;
  final String GetQuantityUnitDisplay;
  final String GetQuantityUnit;
  final String GetQty;
  final String GetMaterialId;
  final num BuyQty;
  FreeGoods({
    required this.SFId,
    required this.QuantityUnitDisplay,
    required this.QuantityUnit,
    required this.MaterialId,
    required this.GetQuantityUnitDisplay,
    required this.GetQuantityUnit,
    required this.GetQty,
    required this.GetMaterialId,
    required this.BuyQty,
  });

  @override
  List<Object> get props {
    return [
      SFId,
      QuantityUnitDisplay,
      QuantityUnit,
      MaterialId,
      GetQuantityUnitDisplay,
      GetQuantityUnit,
      GetQty,
      GetMaterialId,
      BuyQty,
    ];
  }

  @override
  String toString() {
    return 'FreeGoods(SFId: $SFId, QuantityUnitDisplay: $QuantityUnitDisplay, QuantityUnit: $QuantityUnit, MaterialId: $MaterialId, GetQuantityUnitDisplay: $GetQuantityUnitDisplay, GetQuantityUnit: $GetQuantityUnit, GetQty: $GetQty, GetMaterialId: $GetMaterialId, BuyQty: $BuyQty)';
  }
}
