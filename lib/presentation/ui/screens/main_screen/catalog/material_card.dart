import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialCard extends StatelessWidget {
  final Materiale materiale;
  const MaterialCard({
    Key? key,
    required this.materiale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
          bottom: Get.width * 0.025,
          left: Get.width * 0.025,
          top: Get.width * 0.05,
          right: Get.width * 0.05),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              SizedBox(
                height: Get.width * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Get.width * 0.01),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 20)
                          ]),
                      child: CachedImage(
                        Url: materiale.ImageUrl,
                        width: Get.width * 0.25,
                        height: Get.width * 0.25,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Expanded(child: Text(materiale.Name)),
                  ],
                ),
              ),
              SizedBox(
                height: Get.width * 0.05,
              ),
              Text('Recomended'),
              SizedBox(
                height: Get.width * 0.05,
              ),
            ],
          ),
          Positioned(
            top: -(Get.width * 0.025),
            right: -(Get.width * 0.025),
            child: Container(
              width: Get.width * 0.1,
              height: Get.width * 0.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Get.width * 0.1)),
              child: Icon(Icons.heart_broken_sharp),
            ),
          )
        ],
      ),
    );
  }
}
