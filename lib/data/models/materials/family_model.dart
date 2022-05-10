import 'dart:convert';

import 'package:***REMOVED***/domain/entities/materials/family.dart';

class FamilyModel extends Family {
  FamilyModel({
    required String SFId,
    required int IndexNumber,
    required String ImageUrl,
    required String Display,
  }) : super(
            SFId: SFId,
            IndexNumber: IndexNumber,
            ImageUrl: ImageUrl,
            Display: Display);

  Map<String, dynamic> toMap() {
    return {
      'SFId': SFId,
      'IndexNumber': IndexNumber,
      'ImageUrl': ImageUrl,
      'Display': Display,
    };
  }

  factory FamilyModel.fromMap(Map<String, dynamic> map) {
    return FamilyModel(
      SFId: map['SFId'] ?? '',
      IndexNumber: map['IndexNumber']?.toInt() ?? 0,
      ImageUrl: map['ImageUrl'] ?? '',
      Display: map['Display'] ?? '',
    );
  }

  factory FamilyModel.fromEntity(Family family) {
    return FamilyModel(
      SFId: family.SFId,
      IndexNumber: family.IndexNumber,
      ImageUrl: family.ImageUrl,
      Display: family.Display,
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyModel.fromJson(String source) =>
      FamilyModel.fromMap(json.decode(source));
}
