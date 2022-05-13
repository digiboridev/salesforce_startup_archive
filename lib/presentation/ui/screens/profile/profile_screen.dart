import 'package:***REMOVED***/core/assets.dart';
import 'package:***REMOVED***/core/colors.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/profile/change_language_page.dart';
import 'package:***REMOVED***/presentation/ui/screens/profile/change_password_page.dart';
import 'package:***REMOVED***/presentation/ui/screens/profile/personal_details_page.dart';
import 'package:***REMOVED***/presentation/ui/screens/legal_doc_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      body: SafeArea(
          child: Container(
        color: MyColors.white_F4F4F6,
        child: SizedBox.expand(
          child: Column(
            children: [buildHeader(), buildBody()],
          ),
        ),
      )),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.width * 0.06),
            child: Text(
              customerController.selectedCustomer!.customerName,
              style: TextStyle(
                fontSize: Get.width * 0.05,
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => PersonalDetailsPage(),
                        transition: Transition.cupertino);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Personal details'.tr),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ChangeLanguagePage(),
                        transition: Transition.cupertino);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choose language'.tr),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ChangePasswordPage(),
                        transition: Transition.cupertino);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Change password'.tr),
                        Icon(Icons.keyboard_arrow_right)
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
                              callback: () {
                                Get.back();
                              },
                            ),
                        transition: Transition.cupertino);
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Terms an conditions'.tr),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.01,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.06, vertical: Get.width * 0.04),
                  child: GestureDetector(
                    onTap: () {
                      userDataController.logout();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Log out'.tr),
                        Transform.rotate(
                            angle: 1.6, child: Icon(Icons.power_settings_new))
                      ],
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
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [MyColors.blue_0D63BB, MyColors.blue_00458C])),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'contact_btn',
                child: Image.asset(
                  AssetImages.contactButton,
                  width: Get.width * 0.05,
                ),
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  AssetImages.***REMOVED***Logo,
                  width: Get.width * 0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
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
