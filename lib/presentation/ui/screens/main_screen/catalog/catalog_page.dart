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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          Container(
            height: Get.width * 0.1,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text('brands'),
          ),
          Expanded(
              child: Container(
            height: Get.width * 0.1,
            color: Colors.red,
            alignment: Alignment.center,
            child: Text('List length ' +
                widget.materialsCatalog.materials.length.toString()),
          ))
        ],
      ),
    );
  }
}
