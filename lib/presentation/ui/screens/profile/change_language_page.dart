import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/core/languages.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/contactus_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangeLanguagePageState();
}

class ChangeLanguagePageState extends State<ChangeLanguagePage> {
  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();
  final MaterialsCatalogController materialsCatalogController = Get.find();
  late Languages selectLanguage;
  bool expanded = false;

  @override
  void initState() {
    selectLanguage = userDataController.currentLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(userDataController.avaliableLanguages);
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
                  color: MyColors.blue_003E7E,
                  fontSize: Get.width * 0.08,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: Get.width * 0.06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: userDataController.avaliableLanguages.map((language) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectLanguage = language;
                      });
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.width * 0.045),
                        child: Row(
                          children: [
                            selectLanguage == language
                                ? Image.asset(
                                    AssetImages.radio_s,
                                    width: Get.width * 0.05,
                                  )
                                : Image.asset(
                                    AssetImages.radio,
                                    width: Get.width * 0.05,
                                  ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Text(
                              language.languageString.tr,
                              style: TextStyle(
                                fontSize: Get.width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: MyColors.blue_003E7E,
                              ),
                            ),
                          ],
                        )),
                  );
                }).toList(),
              ),
            ),
            Spacer(),
            Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.06,
                  right: Get.width * 0.06,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: Get.width / 2.4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColors.gray_EAF2FA,
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.06)),
                        padding: EdgeInsets.symmetric(
                          vertical: Get.width * 0.03,
                        ),
                        child: Text(
                          'Cancellation'.tr,
                          style: TextStyle(
                            color: MyColors.blue_003E7E,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setLanguage();
                      },
                      child: Container(
                        width: Get.width / 2.4,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColors.blue_00458C,
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.06)),
                        padding:
                            EdgeInsets.symmetric(vertical: Get.width * 0.03),
                        child: Text(
                          'Save'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: Get.width * 0.06,
            ),
          ],
        ),
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
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  color: Colors.white,
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

  void setLanguage() {
    userDataController
        .changeLanguage(lang: selectLanguage)
        .then((value) => materialsCatalogController.loadCatalog());
  }
}
