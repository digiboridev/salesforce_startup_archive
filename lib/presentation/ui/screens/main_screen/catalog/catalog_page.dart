import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/brand.dart';
import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/brand_card.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/catalog_page_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/families_card.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  // Init and dispose controller manualy due inherited routing
  @override
  void initState() {
    super.initState();
    catalogPageController = Get.put(
        CatalogPageController(materialsCatalog: widget.materialsCatalog));
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
        child: Stack(
          children: [
            Column(
              children: [
                buildClassificationRow(),
                AnimatedCrossFade(
                    firstChild: SizedBox(),
                    secondChild: buildBrandsOrFamilySelection(),
                    crossFadeState:
                        catalogPageController.state is ShowAllMaterials
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 300)),
                Expanded(
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.easeOut,
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
            buildFilterOverlay()
          ],
        ),
      );
    });
  }

  Builder buildFilterOverlay() {
    return Builder(builder: (context) {
      CatalogPageState state = catalogPageController.state;
      if (state is HierarhableMaterials && state.showFilter) {
        return Container(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Get.width * 0.03),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: Get.width * 0.01,
                    blurRadius: Get.width * 0.03)
              ],
            ),
            margin: EdgeInsets.only(
                top: Get.width * 0.18,
                left: Get.width * 0.06,
                right: Get.width * 0.06,
                bottom: Get.width * 0.3),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03, vertical: Get.width * 0.02),
                  child: Row(
                    children: [
                      Text(
                        'Filter by'.tr,
                        style: TextStyle(
                            color: MyColors.blue_003E7E,
                            fontSize: Get.width * 0.04),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => catalogPageController.onFilterClick(),
                        child: Icon(
                          Icons.close_rounded,
                          color: MyColors.blue_003E7E,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: state.avaliableHierarhys.map((e) {
                      return Builder(builder: (context) {
                        bool selected = false;
                        CatalogPageState state = catalogPageController.state;
                        if (state is HierarhableMaterials) {
                          if (state.hierarhyFilter == e) {
                            selected = true;
                          }
                        }

                        return GestureDetector(
                          onTap: () => catalogPageController
                              .changeHierarhyFilter(hierarchy: e),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.03,
                                vertical: Get.width * 0.02),
                            child: Text(
                              e.Display,
                              style: TextStyle(
                                  color: selected
                                      ? Colors.blue
                                      : MyColors.blue_003E7E,
                                  fontSize: Get.width * 0.036),
                            ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }

  Widget get content {
    CatalogPageState state = catalogPageController.state;
    if (state is ShowAllMaterials) {
      return buildAllMaterials(materials: state.materials);
    }
    if (state is ShowBrands) {
      return buildBrandsPanel(brands: state.brands);
    }

    if (state is ShowFamilies) {
      return buildFamiliesPanel(families: state.families);
    }

    if (state is ShowMaterialsByBrand) {
      return buildMaterialsByBrand(
          materials: state.materialsByFilter, brand: state.brand);
    }

    if (state is ShowMaterialsByFamily) {
      return buildMaterialsByFamily(
          materials: state.materialsByFilter, family: state.family);
    }

    return SizedBox();
  }

  Widget buildClassificationRow() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025),
        height: Get.width * 0.15,
        color: Colors.white,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: catalogPageController.getClassifications.map((e) {
                return GestureDetector(
                  onTap: () => catalogPageController.onClassificationClick(
                      classification: e),
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              catalogPageController.selectedClassification == e
                                  ? MyColors.blue_00458C
                                  : MyColors.blue_00458C.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.04)),
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03,
                          vertical: Get.width * 0.015),
                      child: Text(
                        e.Display,
                        style: TextStyle(
                            color:
                                catalogPageController.selectedClassification ==
                                        e
                                    ? Colors.white
                                    : MyColors.blue_003E7E),
                      )),
                );
              }).toList(),
            )));
  }

  Widget buildBrandsPanel({required List<Brand> brands}) {
    return brands.isNotEmpty
        ? Container(
            key: Key('BrandsPanel'),
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            child: GridView.builder(
              cacheExtent: Get.height * 2,
              physics: BouncingScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => catalogPageController.onBrandSelect(
                        brand: brands[index]),
                    child: BrandCard(
                      brand: brands[index],
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
              child: Text("No data".tr),
            ),
          );
  }

  Widget buildFamiliesPanel({required List<Family> families}) {
    return families.isNotEmpty
        ? Container(
            key: Key('FamiliesPanel'),
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            child: GridView.builder(
              cacheExtent: Get.height * 2,
              physics: BouncingScrollPhysics(),
              itemCount: families.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => catalogPageController.onFamilySelect(
                        family: families[index]),
                    child: FamiliesCard(
                      family: families[index],
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
              child: Text("No data".tr),
            ),
          );
  }

  Widget buildBrandsOrFamilySelection() {
    return Container(
        key: Key('BrandsOrFamilySelection'),
        height: Get.width * 0.15,
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.025),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => catalogPageController.showBrands(),
              child: Container(
                  decoration: BoxDecoration(
                      color: catalogPageController.state is ShowBrands ||
                              catalogPageController.state
                                  is ShowMaterialsByBrand
                          ? MyColors.blue_00458C
                          : MyColors.blue_00458C.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(Get.width * 0.04)),
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03,
                      vertical: Get.width * 0.015),
                  child: Text(
                    'Brands'.tr,
                    style: TextStyle(
                        color: catalogPageController.state is ShowBrands ||
                                catalogPageController.state
                                    is ShowMaterialsByBrand
                            ? Colors.white
                            : MyColors.blue_003E7E),
                  )),
            ),
            GestureDetector(
              onTap: () => catalogPageController.showFamilies(),
              child: Container(
                  decoration: BoxDecoration(
                      color: catalogPageController.state is ShowFamilies ||
                              catalogPageController.state
                                  is ShowMaterialsByFamily
                          ? MyColors.blue_00458C
                          : MyColors.blue_00458C.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(Get.width * 0.04)),
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03,
                      vertical: Get.width * 0.015),
                  child: Text(
                    'Families'.tr,
                    style: TextStyle(
                        color: catalogPageController.state is ShowFamilies ||
                                catalogPageController.state
                                    is ShowMaterialsByFamily
                            ? Colors.white
                            : MyColors.blue_003E7E),
                  )),
            ),
            Spacer(),
            Builder(builder: (context) {
              CatalogPageState state = catalogPageController.state;
              if (state is HierarhableMaterials &&
                  state.avaliableHierarhys.isNotEmpty) {
                return GestureDetector(
                    onTap: () {
                      catalogPageController.onFilterClick();
                    },
                    child: Text(state.hierarhyFilter != null
                        ? state.hierarhyFilter!.Display
                        : 'Filtering'.tr));
              } else {
                return SizedBox();
              }
            }),
            SizedBox(
              width: Get.width * 0.06,
            )
          ],
        ));
  }

  Widget buildAllMaterials({required List<Materiale> materials}) {
    return Container(
      key: Key('AllMaterials'),
      child: ListView(
        physics: BouncingScrollPhysics(),
        cacheExtent: Get.height * 2,
        children: materials.map((e) {
          return MaterialCard(
            materiale: e,
          );
        }).toList(),
      ),
    );
  }

  Widget buildMaterialsByBrand(
      {required List<Materiale> materials, required Brand brand}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
              child: CachedImage(
                  Url: brand.ImageUrl,
                  width: Get.width * 0.15,
                  height: Get.width * 0.15)),
          Expanded(
            child: materials.isEmpty
                ? Center(
                    child: Text('No materials'.tr),
                  )
                : ListView(
                    physics: BouncingScrollPhysics(),
                    cacheExtent: Get.height * 2,
                    children: materials.map((e) {
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

  Widget buildMaterialsByFamily(
      {required List<Materiale> materials, required Family family}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025),
              child: Row(
                children: [
                  CachedImage(
                      Url: family.ImageUrl,
                      width: Get.width * 0.15,
                      height: Get.width * 0.15),
                  Text(
                    family.Display,
                    style: TextStyle(color: MyColors.blue_003E7E, fontSize: 24),
                  )
                ],
              )),
          Expanded(
            child: materials.isEmpty
                ? Center(
                    child: Text('No materials'.tr),
                  )
                : ListView(
                    physics: BouncingScrollPhysics(),
                    cacheExtent: Get.height * 2,
                    children: materials.map((e) {
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
