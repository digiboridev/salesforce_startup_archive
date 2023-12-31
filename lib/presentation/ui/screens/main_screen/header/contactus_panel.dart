import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/domain/entities/contact_us_data.dart';
import 'package:salesforce.startup/presentation/controllers/contactus_controller.dart';
import 'package:salesforce.startup/presentation/ui/screens/contactus_form.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/header/contact_option_tile.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/header/our_focus_head.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsPanel extends StatelessWidget {
  ContactUsPanel({
    Key? key,
    required this.onCloseTap,
  }) : super(key: key);

  final ContactusController contactusController = Get.find();
  final Function onCloseTap;

  @override
  Widget build(BuildContext context) {
    return contactusController.obx(
      (state) {
        if (state is ContactUsData) {
          return Column(
            children: [
              Container(
                height: Get.width - Get.width * 0.07,
                color: MyColors.blue_00458C,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            OurFocusHead(
                              contactUsData: state,
                            ),
                            SizedBox(
                              height: Get.width * 0.02,
                            ),
                            ...state.contactOptionsList.map((e) {
                              return ContactOptionTile(
                                contactOption: e,
                              );
                            }),
                            GestureDetector(
                              onTap: () => Get.to(() => ContactusFormScreen()),
                              child: Container(
                                decoration: BoxDecoration(color: MyColors.blue_0250A0, borderRadius: BorderRadius.circular(Get.width * 0.02)),
                                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                                padding: EdgeInsets.symmetric(vertical: Get.width * 0.01, horizontal: Get.width * 0.025),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Contact Form'.tr,
                                      style: TextStyle(
                                        fontSize: Get.width * 0.035,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                      size: Get.width * 0.035,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // buildHideBottom()
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onCloseTap(),
                child: Container(
                  // color: Colors.red,
                  width: Get.width,
                  height: Get.width * 0.06,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetImages.header_tile,
                            width: Get.width * 0.4,
                          ),
                        ],
                      ),
                      Positioned.fill(
                        top: -Get.width * 0.03,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.white,
                              size: Get.width * 0.08,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
      onError: (error) {
        return Container(
          width: Get.width,
          height: Get.width,
          color: MyColors.blue_00458C,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contact Us loaing error', style: TextStyle(color: Colors.white)),
              SizedBox(height: Get.width * 0.06),
              GestureDetector(
                  onTap: () {
                    contactusController.load();
                  },
                  child: Text('Reload', style: TextStyle(color: Colors.white))),
            ],
          ),
        );
      },
      onLoading: Container(
        width: Get.width,
        height: Get.width,
        color: MyColors.blue_00458C,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
