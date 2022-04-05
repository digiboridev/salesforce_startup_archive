import 'package:equatable/equatable.dart';
import 'package:***REMOVED***/domain/entities/materials/brand.dart';
import 'package:***REMOVED***/domain/entities/materials/classification.dart';
import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/entities/materials/hierarchy.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';

class MaterialsCatalog extends Equatable {
  final List<Materiale> materials;
  final List<Family> families;
  final List<Classification> classifications;
  final List<Brand> brands;
  final List<Hierarchy> hierarchys;
  MaterialsCatalog({
    required this.materials,
    required this.families,
    required this.classifications,
    required this.brands,
    required this.hierarchys,
  });

  @override
  List<Object> get props {
    return [
      materials,
      families,
      classifications,
      brands,
      hierarchys,
    ];
  }

  @override
  String toString() {
    return 'MaterialsCatalog(materials: $materials, families: $families, classifications: $classifications, brands: $brands, hierarchys: $hierarchys)';
  }
}
