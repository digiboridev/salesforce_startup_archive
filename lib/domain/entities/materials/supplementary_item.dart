import 'package:equatable/equatable.dart';

class SupplementaryItem extends Equatable {
  final String SFId;
  final String RelatedMaterialId;
  final String MaterialId;
  final num Index;
  SupplementaryItem({
    required this.SFId,
    required this.RelatedMaterialId,
    required this.MaterialId,
    required this.Index,
  });

  @override
  List<Object> get props => [SFId, RelatedMaterialId, MaterialId, Index];

  @override
  String toString() {
    return 'SupplementaryItem(SFId: $SFId, RelatedMaterialId: $RelatedMaterialId, MaterialId: $MaterialId, Index: $Index)';
  }
}
