import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/unit_types.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:***REMOVED***/presentation/ui/widgets/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:***REMOVED***/domain/entities/favorites/favorite_list.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';

class FavoritesPage extends StatefulWidget {
  final List<FavoriteList> favoriteLists;

  FavoritesPage({
    Key? key,
    required this.favoriteLists,
  }) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final CustomerController customerController = Get.find();
  final MaterialsCatalogController materialsCatalogController = Get.find();
  final FavoritesController favoritesController = Get.find();

  int? selectedListIndex;

  @override
  void initState() {
    super.initState();
    if (widget.favoriteLists.isNotEmpty) {
      selectedListIndex = 0;
    }
  }

  FavoriteList? get selectedList {
    if (selectedListIndex is int) {
      widget.favoriteLists.elementAt(selectedListIndex!);
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant FavoritesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (selectedListIndex != null) {
      if (selectedListIndex! > widget.favoriteLists.length - 1) {
        if (widget.favoriteLists.isNotEmpty) {
          selectedListIndex = 0;
        } else {
          selectedListIndex = null;
        }
      }
    }
  }

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
                Text('Favorites'),
                GestureDetector(
                    onTap: () => Get.snackbar('Error', 'Not implemented'),
                    child: Icon(Icons.abc))
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
          selectedListIndex is int
              ? Expanded(
                  child: Column(
                    children: [
                      buildListControll(),
                      SizedBox(
                        height: Get.width * 0.01,
                      ),
                      Expanded(
                          child: Container(
                        child: buildItemsList(),
                      )),
                    ],
                  ),
                )
              : Expanded(
                  child: Center(
                  child: Text('Select list'),
                ))
        ],
      ),
    );
  }

  Padding buildListControll() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () => Get.snackbar('Error', 'Not implemented'),
              child: Text('Add the entire list to cart')),
          GestureDetector(
              onTap: () => Get.snackbar('Error', 'Not implemented'),
              child: Icon(Icons.sort))
        ],
      ),
    );
  }

  Widget buildItemsList() {
    return Obx(() {
      MaterialsCatalogState mcState =
          materialsCatalogController.materialsCatalogState.value;

      if (mcState is MCSCommon) {
        FavoriteList listToShow =
            widget.favoriteLists.elementAt(selectedListIndex!);

        if (listToShow.favoriteItems.isEmpty) {
          return Center(
            child: Text('Empty list'),
          );
        }

        return ListView(
          physics: BouncingScrollPhysics(),
          children: listToShow.favoriteItems.map((e) {
            Materiale? m = mcState.catalog.materials.firstWhereOrNull(
              (element) => element.MaterialNumber == e.materialNumber,
            );

            if (m is Materiale) {
              return MaterialCard(
                materiale: m,
                insideFavorites: true,
              );
            } else {
              return Text('INVALID MATERIAL');
            }
          }).toList(),
        );
      } else {
        return Center(
          child: Text('Waiting catalog'),
        );
      }
    });
  }

  Widget buildListsRow() {
    return Container(
        height: Get.width * 0.075,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: widget.favoriteLists.map((e) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedListIndex = widget.favoriteLists.indexOf(e);
                });
              },
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: selectedListIndex ==
                                  widget.favoriteLists.indexOf(e)
                              ? Color(0xff00458C)
                              : Color(0xff00458C).withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.04)),
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                      ),
                      alignment: Alignment.center,
                      child: Text(e.listName,
                          style: TextStyle(
                            color: selectedListIndex ==
                                    widget.favoriteLists.indexOf(e)
                                ? Colors.white
                                : Color(0xff003E7E),
                          ))),
                  Positioned.fill(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          color: Colors.yellow,
                          child: Text(e.favoriteItems.length.toString())),
                    ],
                  ))
                ],
              ),
            );
          }).toList(),
        ));
  }
}
