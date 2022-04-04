import 'package:equatable/equatable.dart';

class AlternativeItem extends Equatable {
  final String SFId;
  final String RelatedMaterialId;
  final String MaterialId;
  final String Index;
  AlternativeItem({
    required this.SFId,
    required this.RelatedMaterialId,
    required this.MaterialId,
    required this.Index,
  });

  @override
  List<Object> get props => [SFId, RelatedMaterialId, MaterialId, Index];

  @override
  String toString() {
    return 'AlternativeItem(SFId: $SFId, RelatedMaterialId: $RelatedMaterialId, MaterialId: $MaterialId, Index: $Index)';
  }
}
