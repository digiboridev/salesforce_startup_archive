import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsPage extends StatelessWidget {
  PersonalDetailsPage({Key? key}) : super(key: key);

  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(userDataController.avaliableLanguages);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          children: [buildHeader(), buildBody()],
        ),
      )),
    );
  }

  Widget buildBody() {
    print(userDataController.currentLanguage);

    UserDataState userDataState = userDataController.userDataState;

    if (userDataState is UserDataCommonState) {
      return Expanded(
        child: Container(
          width: Get.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.width * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Text(
                  'Personal details'.tr,
                  style: TextStyle(
                    fontSize: Get.width * 0.05,
                  ),
                ),
              ),
              SizedBox(
                height: Get.width * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'Name'.tr}: ' + userDataState.userData.contactName,
                      style: TextStyle(fontSize: Get.width * 0.04),
                    ),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),
                    Text(
                      '${'First name'.tr}: ' + userDataState.userData.contactFirstName,
                      style: TextStyle(fontSize: Get.width * 0.04),
                    ),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),
                    Text(
                      '${'Last name'.tr}: ' + userDataState.userData.contactLastName,
                      style: TextStyle(fontSize: Get.width * 0.04),
                    ),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),
                    Text(
                      '${'Phone'.tr}: ' + userDataState.userData.contactMobile,
                      style: TextStyle(fontSize: Get.width * 0.04),
                    ),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),
                    Text(
                      '${'Email'.tr}: ' + userDataState.userData.contactEmail,
                      style: TextStyle(fontSize: Get.width * 0.04),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Container buildHeader() {
    return Container(
      height: Get.width * 0.3,
      color: Color(0xff00458C),
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
                  'assets/icons/contact.png',
                  width: Get.width * 0.05,
                ),
              ),
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/***REMOVED***_logo.png',
                  width: Get.width * 0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
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
