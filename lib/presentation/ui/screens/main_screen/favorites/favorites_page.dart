import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/favorites/favorites_page_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesPage extends StatelessWidget {
  final MaterialsCatalogController materialsCatalogController = Get.find();
  final FavoritesPageController favoritesPageController =
      Get.put(FavoritesPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Favorites'.tr,
                  style: TextStyle(fontSize: 24, color: MyColors.blue_003E7E),
                ),
                GestureDetector(
                  onTap: () => favoritesPageController.showAddNewList(),
                  child: Image.asset(
                    AssetImages.favorites_list,
                    width: Get.width * 0.06,
                    height: Get.width * 0.06,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.width * 0.01,
          ),
          buildListsRow(),
          SizedBox(
            height: Get.width * 0.01,
          ),
          Expanded(
            child: Container(
              child: buildItemsList(),
            ),
          )
        ],
      ),
    );
  }

  Padding buildListControll() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  AssetImages.favorites_cart,
                  width: Get.width * 0.07,
                  height: Get.width * 0.07,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                    child: Text(
                      "Add the entire list to cart".tr,
                      style:
                          TextStyle(color: MyColors.blue_003E83, fontSize: 14),
                    ))
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                    child: Image.asset(
                      AssetImages.favorites_sort,
                      width: Get.width * 0.06,
                      height: Get.width * 0.06,
                    )),
                Text(
                  "Sorting".tr,
                  style: TextStyle(color: MyColors.blue_003E83, fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemsList() {
    return Obx(() {
      MaterialsCatalogState mcState =
          materialsCatalogController.materialsCatalogState.value;

      if (mcState is MCSCommon) {
        if (favoritesPageController.materialsToShow.isEmpty) {
          return buildNoProducts();
        }

        return Column(
          children: [
            buildListControll(),
            SizedBox(
              height: Get.width * 0.01,
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: Get.width * 0.05,
                  ),
                  ...favoritesPageController.materialsToShow.map((material) {
                    return Column(
                      children: [
                        MaterialCard(
                          materiale: material,
                          insideFavorites: true,
                        ),
                      ],
                    );
                  }).toList(),
                  SizedBox(
                    height: Get.width * 0.2,
                  )
                ],
              ),
            ),
          ],
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget buildListsRow() {
    return Obx(() => Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              height: Get.width * 0.15,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      listTile(
                          onTap: () =>
                              favoritesPageController.selectRecomended(),
                          isSelected:
                              favoritesPageController.recomendedListSelected,
                          name: 'Recomended List'.tr,
                          count: favoritesPageController
                              .recomendedMaterials.length),
                      ...favoritesPageController.favoriteLists.map((e) {
                        return listTile(
                            onTap: () => favoritesPageController.selectList(
                                index: favoritesPageController.favoriteLists
                                    .indexOf(e)),
                            isSelected:
                                favoritesPageController.selectedListIndex ==
                                    favoritesPageController.favoriteLists
                                        .indexOf(e),
                            name: e.listName,
                            count: e.favoriteItems.length);
                      }).toList()
                    ],
                  )))
        ]));
  }

  Widget listTile({
    required Function onTap,
    required bool isSelected,
    required String name,
    required int count,
  }) {
    return GestureDetector(
        onTap: () => onTap(),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: isSelected
                            ? Color(0xff00458C)
                            : Color(0xff00458C).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(Get.width * 0.04)),
                    margin: EdgeInsets.only(
                        left: Get.width * 0.01,
                        right: Get.width * 0.01,
                        top: 10),
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.035,
                        vertical: Get.width * 0.025),
                    child: Text(name,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : Color(0xff003E7E),
                        )))
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: MyColors.blue_00458C)),
              child: Text(
                "${count}",
                style: TextStyle(fontSize: 12, color: MyColors.blue_00458C),
              ),
            ),
          ],
        ));
  }

  Widget buildNoProducts() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.06,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Get.width * 0.05, horizontal: Get.width * 0.05),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.blue_003E7E),
                  child: Image.asset(
                    AssetImages.no_products,
                    height: Get.width * 0.06,
                    width: Get.width * 0.8,
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Text(
                  "No product transfer yet To this list".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyColors.blue_003E7E, fontSize: Get.width * 0.06),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Text(
                  "Save your products on the page Favorites by clicking on -"
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyColors.blue_003E7E, fontSize: Get.width * 0.04),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Get.width * 0.025,
                      horizontal: Get.width * 0.025),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.blue_003E7E),
                  child: Image.asset(AssetImages.favorite_no_product),
                  height: Get.width * 0.09,
                  width: Get.width * 0.1,
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Text(
                  "On the favorites page, click on -".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyColors.blue_003E7E, fontSize: Get.width * 0.04),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Get.width * 0.025,
                      horizontal: Get.width * 0.025),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: MyColors.blue_003E7E),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: Get.width * 0.04,
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Text(
                  "Let you move the\nproduct\nTo one of the lists you opened"
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyColors.blue_003E7E, fontSize: Get.width * 0.04),
                ),
                SizedBox(
                  height: Get.width * 0.03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetImages.deleted_list,
                      width: Get.width * 0.03,
                      height: Get.width * 0.03,
                    ),
                    Text(
                      "Delete the list".tr,
                      style: TextStyle(
                          color: MyColors.blue_00458C,
                          fontSize: Get.width * 0.03,
                          decoration: TextDecoration.underline),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.width * 0.35,
                ),
              ],
            ))
      ],
    );
  }

  Widget buildHaveNewList() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05, vertical: Get.width * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.width * 0.05),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  gradient: LinearGradient(
                      colors: [MyColors.green_49D84C, MyColors.green_37C33A])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AssetImages.have_new_list,
                    width: Get.width * 0.07,
                    height: Get.width * 0.07,
                  ),
                  Text(
                    "Good, you've made a new list!".tr,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Image.asset(
                    AssetImages.have_new_list,
                    width: Get.width * 0.07,
                    height: Get.width * 0.07,
                  ),
                ],
              )),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Container(
            margin: EdgeInsets.only(bottom: Get.width * 0.1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Breakfast Products",
                  style: TextStyle(
                      color: MyColors.blue_003E7E,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Get.width * 0.05,
                ),
                Text(
                    "To fill out the list click on the three points on the left side of the product"
                        .tr,
                    style: TextStyle(
                      color: MyColors.blue_003E7E,
                      fontSize: 16,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
