import 'package:***REMOVED***/domain/entities/materials/brand.dart';
import 'package:***REMOVED***/domain/entities/materials/classification.dart';
import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_page_states.dart';
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

  // Classification variables
  List<Classification> get getClassifications =>
      _materialsCatalog.value.classifications;

  Rxn<Classification> _selectedClassification = Rxn();
  Classification? get selectedClassification => _selectedClassification.value;

  List<Materiale> get _materialsByClassification =>
      _materialsCatalog.value.materials.where((element) {
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
      _state.value =
          ShowAllMaterials(materials: _materialsCatalog.value.materials);
    } else {
      _selectedClassification.value = classification;
      showBrands();
    }
  }

  showFamilies() {
    assert(_selectedClassification.value != null);

    _state.value = ShowFamilies(
        families: _materialsCatalog.value.families.where((element) {
      if (_materialsByClassification
          .map((e) => e.FamilyId ?? '')
          .contains(element.SFId)) {
        return true;
      }
      return false;
    }).toList());
  }

  showBrands() {
    assert(_selectedClassification.value != null);

    _state.value = ShowBrands(
        brands: _materialsCatalog.value.brands.where((element) {
      if (_materialsByClassification
          .map((e) => e.BrandId ?? '')
          .contains(element.SFId)) {
        return true;
      }
      return false;
    }).toList());
  }

  onBrandSelect({required Brand brand}) {
    assert(_selectedClassification.value != null);

    _state.value = ShowMaterialsByBrand(
        brand: brand,
        materials: _materialsByClassification.where((element) {
          if (element.BrandId == brand.SFId) {
            return true;
          }
          return false;
        }).toList());
  }

  onFamilySelect({required Family family}) {
    assert(_selectedClassification.value != null);

    _state.value = ShowMaterialsByFamily(
        family: family,
        materials: _materialsByClassification.where((element) {
          if (element.FamilyId == family.SFId) {
            return true;
          }
          return false;
        }).toList());
  }
}
