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
        width: Get.width,
        child: Column(
          children: [
            buildClassificationRow(),
            AnimatedCrossFade(
                firstChild: buildBrandsOrFamilySelection(),
                secondChild: SizedBox(),
                crossFadeState: catalogPageController.showBrandsOrFamilies
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 300)),
            Expanded(
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeOut,
                key: Key('asd'),
                duration: Duration(milliseconds: 300),
                child: content,
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation);
                  return ClipRect(
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget get content {
    if (catalogPageController.showBrandsPanel) return buildBrandsPanel();
    if (catalogPageController.showFamiliesPanel) return buildFamiliesPanel();
    if (catalogPageController.showMaterialsByBrand)
      return buildMaterialsByBrand();
    if (catalogPageController.showMaterialsByFamily)
      return buildMaterialsByFamily();
    return buildAllMaterials();
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
        ? Container(
            key: UniqueKey(),
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
          )
        : Container(
            child: Center(
              child: Text("No data"),
            ),
          );
  }

  Widget buildFamiliesPanel() {
    return catalogPageController.familiesToShow.isNotEmpty
        ? Container(
            key: UniqueKey(),
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
          )
        : Container(
            child: Center(
              child: Text("No data"),
            ),
          );
  }

  Widget buildBrandsOrFamilySelection() {
    return Container(
        key: UniqueKey(),
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
    return Container(
      key: UniqueKey(),
      child: ListView(
        physics: BouncingScrollPhysics(),
        cacheExtent: Get.height * 2,
        children: catalogPageController.getMaterials.map((e) {
          return MaterialCard(
            materiale: e,
          );
        }).toList(),
      ),
    );
  }

  Widget buildMaterialsByBrand() {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          CachedImage(
              Url: catalogPageController.selectedBrand.value!.ImageUrl,
              width: Get.width * 0.15,
              height: Get.width * 0.15),
          Expanded(
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
        ],
      ),
    );
  }

  Widget buildMaterialsByFamily() {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          CachedImage(
              Url: catalogPageController.selectedFamily.value!.ImageUrl,
              width: Get.width * 0.15,
              height: Get.width * 0.15),
          Expanded(
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
        ],
      ),
    );
  }
}
