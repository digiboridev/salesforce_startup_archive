import 'package:salesforce.startup/presentation/ui/screens/main_screen/header/contactus_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/domain/entities/contact_us_data.dart';
import 'package:salesforce.startup/presentation/controllers/contactus_controller.dart';
import 'package:salesforce.startup/presentation/controllers/customer_controller.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller.dart';
import 'package:salesforce.startup/presentation/ui/screens/legal_doc_screen.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/header/contact_option_tile.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/header/our_focus_head.dart';
import 'package:salesforce.startup/presentation/ui/screens/profile/change_language_page.dart';
import 'package:salesforce.startup/presentation/ui/screens/profile/change_password_page.dart';
import 'package:salesforce.startup/presentation/ui/screens/profile/personal_details_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();

  bool expanded = false;

  final TextStyle profileFieldStyle = TextStyle(
    color: MyColors.blue_003E7E,
    fontSize: Get.width * 0.04,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      body: SafeArea(
          bottom: false,
          child: Container(
            color: MyColors.white_F4F4F6,
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Get.width * 0.3,
                      ),
                      buildBody()
                    ],
                  ),
                  Column(
                    children: [
                      buildHeader(),
                      AnimatedContainer(
                        decoration: BoxDecoration(color: Colors.transparent),
                        clipBehavior: Clip.antiAlias,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        height: expanded ? Get.width : 0,
                        child: OverflowBox(
                          minHeight: 0,
                          child: ContactUsPanel(
                            onCloseTap: () {
                              setState(() {
                                expanded = false;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: Get.width * 0.06, horizontal: Get.width * 0.06),
            child: Text(
              customerController.selectedCustomer!.customerName,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: MyColors.blue_003E7E,
                fontSize: Get.width * 0.07,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => PersonalDetailsPage(), transition: Transition.cupertino);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Personal details'.tr,
                          style: profileFieldStyle,
                        ),
                        Icon(
                          Directionality.of(context) == TextDirection.rtl ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                          color: MyColors.blue_003E7E,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ChangeLanguagePage(), transition: Transition.cupertino);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choose language'.tr, style: profileFieldStyle),
                        Icon(
                          Directionality.of(context) == TextDirection.rtl ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                          color: MyColors.blue_003E7E,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ChangePasswordPage(), transition: Transition.cupertino);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Change password'.tr, style: profileFieldStyle),
                        Icon(
                          Directionality.of(context) == TextDirection.rtl ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                          color: MyColors.blue_003E7E,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                        () => LegalDocScreen(
                              legalDocLink: userDataController.legalocLink,
                              buttonText: 'Close',
                              callback: () async {
                                Get.back();
                              },
                            ),
                        transition: Transition.cupertino);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Terms an conditions'.tr, style: profileFieldStyle),
                        Icon(
                          Directionality.of(context) == TextDirection.rtl ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                          color: MyColors.blue_003E7E,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.width * 0.04),
                  child: GestureDetector(
                    onTap: () {
                      userDataController.logout();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Log out'.tr, style: profileFieldStyle), Transform.rotate(angle: 1.6, child: Icon(Icons.power_settings_new))],
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Container buildHeader() {
    return Container(
      height: Get.width * 0.3,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [MyColors.blue_0D63BB, MyColors.blue_00458C])),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Directionality.of(context) == TextDirection.rtl ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  AssetImages.startupLogo,
                  width: Get.width * 0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                child: Hero(
                  tag: 'contact_btn',
                  child: Image.asset(
                    AssetImages.contactButton,
                    width: Get.width * 0.05,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
