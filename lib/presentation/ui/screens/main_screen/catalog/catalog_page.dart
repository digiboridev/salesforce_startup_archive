import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/brand_card.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/families_card.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:***REMOVED***/domain/entities/materials/hierarchy.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_page_controller.dart';

class CatalogPage extends StatefulWidget {
  final MaterialsCatalog materialsCatalog;

  CatalogPage({
    Key? key,
    required this.materialsCatalog,
  }) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late CatalogPageController catalogPageController;
  ImageCachingService imageCachingService = ImageCachingService();

  @override
  void initState() {
    super.initState();
    catalogPageController = Get.put(
        CatalogPageController(materialsCatalog: widget.materialsCatalog));
  }

  @override
  void dispose() {
    super.dispose();
    // Get.delete<CatalogPageController>();
  }

  @override
  void deactivate() {
    super.deactivate();
    Get.delete<CatalogPageController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        // color: Color(0xffF4F4F6),
        width: Get.width,
        child: Stack(
          children: [
            Column(
              children: [
                buildClassificationRow(),
                if (catalogPageController.showBrandsOrFamilies)
                  buildBrandsOrFamilySelection(),
                if (!catalogPageController.showBrandsOrFamilies)
                  buildAllMaterials(),
                if (catalogPageController.showBrandsPanel) buildBrandsPanel(),
                if (catalogPageController.showFamiliesPanel)
                  buildFamiliesPanel(),
                if (catalogPageController.showMaterialsByBrand)
                  buildMaterialsByBrand(),
                if (catalogPageController.showMaterialsByFamily)
                  buildMaterialsByFamily(),
              ],
            ),
            if (catalogPageController.overlayWidget.value != null)
              catalogPageController.overlayWidget.value!
          ],
        ),
      );
    });
  }

  Widget buildClassificationRow() {
    return Container(
        height: Get.width * 0.15,
        color: Colors.white,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: catalogPageController.getClassifications.map((e) {
                return GestureDetector(
                  onTap: () {
                    catalogPageController.selectedClassification.value = e;
                    catalogPageController.selectedBrand.value = null;
                    catalogPageController.selectedFamily.value = null;
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              catalogPageController.selectedClassification == e
                                  ? Color(0xff00458C)
                                  : Colors.grey,
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.04)),
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03,
                          vertical: Get.width * 0.015),
                      child: Text(
                        e.Display,
                        style: TextStyle(color: Colors.white),
                      )),
                );
              }).toList(),
            )));
  }

  Widget buildBrandsPanel() {
    return catalogPageController.brandsToShow.isNotEmpty
        ? Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: GridView.builder(
                cacheExtent: Get.height * 2,
                physics: BouncingScrollPhysics(),
                itemCount: catalogPageController.brandsToShow.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => catalogPageController.selectedBrand.value =
                          catalogPageController.brandsToShow[index],
                      child: BrandCard(
                        brand: catalogPageController.brandsToShow[index],
                      ));
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3),
              ),
            ),
          )
        : Container(
            child: Center(
              child: Text("No data"),
            ),
          );
  }

  Widget buildFamiliesPanel() {
    return catalogPageController.familiesToShow.isNotEmpty
        ? Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
              child: GridView.builder(
                cacheExtent: Get.height * 2,
                physics: BouncingScrollPhysics(),
                itemCount: catalogPageController.familiesToShow.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => catalogPageController.selectedFamily.value =
                          catalogPageController.familiesToShow[index],
                      child: FamiliesCard(
                        family: catalogPageController.familiesToShow[index],
                      ));
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Get.width * 0.5,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
              ),
            ),
          )
        : Container(
            child: Center(
              child: Text("No data"),
            ),
          );
  }

  Widget buildBrandsOrFamilySelection() {
    return Container(
        height: Get.width * 0.15,
        margin: EdgeInsets.only(left: Get.width * 0.04),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                catalogPageController.brandsOrFamilies.value = true;
                catalogPageController.selectedBrand.value = null;
                catalogPageController.selectedFamily.value = null;
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: catalogPageController.brandsOrFamilies.value
                          ? Color(0xff00458C)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(Get.width * 0.04)),
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03,
                      vertical: Get.width * 0.015),
                  child: Text(
                    'Brands',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            GestureDetector(
              onTap: () {
                catalogPageController.brandsOrFamilies.value = false;
                catalogPageController.selectedBrand.value = null;
                catalogPageController.selectedFamily.value = null;
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: !catalogPageController.brandsOrFamilies.value
                          ? Color(0xff00458C)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(Get.width * 0.04)),
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03,
                      vertical: Get.width * 0.015),
                  child: Text(
                    'Families',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Spacer(),
            if (catalogPageController.selectedBrand.value != null ||
                catalogPageController.selectedFamily.value != null)
              DropdownButton<Hierarchy>(
                underline: SizedBox(),
                value: catalogPageController.selectedHierarhy.value,
                icon: Icon(
                  Icons.arrow_downward,
                ),
                iconSize: 18,
                elevation: 16,
                isExpanded: false,
                onChanged: (newValue) {
                  catalogPageController.selectedHierarhy.value = newValue;
                },
                items: [
                  ...catalogPageController.getHierarchys
                      .map<DropdownMenuItem<Hierarchy>>((value) {
                    return DropdownMenuItem<Hierarchy>(
                      value: value,
                      child: Text(
                        value.Display,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }),
                  DropdownMenuItem<Hierarchy>(
                    value: null,
                    child: Text(
                      'All',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ].toList(),
              )
          ],
        ));
  }

  Widget buildAllMaterials() {
    return Expanded(
        child: ListView(
      physics: BouncingScrollPhysics(),
      cacheExtent: Get.height * 2,
      children: catalogPageController.getMaterials.map((e) {
        return MaterialCard(
          materiale: e,
        );
      }).toList(),
    ));
  }

  Widget buildMaterialsByBrand() {
    return Expanded(
      child: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          cacheExtent: Get.height * 2,
          children: catalogPageController.materialsByBrand.map((e) {
            return MaterialCard(
              materiale: e,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildMaterialsByFamily() {
    return Expanded(
      child: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          cacheExtent: Get.height * 2,
          children: catalogPageController.materialsByFamily.map((e) {
            return MaterialCard(
              materiale: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
