import 'package:***REMOVED***/domain/entities/contact_us_data.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/contactus_controller.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CustomerController customerController = Get.find();
  final ConnectionService connectionService = Get.find();
  final ContactusController contactusController = Get.find();

  final double headerHeight = Get.width * 0.3;
  final double topSheetHeight = Get.width * 0.9;

  bool headerExpanded = false;

  Widget? expandedChild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox.expand(
        child: Stack(
          children: [buildBody(), buildHeader()],
        ),
      ),
    ));
  }

  Widget buildHeader() {
    return AnimatedContainer(
      decoration: BoxDecoration(color: Colors.transparent),
      clipBehavior: Clip.antiAlias,
      height: headerExpanded ? headerHeight + topSheetHeight : headerHeight,
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceOut,
      child: Column(
        children: [
          Container(
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
                          headerExpanded = !headerExpanded;
                          expandedChild = buildContact();
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
                        width: Get.width * 0.3,
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      headerExpanded = !headerExpanded;
                      expandedChild = buildBranchSelection();
                    });
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(() => Text(
                          'Brunch: ' +
                              customerController.selectedCustomer!.customerName,
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(
                  height: Get.width * 0.04,
                ),
              ],
            ),
          ),
          // buildContact(),
          if (headerExpanded) expandedChild!,
        ],
      ),
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
                Container(
                  height: Get.width * 0.2,
                  decoration: BoxDecoration(
                      color: Color(0xff0250A0),
                      borderRadius: BorderRadius.circular(Get.width * 0.02)),
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
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
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.02)),
                        margin:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.02),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                })
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
      height: topSheetHeight,
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
            // color: Colors.blue,
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
          ))
        ],
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.only(top: headerHeight),
      child: Container(
        width: Get.width,
        color: Colors.white,
        child: Column(
          children: [
            Spacer(),
            Text('Homescreen'),
            Spacer(),
            Obx(() => Text(connectionService.hasConnection
                ? 'Online mode'
                : 'Offline mode')),
          ],
        ),
      ),
    );
  }
}
