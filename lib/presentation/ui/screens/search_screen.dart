import 'package:***REMOVED***/presentation/controllers/search_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/catalog/material_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF4F4F6),
      child: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(
              height: Get.width * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search results',
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
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Found: ' +
                          searchController.findedMaterials.length.toString() +
                          ' Results of ' +
                          searchController.textEditingController.text,
                      style: TextStyle(
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                  ),
                )),
            Obx(() => Expanded(
                  child: ListView(
                    children: searchController.findedMaterials
                        .map((element) => MaterialCard(
                              materiale: element,
                            ))
                        .toList(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
