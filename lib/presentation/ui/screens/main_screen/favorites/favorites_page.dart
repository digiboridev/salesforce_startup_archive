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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          GestureDetector(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('asdasd'),
          )),
        ],
      ),
    );
  }
}
