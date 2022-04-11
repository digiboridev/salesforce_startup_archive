import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  MaterialsCatalogController materialsCatalogController = Get.find();
  RxList<Materiale> findedMaterials = RxList();
  RxList<Materiale> findedSimilarMaterials = RxList();
  RxBool showSearch = RxBool(false);

  @override
  void onReady() {
    super.onReady();
    textEditingController.addListener(() {
      if (textEditingController.text.isEmpty) {
        findedMaterials.clear();
        return;
      }
      List<Materiale> finded = getMaterials()
          .where((element) => element.Name.toLowerCase()
              .contains(textEditingController.text.toLowerCase()))
          .toList();

      findedMaterials.value = finded;

      if (finded.isEmpty) {
        List<Family> families = getCatalog()?.families ?? [];

        List<Family> findedFams = families
            .where((element) => element.Display.toLowerCase()
                .contains(textEditingController.text.toLowerCase()))
            .toList();

        Set<Materiale> findedMaterialsByFam = Set();

        getMaterials().forEach((material) {
          if (findedFams.map((e) => e.SFId).contains(material.FamilyId)) {
            findedMaterialsByFam.add(material);
          }
        });

        findedSimilarMaterials.value = findedMaterialsByFam.toList();
      } else {
        findedSimilarMaterials.clear();
      }
    });
  }

  List<Materiale> getMaterials() {
    MaterialsCatalogState materialsState =
        materialsCatalogController.materialsCatalogState.value;
    if (materialsState is MCSCommon) {
      return materialsState.catalog.materials;
    } else {
      return [];
    }
  }

  MaterialsCatalog? getCatalog() {
    MaterialsCatalogState materialsState =
        materialsCatalogController.materialsCatalogState.value;
    if (materialsState is MCSCommon) {
      return materialsState.catalog;
    } else {
      return null;
    }
  }
}
