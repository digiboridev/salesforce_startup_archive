import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';

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

  @override
  void initState() {
    super.initState();
    catalogPageController = Get.put(
        CatalogPageController(materialsCatalog: widget.materialsCatalog));
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CatalogPageController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Color(0xffF4F4F6),
        width: Get.width,
        child: Column(
          children: [
            Container(
                height: Get.width * 0.15,
                color: Colors.white,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children:
                          catalogPageController.getClassifications.map((e) {
                        return GestureDetector(
                          onTap: () {
                            catalogPageController.selectedClassification.value =
                                e;
                            catalogPageController.selectedBrand.value = null;
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: catalogPageController
                                              .selectedClassification ==
                                          e
                                      ? Color(0xff00458C)
                                      : Colors.grey,
                                  borderRadius:
                                      BorderRadius.circular(Get.width * 0.04)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.01),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.03,
                                  vertical: Get.width * 0.015),
                              child: Text(
                                e.Display,
                                style: TextStyle(color: Colors.white),
                              )),
                        );
                      }).toList(),
                    ))),
            if (catalogPageController.showBrandsOrFamilies)
              buildBrandsOrFamilySelection(),
            if (!catalogPageController.showBrandsOrFamilies)
              buildAllMaterials(),
            if (catalogPageController.showBrandsPanel) buildBrandsPanel(),
            if (catalogPageController.showMaterialsByBrand)
              buildMaterialsByBrand(),
          ],
        ),
      );
    });
  }

  Widget buildMaterialsByBrand() {
    return Expanded(
      child: Container(
        child: ListView(
          children: catalogPageController.materialsByBrand.map((e) {
            return GestureDetector(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(Get.width * 0.06),
                  margin: EdgeInsets.all(Get.width * 0.01),
                  child: Text(e.Name)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildBrandsPanel() {
    return Expanded(
      child: Container(
        child: ListView(
          children: catalogPageController.brandsToShow.map((e) {
            return GestureDetector(
              onTap: () => catalogPageController.selectedBrand.value = e,
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(Get.width * 0.06),
                  margin: EdgeInsets.all(Get.width * 0.01),
                  child: Text(e.Display)),
            );
          }).toList(),
        ),
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
              onTap: () => catalogPageController.brandsOrFamilies.value = true,
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
              onTap: () => catalogPageController.brandsOrFamilies.value = false,
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
          ],
        ));
  }

  Widget buildAllMaterials() {
    return Expanded(
        child: Container(
      height: Get.width * 0.1,
      color: Colors.red,
      alignment: Alignment.center,
      child: Text(
          'List length ' + widget.materialsCatalog.materials.length.toString()),
    ));
  }
}
