import 'dart:convert';
import 'package:salesforce.startup/domain/entities/materials/alternative_item.dart';

class AlternativeItemModel extends AlternativeItem {
  AlternativeItemModel({
    required String SFId,
    required String RelatedMaterialId,
    required String MaterialId,
    required num? Index,
  }) : super(SFId: SFId, RelatedMaterialId: RelatedMaterialId, MaterialId: MaterialId, Index: Index);

  Map<String, dynamic> toMap() {
    return {
      'SFId': SFId,
      'RelatedMaterialId': RelatedMaterialId,
      'MaterialId': MaterialId,
      'Index': Index,
    };
  }

  factory AlternativeItemModel.fromMap(Map<String, dynamic> map) {
    return AlternativeItemModel(
      SFId: map['SFId'],
      RelatedMaterialId: map['RelatedMaterialId'],
      MaterialId: map['MaterialId'],
      Index: map['Index'],
    );
  }

  factory AlternativeItemModel.fromEntity(AlternativeItem alternativeItem) {
    return AlternativeItemModel(
      SFId: alternativeItem.SFId,
      RelatedMaterialId: alternativeItem.RelatedMaterialId,
      MaterialId: alternativeItem.MaterialId,
      Index: alternativeItem.Index,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlternativeItemModel.fromJson(String source) => AlternativeItemModel.fromMap(json.decode(source));
}
