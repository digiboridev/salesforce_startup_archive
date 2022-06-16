import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/contactus_panel.dart';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/default_dialog.dart';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/info_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactusFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactusFormScreenState();
}

class ContactusFormScreenState extends State<ContactusFormScreen> {
  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();
  bool expanded = false;
  Map? selectedCaseReason;
  String reasonText = '';

  onSend() async {
    if (selectedCaseReason == null || reasonText.isEmpty) {
      Get.bottomSheet(InfoBottomSheet(
          headerText: 'Error'.tr,
          mainText: 'Fill fields please',
          actions: [InfoAction(text: 'Ok', callback: () => Get.back())],
          headerIconPath: AssetImages.info));
    } else {
      defaultDialog();

      await Future.delayed(Duration(seconds: 3));

      Get.until((route) => !Get.isDialogOpen!);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.width * 0.06,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Text(
                          'Contact Form'.tr,
                          style: TextStyle(
                              fontSize: Get.width * 0.06,
                              color: MyColors.blue_003E7E),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Text(
                          'Hello_contact'.trParams({'name': 'qwe'}),
                          style: TextStyle(
                              fontSize: Get.width * 0.05,
                              color: MyColors.blue_003E7E),
                        ),
                      ),
                      SizedBox(
                        height: Get.width * 0.08,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: DropdownButton(
                            icon: Icon(Icons.keyboard_arrow_down_sharp),
                            isExpanded: true,
                            hint: Text(
                              'Selecting_reason'.tr,
                              style: TextStyle(
                                fontSize: Get.width * 0.04,
                                color: MyColors.blue_003E7E,
                              ),
                            ),
                            value: selectedCaseReason,
                            items: caseReasons
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        e['caseText'],
                                        style: TextStyle(
                                          fontSize: Get.width * 0.04,
                                          color: MyColors.blue_003E7E,
                                        ),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (v) {
                              setState(() {
                                selectedCaseReason = v as Map?;
                              });
                            }),
                      ),
                      SizedBox(
                        height: Get.width * 0.08,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Want to elaborate?'.tr,
                                  style: TextStyle(
                                    fontSize: Get.width * 0.05,
                                    color: MyColors.blue_003E7E,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: MyColors.blue_003E7E)),
                              child: TextField(
                                onChanged: (value) =>
                                    setState(() => reasonText = value),
                                minLines: 8,
                                maxLines: 12,
                                decoration:
                                    InputDecoration.collapsed(hintText: ''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.width * 0.02,
              ),
              GestureDetector(
                onTap: () => onSend(),
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColors.blue_00458C,
                      borderRadius: BorderRadius.circular(Get.width * 0.06)),
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.1, vertical: Get.width * 0.02),
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.1, vertical: Get.width * 0.03),
                  child: Text(
                    'Send'.tr,
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
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: MyColors.blue_003E7E, width: Get.width * 0.003))),
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
            style: TextStyle(
                fontSize: Get.width * 0.042,
                color: MyColors.blue_003E7E.withOpacity(0.5)),
          ),
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
}

List caseReasons = [
  {"caseText": "General Support", "reasonID": 1},
  {"caseText": "Cancel order", "reasonID": 2},
  {"caseText": "Wrong product was supplied", "reasonID": 3},
  {"caseText": "Release credit limit", "reasonID": 4},
  {"caseText": "Pricing Issue", "reasonID": 5},
  {"caseText": "Order Issue", "reasonID": 6}
];
