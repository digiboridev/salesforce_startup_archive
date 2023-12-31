import 'package:salesforce.startup/domain/entities/materials/brand.dart';
import 'package:salesforce.startup/domain/entities/materials/classification.dart';
import 'package:salesforce.startup/domain/entities/materials/family.dart';
import 'package:salesforce.startup/domain/entities/materials/hierarchy.dart';
import 'package:salesforce.startup/domain/entities/materials/material.dart';
import 'package:salesforce.startup/domain/entities/materials/materials_catalog.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/catalog/catalog_page_states.dart';
import 'package:get/get.dart';

class CatalogPageController extends GetxController {
  final Rx<MaterialsCatalog> _materialsCatalog;

  CatalogPageController({
    required MaterialsCatalog materialsCatalog,
  }) : _materialsCatalog = Rx(materialsCatalog);

  @override
  void onInit() {
    super.onInit();
    _state = Rx(ShowAllMaterials(materials: _materialsCatalog.value.materials));
  }

  // State
  late final Rx<CatalogPageState> _state;
  CatalogPageState get state => _state.value;

  // variables

  List<Hierarchy> get hierarhys => _materialsCatalog.value.hierarchys;

  List<Classification> get getClassifications => _materialsCatalog.value.classifications
      .where((element) => _materialsCatalog.value.materials.map((e) => e.ClassificationId).contains(element.SFId))
      .toList();

  Rxn<Classification> _selectedClassification = Rxn();
  Classification? get selectedClassification => _selectedClassification.value;

  List<Materiale> get _materialsByClassification => _materialsCatalog.value.materials.where((element) {
        if (_selectedClassification.value != null) {
          if (element.ClassificationId == _selectedClassification.value!.SFId) {
            return true;
          } else {
            return false;
          }
        }
        return true;
      }).toList();

  // Events
  onClassificationClick({required Classification classification}) {
    if (_selectedClassification.value == classification) {
      _selectedClassification.value = null;
      _state.value = ShowAllMaterials(materials: _materialsCatalog.value.materials);
    } else {
      _selectedClassification.value = classification;
      showBrands();
    }
  }

  showFamilies() {
    assert(_selectedClassification.value != null);

    _state.value = ShowFamilies(
        families: _materialsCatalog.value.families.where((element) {
      if (_materialsByClassification.map((e) => e.FamilyId ?? '').contains(element.SFId)) {
        return true;
      }
      return false;
    }).toList());
  }

  showBrands() {
    assert(_selectedClassification.value != null);

    _state.value = ShowBrands(
        brands: _materialsCatalog.value.brands.where((element) {
      if (_materialsByClassification.map((e) => e.BrandId ?? '').contains(element.SFId)) {
        return true;
      }
      return false;
    }).toList());
  }

  onBrandSelect({required Brand brand}) {
    assert(_selectedClassification.value != null);

    List<Materiale> materials = _materialsByClassification.where((element) {
      if (element.BrandId == brand.SFId) {
        return true;
      }
      return false;
    }).toList();

    // Set<Materiale> s = Set();

    // s = materials
    //     .where((element) => element.alternativeItems.isNotEmpty)
    //     .toSet();

    // s = _materialsCatalog.value.materials
    //     .where((element) => element.pricing.isNotEmpty)
    //     .toSet();

    // s = _materialsCatalog.value.materials
    //     .where((element) => element.freeGoods.isNotEmpty)
    //     .toSet();

    Set<Hierarchy> avaliableHierarhys = Set();

    materials.where((m) => m.Hierarchy4 != null).forEach((mm) {
      Hierarchy? h = hierarhys.firstWhereOrNull((h) => h.SFId == mm.Hierarchy4);
      if (h != null) {
        avaliableHierarhys.add(h);
      }
    });

    _state.value =
        ShowMaterialsByBrand(brand: brand, avaliableHierarhys: avaliableHierarhys.toList(), materials: materials, hierarhyFilter: null, showFilter: false);
  }

  onFamilySelect({required Family family}) {
    assert(_selectedClassification.value != null);

    List<Materiale> materials = _materialsByClassification.where((element) {
      if (element.FamilyId == family.SFId) {
        return true;
      }
      return false;
    }).toList();

    Set<Hierarchy> avaliableHierarhys = Set();

    materials.where((m) => m.Hierarchy4 != null).forEach((mm) {
      Hierarchy? h = hierarhys.firstWhereOrNull((h) => h.SFId == mm.Hierarchy4);
      if (h != null) {
        avaliableHierarhys.add(h);
      }
    });

    _state.value =
        ShowMaterialsByFamily(family: family, materials: materials, avaliableHierarhys: avaliableHierarhys.toList(), hierarhyFilter: null, showFilter: false);
  }

  onFilterClick() {
    var oldState = state;
    if (oldState is HierarhableMaterials) {
      _state.value = oldState.copyWith(showFilter: !oldState.showFilter);
    }
  }

  changeHierarhyFilter({required Hierarchy? hierarchy}) {
    var oldState = state;

    if (oldState is HierarhableMaterials) {
      if (hierarchy == null) {
        _state.value = oldState.copyWithClearedFilter();
      } else {
        _state.value = oldState.copyWith(hierarhyFilter: hierarchy);
      }
    }
  }

  onDealsClick({bool forsed = false}) {
    if (_state.value is ShowDeals && !forsed) {
      _state.value = ShowAllMaterials(materials: _materialsCatalog.value.materials);
    } else {
      _selectedClassification.value = null;
      List<Materiale> materialsToShow = _materialsCatalog.value.materials.where((element) => element.IsHotSale).toList();
      _state.value = ShowDeals(materials: materialsToShow);
    }
  }
}
