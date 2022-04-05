import 'dart:convert';

import 'package:***REMOVED***/data/models/materials/brand_model.dart';
import 'package:***REMOVED***/data/models/materials/classification_model.dart';
import 'package:***REMOVED***/data/models/materials/family_model.dart';
import 'package:***REMOVED***/data/models/materials/hierarchy_model.dart';
import 'package:***REMOVED***/data/models/materials/material_model.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';

class MaterialsCatalogModel extends MaterialsCatalog {
  @override
  final List<MaterialModel> materials;
  @override
  final List<FamilyModel> families;
  @override
  final List<ClassificationModel> classifications;
  @override
  final List<BrandModel> brands;
  @override
  final List<HierarchyModel> hierarchys;

  MaterialsCatalogModel({
    required List<MaterialModel> this.materials,
    required List<FamilyModel> this.families,
    required List<ClassificationModel> this.classifications,
    required List<BrandModel> this.brands,
    required List<HierarchyModel> this.hierarchys,
  }) : super(
            materials: materials,
            families: families,
            classifications: classifications,
            brands: brands,
            hierarchys: hierarchys);

  Map<String, dynamic> toMap() {
    return {
      'materials': materials.map((x) => x.toMap()).toList(),
      'families': families.map((x) => x.toMap()).toList(),
      'classifications': classifications.map((x) => x.toMap()).toList(),
      'brands': brands.map((x) => x.toMap()).toList(),
      'hierarchys': hierarchys.map((x) => x.toMap()).toList(),
    };
  }

  factory MaterialsCatalogModel.fromMap(Map<String, dynamic> map) {
    return MaterialsCatalogModel(
      materials: List<MaterialModel>.from(
          map['materials']?.map((x) => MaterialModel.fromMap(x)) ?? const []),
      families: List<FamilyModel>.from(
          map['families']?.map((x) => FamilyModel.fromMap(x)) ?? const []),
      classifications: List<ClassificationModel>.from(
          map['classifications']?.map((x) => ClassificationModel.fromMap(x)) ??
              const []),
      brands: List<BrandModel>.from(
          map['brands']?.map((x) => BrandModel.fromMap(x)) ?? const []),
      hierarchys: List<HierarchyModel>.from(
          map['hierarchys']?.map((x) => HierarchyModel.fromMap(x)) ?? const []),
    );
  }

  factory MaterialsCatalogModel.fromEntity(MaterialsCatalog materialsCatalog) {
    return MaterialsCatalogModel(
      materials: materialsCatalog.materials
          .map((e) => MaterialModel.fromEntity(e))
          .toList(),
      families: materialsCatalog.families
          .map((e) => FamilyModel.fromEntity(e))
          .toList(),
      classifications: materialsCatalog.classifications
          .map((e) => ClassificationModel.fromEntity(e))
          .toList(),
      brands:
          materialsCatalog.brands.map((e) => BrandModel.fromEntity(e)).toList(),
      hierarchys: materialsCatalog.hierarchys
          .map((e) => HierarchyModel.fromEntity(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MaterialsCatalogModel.fromJson(String source) =>
      MaterialsCatalogModel.fromMap(json.decode(source));
}
