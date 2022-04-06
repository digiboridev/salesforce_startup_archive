import 'package:***REMOVED***/domain/entities/contact_us_data.dart';
import 'package:***REMOVED***/presentation/controllers/contactus_controller.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/header/mainscreen_header_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreenHeader extends StatefulWidget {
  final double headerHeight;
  const MainScreenHeader({Key? key, required this.headerHeight})
      : super(key: key);

  @override
  State<MainScreenHeader> createState() => _MainScreenHeaderState();
}

class _MainScreenHeaderState extends State<MainScreenHeader> {
  MainScreeenHeaderController mainScreeenHeaderController =
      Get.put(MainScreeenHeaderController());

  final CustomerController customerController = Get.find();
  final ContactusController contactusController = Get.find();
  final double topSheetHeight = Get.width * 0.9;
  late double headerHeight;

  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    headerHeight = widget.headerHeight;
    searchFocusNode.addListener(() {
      print(searchFocusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return Container(
            height: headerHeight,
            color: Color(0xff00458C),
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Column(
              children: [
                Spacer(
                  flex: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mainScreeenHeaderController.showContactus();
                        });
                      },
                      child: Hero(
                        tag: 'contact_btn',
                        child: Image.asset(
                          'assets/icons/contact.png',
                          width: Get.width * 0.05,
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/images/***REMOVED***_logo.png',
                        width: Get.width * 0.2,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => ProfileScreen(),
                              transition: Transition.cupertino);
                        },
                        child: Image.asset(
                          'assets/icons/settings.png',
                          width: Get.width * 0.05,
                        ))
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffEEE4F2),
                          borderRadius: BorderRadius.circular(Get.width * 0.1)),
                      width: Get.width * 0.1,
                      height: Get.width * 0.1,
                      child: Icon(Icons.close),
                    ),
                    SizedBox(
                      width: Get.width * 0.015,
                    ),
                    Expanded(
                      child: Container(
                        height: Get.width * 0.1,
                        decoration: BoxDecoration(
                            color: Color(0xffEEE4F2),
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.1)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            Icon(Icons.search),
                            Expanded(
                                child: TextField(
                              focusNode: searchFocusNode,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                isCollapsed: true,
                                //isDense: true,
                                alignLabelWithHint: true,

                                labelText: 'Search product',
                                labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: InputBorder.none,

                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,

                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                            )),
                            Icon(Icons.scuba_diving_sharp),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                if (mainScreeenHeaderController.enableBrunchSelection.value)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        mainScreeenHeaderController.showBrunchSelection();
                      });
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(() => Text(
                            'Brunch: ' +
                                customerController
                                    .selectedCustomer!.customerName,
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                SizedBox(
                  height: Get.width * 0.04,
                ),
              ],
            ),
          );
        }),
        Obx(() => AnimatedContainer(
              decoration: BoxDecoration(color: Colors.transparent),
              clipBehavior: Clip.antiAlias,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: mainScreeenHeaderController.mainScreeenHeaderState.value
                      is MSHShowContactus
                  ? topSheetHeight
                  : 0,
              child: OverflowBox(
                minHeight: 0,
                child: buildContact(),
              ),
            )),
        Obx(() => AnimatedContainer(
              decoration: BoxDecoration(color: Colors.transparent),
              clipBehavior: Clip.antiAlias,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: mainScreeenHeaderController.mainScreeenHeaderState.value
                      is MSHShowBrunch
                  ? Get.width * 1
                  : 0,
              child: OverflowBox(
                minHeight: 0,
                child: buildBranchSelection(),
              ),
            )),
      ],
    );
  }

  Widget buildContact() {
    return contactusController.obx(
      (state) {
        if (state is ContactUsData) {
          return Container(
            height: topSheetHeight,
            color: Color(0xff00458C),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: Get.width * 0.2,
                          decoration: BoxDecoration(
                              color: Color(0xff0250A0),
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.02)),
                          margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.06),
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.06),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Our focus is open',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    state.openingHoursString,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.width * 0.02,
                        ),
                        ...state.contactOptionsList.map((e) {
                          return Column(
                            children: [
                              Container(
                                height: Get.width * 0.25,
                                decoration: BoxDecoration(
                                    color: Color(0xff0250A0),
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.02)),
                                margin: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.06),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.02),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.width * 0.02),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e.description,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            launch('mailto:${e.email}');
                                          },
                                          child: Image.asset(
                                            'assets/icons/contact_mail.png',
                                            width: Get.width * 0.15,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            launch('${e.whatsAppLink}');
                                          },
                                          child: Image.asset(
                                            'assets/icons/contact_messanger.png',
                                            width: Get.width * 0.15,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            launch('tel:${e.phoneNumber}');
                                          },
                                          child: Image.asset(
                                            'assets/icons/contact_phone.png',
                                            width: Get.width * 0.15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.width * 0.02,
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                buildHideBottom()
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
      onError: (error) {
        return Container(
          width: Get.width,
          height: topSheetHeight,
          color: Color(0xff00458C),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contact Us loaing error',
                  style: TextStyle(color: Colors.white)),
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
        height: topSheetHeight,
        color: Color(0xff00458C),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildBranchSelection() {
    return Container(
      height: Get.width * 1,
      color: Color(0xff00458C),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All branches:',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: customerController.relatedConsumers.map((e) {
                return Padding(
                  padding: EdgeInsets.all(Get.width * 0.01),
                  child: GestureDetector(
                    onTap: () {
                      customerController.switchCustomer(
                          customerSAP: e.customerSAPNumber);
                    },
                    child: Container(
                        padding: EdgeInsets.all(Get.width * 0.04),
                        decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.02)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.customerId,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              e.customerName,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              e.customerAddress,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                );
              }).toList(),
            ),
          )),
          buildHideBottom()
        ],
      ),
    );
  }

  GestureDetector buildHideBottom() {
    return GestureDetector(
      onTap: () => mainScreeenHeaderController.hide(),
      child: Container(
        width: Get.width,
        // color: Colors.red,
        child: Icon(
          Icons.arrow_drop_up_outlined,
          color: Colors.white,
          size: Get.width * 0.08,
        ),
      ),
    );
  }
}
