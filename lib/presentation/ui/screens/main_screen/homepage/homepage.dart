import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final MaterialsCatalog materialsCatalog;

  HomePage({
    Key? key,
    required this.materialsCatalog,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ConnectionService connectionService = Get.find();

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  List<Materiale> get getRecomendedProducts {
    return widget.materialsCatalog.materials
        .where((element) => element.IsRecommended)
        .toList();
  }

  List<Materiale> get getMissingProducts {
    return widget.materialsCatalog.materials
        .where((element) => element.RecommendationType == 5)
        .toList();
  }

  List<Materiale> get getNewProducts {
    return widget.materialsCatalog.materials
        .where((element) => element.IsNew)
        .toList();
  }

  List<Materiale> get getDeals {
    return widget.materialsCatalog.materials
        .where((element) => element.IsHotSale)
        .toList();
  }

  Widget buildBody() {
    return Container(
      width: Get.width,
      // color: Colors.white,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            buildIItemsRow(
                materials: getRecomendedProducts.take(4).toList(),
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recomended for you',
                      style: TextStyle(
                        fontSize: Get.width * 0.045,
                      ),
                    ),
                    Text(
                      'All recomended',
                      style: TextStyle(
                          fontSize: Get.width * 0.045, color: Colors.blue),
                    ),
                  ],
                )),
            SizedBox(
              height: Get.width * 0.06,
            ),
            buildIItemsRow(
                materials: getNewProducts.take(4).toList(),
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Products',
                      style: TextStyle(
                        fontSize: Get.width * 0.045,
                      ),
                    ),
                    Text(
                      'To all newcomers',
                      style: TextStyle(
                          fontSize: Get.width * 0.045, color: Colors.blue),
                    ),
                  ],
                )),
            SizedBox(
              height: Get.width * 0.06,
            ),
            buildIItemsRow(
                materials: getMissingProducts.take(4).toList(),
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'You may be missing',
                      style: TextStyle(
                        fontSize: Get.width * 0.045,
                      ),
                    ),
                    Text(
                      'List of deficiencies',
                      style: TextStyle(
                          fontSize: Get.width * 0.045, color: Colors.blue),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget buildIItemsRow(
      {required List<Materiale> materials, required Widget header}) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: Get.width * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: header,
          ),
          SizedBox(
            height: Get.width * 0.02,
          ),
          Divider(),
          SizedBox(
            height: Get.width * 0.02,
          ),
          SizedBox(
            width: Get.width,
            child: Wrap(
              runSpacing: Get.width * 0.05,
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.spaceEvenly,
              children: materials.map((e) {
                return Container(
                  height: Get.width / 2,
                  width: Get.width * 0.42,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: Get.width * 0.03)
                      ]),
                  child: Column(
                    children: [
                      CachedImage(
                          Url: e.ImageUrl,
                          width: Get.width * 0.3,
                          height: Get.width * 0.3),
                      Expanded(
                          child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(Get.width * 0.02),
                          child: Text(
                            e.Name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Get.width * 0.035,
                                color: MyColors.blue_0050A2),
                          ),
                        ),
                      ))
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          )
        ],
      ),
    );
  }
}
