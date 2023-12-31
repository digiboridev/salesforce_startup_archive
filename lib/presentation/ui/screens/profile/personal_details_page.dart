import 'package:salesforce.startup/core/asset_images.dart';
import 'package:salesforce.startup/core/mycolors.dart';
import 'package:salesforce.startup/presentation/controllers/customer_controller.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller_states.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/header/contactus_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalDetailsPageState();
}

class PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    print(userDataController.avaliableLanguages);
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      body: SafeArea(
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

    UserDataState userDataState = userDataController.userDataState;

    if (userDataState is UserDataCommonState) {
      return Expanded(
        child: Container(
          width: Get.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Text(
                  'Personal details'.tr,
                  style: TextStyle(fontSize: Get.width * 0.06, color: MyColors.blue_003E7E),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Column(
                  children: [
                    buildRow(text1: 'First name'.tr, text2: userDataState.userData.contactFirstName),
                    SizedBox(
                      height: Get.width * 0.12,
                    ),
                    buildRow(text1: 'Last name'.tr, text2: userDataState.userData.contactLastName),
                    SizedBox(
                      height: Get.width * 0.12,
                    ),
                    buildRow(text1: 'Phone'.tr, text2: userDataState.userData.contactMobile),
                    SizedBox(
                      height: Get.width * 0.12,
                    ),
                    buildRow(text1: 'Email'.tr, text2: userDataState.userData.contactEmail),
                  ],
                ),
              ),
              Spacer(
                flex: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.06,
                  right: Get.width * 0.06,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetImages.phone,
                      width: Get.width * 0.03,
                      height: Get.width * 0.03,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Container(
                        child: Text(
                      'For details please contact the hotline'.tr,
                      style: TextStyle(
                        color: MyColors.blue_003E7E,
                        fontSize: Get.width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(height: Get.width * 0.04),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: MyColors.blue_00458C, borderRadius: BorderRadius.circular(Get.width * 0.06)),
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: Get.width * 0.02),
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: Get.width * 0.03),
                  child: Text(
                    'Close'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: Get.width * 0.08,
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Container buildRow({
    required String text1,
    required String text2,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Get.width * 0.01),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: MyColors.blue_003E7E, width: Get.width * 0.003))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
              fontSize: Get.width * 0.042,
              color: MyColors.blue_003E7E,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text2,
            style: TextStyle(fontSize: Get.width * 0.042, color: MyColors.blue_003E7E.withOpacity(0.5)),
          ),
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
