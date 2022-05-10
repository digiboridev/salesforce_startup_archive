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

  int? selectedListIndex;

  @override
  void initState() {
    super.initState();
    if (widget.favoriteLists.isNotEmpty) {
      selectedListIndex = 0;
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
              children: [Text('Favorites'), Icon(Icons.abc)],
            ),
          ),
          SizedBox(
            height: Get.width * 0.01,
          ),
          buildListsRow(),
          GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('asdasd'),
              )),
          Expanded(
              child: Container(
            color: Colors.red,
          ))
        ],
      ),
    );
  }

  Widget buildListsRow() {
    return Container(
        height: Get.width * 0.15,
        color: Colors.white,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.favoriteLists.map((e) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedListIndex = widget.favoriteLists.indexOf(e);
                    });
                  },
                  child: Container(
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
                          vertical: Get.width * 0.015),
                      child: Text(e.listName,
                          style: TextStyle(
                            color: selectedListIndex ==
                                    widget.favoriteLists.indexOf(e)
                                ? Colors.white
                                : Color(0xff003E7E),
                          ))),
                );
              }).toList(),
            )));
  }
}
