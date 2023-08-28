import 'package:salesforce.startup/domain/entities/materials/scales.dart';
import 'package:equatable/equatable.dart';

class Pricing extends Equatable {
  final String? UnitDisplay;
  final String Unit;
  final String SFId;
  final num? Rate;
  final String MaterialId;
  final bool IsPercentage;
  final bool HasScale;
  final List<Scales> scales;
  Pricing({
    this.UnitDisplay,
    required this.Unit,
    required this.SFId,
    required this.Rate,
    required this.MaterialId,
    required this.IsPercentage,
    required this.HasScale,
    required this.scales,
  });

  @override
  List<Object> get props {
    return [
      UnitDisplay ?? 0,
      Unit,
      SFId,
      Rate ?? 0,
      MaterialId,
      IsPercentage,
      HasScale,
      scales,
    ];
  }

  @override
  String toString() {
    return 'Pricing(UnitDisplay: $UnitDisplay, Unit: $Unit, SFId: $SFId, Rate: $Rate, MaterialId: $MaterialId, IsPercentage: $IsPercentage, HasScale: $HasScale, Scales: $scales)';
  }
}
