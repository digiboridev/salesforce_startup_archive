import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:***REMOVED***/domain/entities/materials/hierarchy.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
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
    Get.delete<CatalogPageController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        // color: Color(0xffF4F4F6),
        width: Get.width,
        child: Column(
          children: [
            buildClassificationRow(),
            if (catalogPageController.showBrandsOrFamilies)
              buildBrandsOrFamilySelection(),
            if (!catalogPageController.showBrandsOrFamilies)
              buildAllMaterials(),
            if (catalogPageController.showBrandsPanel) buildBrandsPanel(),
            if (catalogPageController.showFamiliesPanel) buildFamiliesPanel(),
            if (catalogPageController.showMaterialsByBrand)
              buildMaterialsByBrand(),
            if (catalogPageController.showMaterialsByFamily)
              buildMaterialsByFamily(),
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

  Widget buildFamiliesPanel() {
    return Expanded(
      child: Container(
        child: ListView(
          children: catalogPageController.familiesToShow.map((e) {
            return GestureDetector(
              onTap: () => catalogPageController.selectedFamily.value = e,
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

class MaterialCard extends StatelessWidget {
  final Materiale materiale;
  const MaterialCard({
    Key? key,
    required this.materiale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
          bottom: Get.width * 0.025,
          left: Get.width * 0.025,
          top: Get.width * 0.05,
          right: Get.width * 0.05),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(
                height: Get.width * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Get.width * 0.01),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 20)
                          ]),
                      child: CachedImage(
                        Url: materiale.ImageUrl,
                        width: Get.width * 0.25,
                        height: Get.width * 0.25,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Expanded(child: Text(materiale.Name)),
                  ],
                ),
              ),
              SizedBox(
                height: Get.width * 0.05,
              ),
              Text('Recomended'),
              SizedBox(
                height: Get.width * 0.05,
              ),
            ],
          ),
          Positioned(
            top: -(Get.width * 0.025),
            right: -(Get.width * 0.025),
            child: Container(
              width: Get.width * 0.1,
              height: Get.width * 0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Get.width * 0.1)),
              child: Icon(Icons.heart_broken_sharp),
            ),
          )
        ],
      ),
    );
  }
}
