import 'package:***REMOVED***/domain/entities/materials/brand.dart';
import 'package:***REMOVED***/domain/entities/materials/classification.dart';
import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/entities/materials/hierarchy.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:get/get.dart';

import 'material_card_controller.dart';

class CatalogPageController extends GetxController {
  CatalogPageController({
    required MaterialsCatalog materialsCatalog,
  }) : materialsCatalog = Rx(materialsCatalog);

  final Rx<MaterialsCatalog> materialsCatalog;

  // Main data
  List<Materiale> get getMaterials => materialsCatalog.value.materials;

  List<Brand> get getBrands => materialsCatalog.value.brands;

  List<Classification> get getClassifications =>
      materialsCatalog.value.classifications;

  List<Family> get getFamilies => materialsCatalog.value.families;

  List<Hierarchy> get getHierarchys => materialsCatalog.value.hierarchys;

  // Classification selection

  Rxn<Classification> selectedClassification = Rxn();

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

  //show or close count screen
  RxBool selectCount = RxBool(false);
  late MaterialCardController select_card_controller;
  void showProductCountScreen(
      {required Materiale materiale,
      required bool value,
      required MaterialCardController cardController}) {
    selectCount.value = value;
    select_card_controller = cardController;
  }

  void closeProductCountScreen() {
    selectCount.value = false;
  }

  // Brand and Families selection
  RxBool brandsOrFamilies = RxBool(true);

  Rxn<Brand> selectedBrand = Rxn();

  Rxn<Family> selectedFamily = Rxn();

  bool get showBrandsPanel {
    if (showBrandsOrFamilies &&
        brandsOrFamilies.value == true &&
        selectedBrand.value == null) {
      return true;
    }
    return false;
  }

  bool get showFamiliesPanel {
    if (showBrandsOrFamilies &&
        brandsOrFamilies.value == false &&
        selectedFamily.value == null) {
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

  List<Family> get familiesToShow => getFamilies.where((element) {
        if (materialsByClassification
            .map((e) => e.FamilyId ?? '')
            .contains(element.SFId)) {
          return true;
        }
        return false;
      }).toList();

  // Materials list when brand or family selected

  bool get showMaterialsByBrand {
    if (showBrandsOrFamilies &&
        brandsOrFamilies.value == true &&
        selectedBrand.value is Brand) {
      return true;
    }
    return false;
  }

  bool get showMaterialsByFamily {
    if (showBrandsOrFamilies &&
        brandsOrFamilies.value == false &&
        selectedFamily.value is Family) {
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

  List<Materiale> get materialsByFamily =>
      materialsByClassification.where((element) {
        if (element.FamilyId == selectedFamily.value?.SFId) {
          return true;
        }
        return false;
      }).toList();

  // TODO when api fixes
  Rxn<Hierarchy> selectedHierarhy = Rxn();

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
