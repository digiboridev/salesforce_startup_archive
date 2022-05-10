import 'dart:convert';
import 'package:***REMOVED***/domain/entities/materials/brand.dart';

class BrandModel extends Brand {
  BrandModel({
    required String SFId,
    required int? Index,
    required String ImageUrl,
    required String Display,
  }) : super(SFId: SFId, Index: Index, ImageUrl: ImageUrl, Display: Display);

  Map<String, dynamic> toMap() {
    return {
      'SFId': SFId,
      'Index': Index,
      'ImageUrl': ImageUrl,
      'Display': Display,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      SFId: map['SFId'],
      Index: map['Index'],
      ImageUrl: map['ImageUrl'],
      Display: map['Display'],
    );
  }

  factory BrandModel.fromEntity(Brand brand) {
    return BrandModel(
      SFId: brand.SFId,
      Index: brand.Index,
      ImageUrl: brand.ImageUrl,
      Display: brand.Display,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source));
}
