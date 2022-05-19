import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/presentation/controllers/search_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_controller.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.find();
  final MainScreeenHeaderController mainScreeenHeaderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white_F4F4F6,
      body: SafeArea(
        bottom: false,
        child: SizedBox.expand(
          child: Column(
            children: [
              buildHeader(context),
              Expanded(child: buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  Container buildHeader(BuildContext context) {
    return Container(
      height: Get.width * 0.3,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [MyColors.blue_0D63BB, MyColors.blue_00458C])),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  AssetImages.***REMOVED***Logo,
                  width: Get.width * 0.2,
                ),
              ),
              Hero(
                tag: 'contact_btn',
                child: Image.asset(
                  AssetImages.contactButton,
                  width: Get.width * 0.05,
                ),
              ),
            ],
          ),
          Spacer(),
          searchBar(),
          Spacer(),
        ],
      ),
    );
  }

  Row searchBar() {
    return Row(
      children: [
        // if (searchHasFocus)
        //   GestureDetector(
        //     onTap: () {
        //       searchFocusNode.unfocus();
        //       mainScreeenHeaderController.hide();
        //     },
        //     child: Container(
        //       decoration: BoxDecoration(
        //           color: Colors.white.withOpacity(0.8),
        //           borderRadius: BorderRadius.circular(Get.width * 0.1)),
        //       width: Get.width * 0.1,
        //       height: Get.width * 0.1,
        //       child: Icon(Icons.close),
        //     ),
        //   ),
        // if (searchHasFocus)
        SizedBox(
          width: Get.width * 0.015,
        ),

        Expanded(
          child: Container(
            height: Get.width * 0.1,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(Get.width * 0.1)),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Image.asset(
                  'assets/icons/search.png',
                  width: Get.width * 0.04,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Expanded(
                    child: TextField(
                  key: Key('searchproduct'),
                  controller: searchController.textEditingController,
                  // focusNode: searchFocusNode,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    //isDense: true,
                    alignLabelWithHint: true,

                    labelText: 'Search product'.tr,
                    labelStyle:
                        TextStyle(color: MyColors.blue_00458C, fontSize: 16),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                )),
                Image.asset(
                  'assets/icons/barcode.png',
                  width: Get.width * 0.06,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Obx buildBody() {
    return Obx(() => Column(
          children: [
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
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${'Found'.tr}: ' +
                                searchController.findedMaterials.length
                                    .toString() +
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
            if (searchController.findedMaterials.isEmpty &&
                searchController.findedSimilarMaterials.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(Get.width * 0.05),
                child: Text(
                  'No results were found for this product but we have similar products'
                      .tr,
                  style: TextStyle(
                      color: Colors.black, fontSize: Get.width * 0.04),
                ),
              ),
            // Obx(() => Expanded(
            //     child: ListView(
            //         children: searchController.findedMaterials
            //             .map((element) => MaterialCard(
            //                   materiale: element,
            //                 ))
            //             .toList()))),
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
                      color: Colors.black, fontSize: Get.width * 0.04),
                ),
              ),

            if (searchController.findedMaterials.isEmpty &&
                searchController.findedSimilarMaterials.isNotEmpty)
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
        ));
  }
}
