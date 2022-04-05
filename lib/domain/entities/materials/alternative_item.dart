import 'package:equatable/equatable.dart';

class AlternativeItem extends Equatable {
  final String SFId;
  final String RelatedMaterialId;
  final String MaterialId;
  final num? Index;
  AlternativeItem({
    required this.SFId,
    required this.RelatedMaterialId,
    required this.MaterialId,
    required this.Index,
  });

  @override
  List<Object> get props => [SFId, RelatedMaterialId, MaterialId, Index ?? 0];

  @override
  String toString() {
    return 'AlternativeItem(SFId: $SFId, RelatedMaterialId: $RelatedMaterialId, MaterialId: $MaterialId, Index: $Index)';
  }
}
