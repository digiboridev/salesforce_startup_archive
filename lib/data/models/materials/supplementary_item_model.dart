import 'dart:convert';
import 'package:salesforce.startup/domain/entities/materials/supplementary_item.dart';

class SupplementaryItemModel extends SupplementaryItem {
  SupplementaryItemModel({
    required String SFId,
    required String RelatedMaterialId,
    required String MaterialId,
    required num Index,
  }) : super(
          SFId: SFId,
          RelatedMaterialId: RelatedMaterialId,
          MaterialId: MaterialId,
          Index: Index,
        );

  Map<String, dynamic> toMap() {
    return {
      'SFId': SFId,
      'RelatedMaterialId': RelatedMaterialId,
      'MaterialId': MaterialId,
      'Index': Index,
    };
  }

  factory SupplementaryItemModel.fromMap(Map<String, dynamic> map) {
    return SupplementaryItemModel(
      SFId: map['SFId'],
      RelatedMaterialId: map['RelatedMaterialId'],
      MaterialId: map['MaterialId'],
      Index: map['Index'],
    );
  }

  factory SupplementaryItemModel.fromEntity(SupplementaryItem supplementaryItem) {
    return SupplementaryItemModel(
      SFId: supplementaryItem.SFId,
      RelatedMaterialId: supplementaryItem.RelatedMaterialId,
      MaterialId: supplementaryItem.MaterialId,
      Index: supplementaryItem.Index,
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplementaryItemModel.fromJson(String source) => SupplementaryItemModel.fromMap(json.decode(source));
}
