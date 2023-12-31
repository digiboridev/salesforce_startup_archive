import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/presentation/controllers/search_controller.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/header/mainscreen_header_controller.dart';
import 'package:salesforce.startup/presentation/ui/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenInherited extends StatelessWidget {
  SearchScreenInherited({Key? key}) : super(key: key);
  final SearchController searchController = Get.find();
  final MainScreeenHeaderController mainScreeenHeaderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white_F4F4F6,
      child: SizedBox.expand(
        child: Obx(() => Column(
              children: [
                if (mainScreeenHeaderController.enableBrunchSelection.value)
                  SizedBox(
                    height: Get.width * 0.08,
                  ),
                if (searchController.findedMaterials.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(
                        height: Get.width * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Search results'.tr,
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
                            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${'Found'.tr}: ' +
                                    searchController.findedMaterials.length.toString() +
                                    ' ${'Results of'.tr} ' +
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
                                materiale: element,
                              ))
                          .toList(),
                    ),
                  ),
                if (searchController.findedMaterials.isEmpty && searchController.findedSimilarMaterials.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.all(Get.width * 0.05),
                    child: Text(
                      'No results were found for this product but we have similar products'.tr,
                      style: TextStyle(color: Colors.black, fontSize: Get.width * 0.04),
                    ),
                  ),
                if (searchController.findedMaterials.isEmpty && searchController.findedSimilarMaterials.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      searchController
                          .getCatalog()!
                          .families
                          .firstWhere((element) => element.SFId == searchController.findedSimilarMaterials.first.FamilyId)
                          .Display,
                      style: TextStyle(color: Colors.black, fontSize: Get.width * 0.04),
                    ),
                  ),
                if (searchController.findedMaterials.isEmpty && searchController.findedSimilarMaterials.isNotEmpty)
                  Expanded(
                    child: ListView(
                      children: searchController.findedSimilarMaterials
                          .map((element) => MaterialCard(
                                materiale: element,
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
