import 'package:***REMOVED***/domain/entities/materials/brand.dart';
import 'package:***REMOVED***/domain/entities/materials/classification.dart';
import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/entities/materials/hierarchy.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:get/get.dart';

class CatalogPageController extends GetxController {
  CatalogPageController({
    required MaterialsCatalog materialsCatalog,
  }) : materialsCatalog = Rx(materialsCatalog);

  final Rx<MaterialsCatalog> materialsCatalog;

  List<Materiale> get getMaterials => materialsCatalog.value.materials;

  List<Brand> get getBrands => materialsCatalog.value.brands;

  List<Classification> get getClassifications =>
      materialsCatalog.value.classifications;

  List<Family> get getFamilies => materialsCatalog.value.families;

  List<Hierarchy> get getHierarchys => materialsCatalog.value.hierarchys;

  Rxn<Classification> selectedClassification = Rxn();

  RxBool brandsOrFamilies = RxBool(true);

  List<Materiale> get materialsByClassification =>
      getMaterials.where((element) {
        if (selectedClassification.value != null) {
          if (element.ClassificationId == selectedClassification.value!.SFId) {
            return true;
          } else {
            return false;
          }
        }
        return true;
      }).toList();

  bool get showBrandsOrFamilies {
    if (selectedClassification.value != null) {
      return true;
    }
    return false;
  }

  bool get showBrandsPanel {
    if (showBrandsOrFamilies &&
        brandsOrFamilies.value == true &&
        selectedBrand.value == null) {
      return true;
    }
    return false;
  }

  List<Brand> get brandsToShow => getBrands.where((element) {
        if (materialsByClassification
            .map((e) => e.BrandId ?? '')
            .contains(element.SFId)) {
          return true;
        }
        return false;
      }).toList();

  Rxn<Brand> selectedBrand = Rxn();

  bool get showMaterialsByBrand {
    if (showBrandsOrFamilies &&
        brandsOrFamilies.value == true &&
        selectedBrand.value is Brand) {
      return true;
    }
    return false;
  }

  List<Materiale> get materialsByBrand =>
      materialsByClassification.where((element) {
        if (element.BrandId == selectedBrand.value?.SFId) {
          return true;
        }
        return false;
      }).toList();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
