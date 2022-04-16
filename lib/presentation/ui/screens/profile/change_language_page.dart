import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguagePage extends StatelessWidget {
  ChangeLanguagePage({Key? key}) : super(key: key);

  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();
  final MaterialsCatalogController materialsCatalogController = Get.find();

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
                'Choose language'.tr,
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
                children: userDataController.avaliableLanguages.map((e) {
                  return GestureDetector(
                    onTap: () => userDataController
                        .changeLanguage(lang: e)
                        .then((value) =>
                            materialsCatalogController.loadCatalog()),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.width * 0.01),
                      child: Obx(() => Row(
                            children: [
                              userDataController.currentLanguage == e
                                  ? Icon(Icons.stop_circle_outlined)
                                  : Icon(Icons.circle_outlined),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Text(
                                e.languageString.tr,
                                style: TextStyle(fontSize: Get.width * 0.04),
                              ),
                            ],
                          )),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
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
