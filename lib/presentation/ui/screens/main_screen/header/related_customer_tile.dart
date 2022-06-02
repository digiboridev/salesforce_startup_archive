import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/entities/related_consumer.dart';
import 'package:***REMOVED***/domain/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RelatedCustomerTile extends StatelessWidget {
  RelatedCustomerTile({
    Key? key,
    required this.relatedConsumer,
    required this.ontap,
  }) : super(key: key);

  final LocationService locationService = Get.find();
  final RelatedConsumer relatedConsumer;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.03,
        vertical: Get.width * 0.02,
      ),
      child: GestureDetector(
        onTap: () => ontap(),
        child: Container(
            padding: EdgeInsets.all(Get.width * 0.04),
            decoration: BoxDecoration(
                color: MyColors.blue_0250A0,
                borderRadius: BorderRadius.circular(Get.width * 0.02)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  relatedConsumer.customerName,
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Get.width * 0.025),
                  height: Get.width * 0.002,
                  width: Get.width,
                  color: MyColors.blue_00458C,
                ),
                Text(
                  relatedConsumer.customerAddress,
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Get.width * 0.025),
                  height: Get.width * 0.002,
                  width: Get.width,
                  color: MyColors.blue_00458C,
                ),
                Row(
                  children: [
                    Text(
                      'Client ID'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      relatedConsumer.customerSAPNumber,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Get.width * 0.025),
                  height: Get.width * 0.002,
                  width: Get.width,
                  color: MyColors.blue_00458C,
                ),
                Row(
                  children: [
                    Text(
                      'Last order date'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(
                          DateTime.parse(relatedConsumer.lastOrderDate)),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                if (locationService.lastPosition != null)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Get.width * 0.025),
                    height: Get.width * 0.002,
                    width: Get.width,
                    color: MyColors.blue_00458C,
                  ),
                if (locationService.lastPosition != null)
                  Row(
                    children: [
                      Text(
                        'Distance'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Text(
                        relatedConsumer
                            .distanceTo(lattitude: 0, longtitude: 0)
                            .toStringAsFixed(2),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Text(
                        'km',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
              ],
            )),
      ),
    );
  }
}
