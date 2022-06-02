import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/entities/contact_us_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactOptionTile extends StatelessWidget {
  const ContactOptionTile({Key? key, required this.contactOption})
      : super(key: key);

  final ContactOption contactOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: Get.width * 0.25,
          decoration: BoxDecoration(
              color: MyColors.blue_0250A0,
              borderRadius: BorderRadius.circular(Get.width * 0.02)),
          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.03,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.width * 0.02),
                child: Row(
                  children: [
                    Text(
                      contactOption.description,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: Get.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launch('mailto:${contactOption.email}');
                        },
                        child: Image.asset(
                          AssetImages.contact_mail,
                          width: Get.width * 0.15,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('${contactOption.whatsAppLink}');
                        },
                        child: Image.asset(
                          AssetImages.contact_messanger,
                          width: Get.width * 0.15,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('tel:${contactOption.phoneNumber}');
                        },
                        child: Image.asset(
                          AssetImages.contact_phone,
                          width: Get.width * 0.15,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                width: Get.width * 0.2,
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.width * 0.02,
        ),
      ],
    );
  }
}
