import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/controllers/search_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderSearchResult extends StatelessWidget {
  const HeaderSearchResult({
    Key? key,
    required this.searchController,
    required this.mainScreeenHeaderController,
  }) : super(key: key);

  final SearchController searchController;
  final MainScreeenHeaderController mainScreeenHeaderController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: Get.width,
          color: MyColors.blue_00458C,
          child: Column(
            children: [
              if (searchController.findedMaterials.isNotEmpty)
                Expanded(
                  child: ListView(
                    children: searchController.findedMaterials.map((element) {
                      return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05,
                              vertical: Get.width * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
                          ),
                          height: Get.height * 0.1,
                          child: Row(
                            children: [
                              CachedImage(
                                  Url: element.ImageUrl,
                                  width: Get.height * 0.075,
                                  height: Get.height * 0.075),
                              Expanded(child: Text(element.Name)),
                            ],
                          ));
                    }).toList(),
                  ),
                ),
              if (searchController.findedMaterials.isEmpty &&
                  searchController.findedSimilarMaterials.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(Get.width * 0.05),
                  child: Text(
                    'No results were found for this product but we have similar products',
                    style: TextStyle(
                        color: Colors.white, fontSize: Get.width * 0.04),
                  ),
                ),
              if (searchController.findedMaterials.isEmpty &&
                  searchController.findedSimilarMaterials.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    searchController
                        .getCatalog()!
                        .families
                        .firstWhere((element) =>
                            element.SFId ==
                            searchController
                                .findedSimilarMaterials.first.FamilyId)
                        .Display,
                    style: TextStyle(
                        color: Colors.white, fontSize: Get.width * 0.04),
                  ),
                ),
              if (searchController.findedMaterials.isEmpty &&
                  searchController.findedSimilarMaterials.isNotEmpty)
                Expanded(
                  child: ListView(
                    children:
                        searchController.findedSimilarMaterials.map((element) {
                      return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05,
                              vertical: Get.width * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.03),
                          ),
                          height: Get.height * 0.1,
                          child: Row(
                            children: [
                              CachedImage(
                                  Url: element.ImageUrl,
                                  width: Get.height * 0.075,
                                  height: Get.height * 0.075),
                              Expanded(child: Text(element.Name)),
                            ],
                          ));
                    }).toList(),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  // searchController.showSearch.value = true;
                  Get.to(() => SearchScreen());
                  mainScreeenHeaderController.hide();
                },
                child: Padding(
                  padding: EdgeInsets.all(Get.width * 0.05),
                  child: Text(
                    'More results'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
