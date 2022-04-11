import 'package:***REMOVED***/domain/entities/materials/brand.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/colors.dart';

class BrandCard extends StatefulWidget {
  final Brand brand;
  BrandCard({required this.brand});

  @override
  State<StatefulWidget> createState() => BrandCardState();
}

class BrandCardState extends State<BrandCard> {
  late Brand brand;
  @override
  void initState() {
    brand = widget.brand;
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
            Url: brand.ImageUrl,
            width: Get.width * 0.15,
            height: Get.width * 0.15,
          ),
          SizedBox(
            height: Get.width * 0.01,
          ),
          Expanded(
            child: Center(
              child: Text(
                brand.Display,
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
