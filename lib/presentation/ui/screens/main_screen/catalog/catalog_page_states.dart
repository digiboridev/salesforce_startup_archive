import 'package:equatable/equatable.dart';

import 'package:***REMOVED***/domain/entities/materials/brand.dart';
import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/entities/materials/hierarchy.dart';
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

class ShowDeals extends CatalogPageState with EquatableMixin {
  final List<Materiale> materials;
  ShowDeals({
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

abstract class HierarhableMaterials extends CatalogPageState {
  Hierarchy? get hierarhyFilter;
  List<Materiale> get materials;
  bool get showFilter;
  List<Hierarchy> get avaliableHierarhys;

  HierarhableMaterials copyWith({
    List<Materiale>? materials,
    Hierarchy? hierarhyFilter,
    bool? showFilter,
    List<Hierarchy>? avaliableHierarhys,
  });

  List<Materiale> get materialsByFilter {
    if (hierarhyFilter != null) {
      return materials
          .where((element) => element.Hierarchy4 == hierarhyFilter!.SFId)
          .toList();
    } else {
      return materials;
    }
  }
}

class ShowMaterialsByFamily extends HierarhableMaterials with EquatableMixin {
  final Family family;
  final List<Materiale> materials;
  final Hierarchy? hierarhyFilter;
  final bool showFilter;
  final List<Hierarchy> avaliableHierarhys;
  ShowMaterialsByFamily({
    required this.family,
    required this.materials,
    required this.hierarhyFilter,
    required this.showFilter,
    required this.avaliableHierarhys,
  });

  @override
  List<Object> get props {
    return [
      family,
      materials,
      hierarhyFilter ?? 0,
      showFilter,
      avaliableHierarhys,
    ];
  }

  @override
  String toString() {
    return 'ShowMaterialsByFamily(family: $family, materials: $materials, hierarhyFilter: $hierarhyFilter, showFilter: $showFilter, avaliableHierarhys: $avaliableHierarhys)';
  }

  ShowMaterialsByFamily copyWith({
    Family? family,
    List<Materiale>? materials,
    Hierarchy? hierarhyFilter,
    bool? showFilter,
    List<Hierarchy>? avaliableHierarhys,
  }) {
    return ShowMaterialsByFamily(
      family: family ?? this.family,
      materials: materials ?? this.materials,
      hierarhyFilter: hierarhyFilter ?? this.hierarhyFilter,
      showFilter: showFilter ?? this.showFilter,
      avaliableHierarhys: avaliableHierarhys ?? this.avaliableHierarhys,
    );
  }
}

class ShowMaterialsByBrand extends HierarhableMaterials with EquatableMixin {
  final Brand brand;
  final List<Materiale> materials;
  final Hierarchy? hierarhyFilter;
  final bool showFilter;
  final List<Hierarchy> avaliableHierarhys;

  ShowMaterialsByBrand({
    required this.brand,
    required this.materials,
    required this.hierarhyFilter,
    required this.showFilter,
    required this.avaliableHierarhys,
  });

  @override
  List<Object> get props {
    return [
      brand,
      materials,
      hierarhyFilter ?? 0,
      showFilter,
      avaliableHierarhys,
    ];
  }

  @override
  String toString() {
    return 'ShowMaterialsByBrand(brand: $brand, materials: $materials, hierarhyFilter: $hierarhyFilter, showFilter: $showFilter, avaliableHierarhys: $avaliableHierarhys)';
  }

  ShowMaterialsByBrand copyWith({
    Brand? brand,
    List<Materiale>? materials,
    Hierarchy? hierarhyFilter,
    bool? showFilter,
    List<Hierarchy>? avaliableHierarhys,
  }) {
    return ShowMaterialsByBrand(
      brand: brand ?? this.brand,
      materials: materials ?? this.materials,
      hierarhyFilter: hierarhyFilter ?? this.hierarhyFilter,
      showFilter: showFilter ?? this.showFilter,
      avaliableHierarhys: avaliableHierarhys ?? this.avaliableHierarhys,
    );
  }
}
