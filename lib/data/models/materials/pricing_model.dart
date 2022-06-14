import 'dart:convert';
import 'package:***REMOVED***/data/models/materials/scales_model.dart';
import 'package:***REMOVED***/domain/entities/materials/pricing.dart';

class PricingModel extends Pricing {
  @override
  final List<ScalesModel> scales;

  PricingModel({
    required String? UnitDisplay,
    required String Unit,
    required String SFId,
    required num? Rate,
    required String MaterialId,
    required bool IsPercentage,
    required bool HasScale,
    required List<ScalesModel> this.scales,
  }) : super(
            UnitDisplay: UnitDisplay,
            Unit: Unit,
            SFId: SFId,
            Rate: Rate,
            MaterialId: MaterialId,
            IsPercentage: IsPercentage,
            HasScale: HasScale,
            scales: scales);

  Map<String, dynamic> toMap() {
    return {
      'UnitDisplay': UnitDisplay,
      'Unit': Unit,
      'SFId': SFId,
      'Rate': Rate,
      'MaterialId': MaterialId,
      'IsPercentage': IsPercentage,
      'HasScale': HasScale,
      'Scales': scales.map((e) => e.toMap()).toList(),
    };
  }

  factory PricingModel.fromMap(Map<String, dynamic> map) {
    return PricingModel(
      UnitDisplay: map['UnitDisplay'],
      Unit: map['Unit'],
      SFId: map['SFId'],
      Rate: map['Rate'],
      MaterialId: map['MaterialId'],
      IsPercentage: map['IsPercentage'],
      HasScale: map['HasScale'],
      scales: List<ScalesModel>.from(
          map['Scales'].map((x) => ScalesModel.fromMap(x))),
    );
  }

  factory PricingModel.fromEntity(Pricing pricing) {
    return PricingModel(
      UnitDisplay: pricing.UnitDisplay,
      Unit: pricing.Unit,
      SFId: pricing.SFId,
      Rate: pricing.Rate,
      MaterialId: pricing.MaterialId,
      IsPercentage: pricing.IsPercentage,
      HasScale: pricing.HasScale,
      scales: pricing.scales.map((e) => ScalesModel.fromEntity(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PricingModel.fromJson(String source) =>
      PricingModel.fromMap(json.decode(source));
}
