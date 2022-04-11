import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/presentation/controllers/search_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_page_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF4F4F6),
      child: SizedBox.expand(
        child: Obx(() => Column(
              children: [
                if (searchController.findedMaterials.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(
                        height: Get.width * 0.05,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Search results',
                            style: TextStyle(
                              fontSize: Get.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.width * 0.02,
                      ),
                      Obx(() => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.06),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Found: ' +
                                    searchController.findedMaterials.length
                                        .toString() +
                                    ' Results of ' +
                                    searchController.textEditingController.text,
                                style: TextStyle(
                                  fontSize: Get.width * 0.04,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                if (searchController.findedMaterials.isNotEmpty)
                  Expanded(
                    child: ListView(
                      children: searchController.findedMaterials
                          .map((element) => MaterialCard(
                                materiale: element, controller: Get.find(),
                              ))
                          .toList(),
                    ),
                  ),
                if (searchController.findedMaterials.isEmpty &&
                    searchController.findedSimilarMaterials.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(Get.width * 0.05),
                    child: Text(
                      'No results were found for this product but we have similar products',
                      style: TextStyle(
                          color: Colors.black, fontSize: Get.width * 0.04),
                    ),
                  ),

            
            Obx(() => Expanded(
                  child: ListView(
                    children: searchController.findedMaterials
                        .map((element) => MaterialCard(
                              materiale: element,
                      controller: Get.find(),
                            ))
                        .toList()))),

                if (searchController.findedMaterials.isEmpty &&
                    searchController.findedSimilarMaterials.isNotEmpty)
                  Expanded(
                    child: ListView(
                      children: searchController.findedSimilarMaterials
                          .map((element) => MaterialCard(
                                materiale: element, controller: Get.find(),
                              ))
                          .toList(),
                    ),

                  ),
              ],
            )),
      ),
    );
  }
}
