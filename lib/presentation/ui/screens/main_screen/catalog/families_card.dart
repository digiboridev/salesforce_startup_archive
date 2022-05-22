import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/entities/materials/family.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamiliesCard extends StatefulWidget {
  final Family family;
  FamiliesCard({required this.family});
  @override
  State<StatefulWidget> createState() => FamiliesCardState();
}

class FamiliesCardState extends State<FamiliesCard> {
  late Family family;
  @override
  void initState() {
    family = widget.family;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Get.width * 0.04))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedImage(
            Url: family.ImageUrl,
            width: Get.width * 0.15,
            height: Get.width * 0.15,
          ),
          SizedBox(
            height: Get.width * 0.02,
          ),
          Expanded(
            child: Center(
              child: Text(
                family.Display,
                style: TextStyle(color: MyColors.blue_003E7E, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
