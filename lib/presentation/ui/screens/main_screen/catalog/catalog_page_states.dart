import 'package:equatable/equatable.dart';
import 'package:***REMOVED***/domain/entities/materials/brand.dart';
import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';

abstract class CatalogPageState {}

class ShowAllMaterials extends CatalogPageState with EquatableMixin {
  final List<Materiale> materials;
  ShowAllMaterials({
    required this.materials,
  });

  @override
  List<Object> get props => [materials];

  @override
  String toString() => 'ShowAllMaterials(materials: $materials)';
}

class ShowBrands extends CatalogPageState with EquatableMixin {
  final List<Brand> brands;
  ShowBrands({
    required this.brands,
  });

  @override
  List<Object> get props => [brands];

  @override
  String toString() => 'ShowBrands( brands: $brands)';
}

class ShowFamilies extends CatalogPageState with EquatableMixin {
  final List<Family> families;
  ShowFamilies({
    required this.families,
  });

  @override
  List<Object> get props => [families];

  @override
  String toString() => 'ShowFamilies( families: $families)';
}

class ShowMaterialsByFamily extends CatalogPageState with EquatableMixin {
  final Family family;
  final List<Materiale> materials;
  ShowMaterialsByFamily({
    required this.family,
    required this.materials,
  });

  @override
  List<Object> get props => [family, materials];

  @override
  String toString() =>
      'ShowMaterialsByFamily( family: $family, materials: $materials)';
}

class ShowMaterialsByBrand extends CatalogPageState with EquatableMixin {
  final Brand brand;
  final List<Materiale> materials;
  ShowMaterialsByBrand({
    required this.brand,
    required this.materials,
  });

  @override
  List<Object> get props => [brand, materials];

  @override
  String toString() =>
      'ShowMaterialsByBrand(brand: $brand, materials: $materials)';
}
