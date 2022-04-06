import 'dart:async';

import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  MaterialsCatalogController materialsCatalogController = Get.find();
  RxList<Materiale> findedMaterials = RxList();
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
}
