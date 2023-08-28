import 'dart:ui';

import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/domain/entities/favorites/favorite_item.dart';
import 'package:salesforce.startup/domain/entities/favorites/favorite_list.dart';
import 'package:salesforce.startup/domain/entities/materials/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BelongList extends StatefulWidget {
  BelongList({
    Key? key,
    required this.favoriteLists,
    required this.material,
  }) : super(key: key);

  final List<FavoriteList> favoriteLists;
  final Materiale material;

  @override
  State<BelongList> createState() => _BelongListState();
}

class _BelongListState extends State<BelongList> {
  late final List<FavoriteList> editableFavList;

  @override
  void initState() {
    editableFavList = widget.favoriteLists
        .map((e) => FavoriteList(
            favoriteItems: e.favoriteItems
                .map((e) => FavoriteItem(
                      materialNumber: e.materialNumber,
                      quantity: e.quantity,
                      sFId: e.sFId,
                      unit: e.unit,
                    ))
                .toList(),
            sFId: e.sFId,
            isAllList: e.isAllList,
            listName: e.listName))
        .toList();

    super.initState();
  }

  save() {
    Get.back(result: editableFavList);
  }

  remove() {
    editableFavList.forEach((l) {
      l.favoriteItems.removeWhere((fi) => fi.materialNumber == widget.material.MaterialNumber);
    });
    Get.back(result: editableFavList);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        width: Get.width,
        // height: Get.width * 3,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 10)],
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(Get.width * 0.06), topRight: Radius.circular(Get.width * 0.06))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.width * 0.05),
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text(
                    "Belongs on the list".tr,
                    style: TextStyle(color: MyColors.blue_003E7E, fontSize: 24),
                  ),
                  Text(
                    widget.material.Name,
                    style: TextStyle(color: MyColors.blue_003E7E, fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: Get.width,
                      child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 5,
                          runSpacing: 10,
                          children: editableFavList.map((e) {
                            bool materialInside = e.favoriteItems.map((e) => e.materialNumber).contains(widget.material.MaterialNumber);

                            return Row(mainAxisSize: MainAxisSize.min, children: [
                              GestureDetector(
                                onTap: () {
                                  if (materialInside) {
                                    setState(() {
                                      e.favoriteItems.removeWhere((element) => element.materialNumber == widget.material.MaterialNumber);
                                    });
                                  } else {
                                    setState(() {
                                      e.favoriteItems.add(FavoriteItem(
                                          materialNumber: widget.material.MaterialNumber,
                                          sFId: widget.material.SFId,
                                          unit: widget.material.SalesUnit,
                                          quantity: widget.material.MinimumOrderQuantity));
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.04)),
                                      border: Border.all(
                                          width: Get.width / Get.width, color: materialInside ? MyColors.blue_00458C : MyColors.blue_00458C.withOpacity(0.25))),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: Text("${e.listName}", style: TextStyle(fontSize: 16, color: MyColors.blue_00458C)),
                                ),
                              ),
                            ]);
                          }).toList())),
                ])),
            SizedBox(
              height: 43,
            ),
            Container(
              height: Get.width * 0.2,
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              color: MyColors.blue_E8EEF6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: save,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: Get.width * 0.025),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Get.width * 0.06),
                        color: MyColors.blue_00458C,
                      ),
                      child: Text(
                        "Save".tr,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: remove,
                    child: Row(
                      children: [
                        Image.asset(
                          AssetImages.deleted_list,
                          color: Colors.red,
                          width: Get.width * 0.07,
                          height: Get.width * 0.07,
                        ),
                        Text(
                          "Remove from favorites",
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
