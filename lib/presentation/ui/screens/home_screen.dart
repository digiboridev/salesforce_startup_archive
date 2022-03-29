import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CustomerController customerController = Get.find();
  final ConnectionService connectionService = Get.find();

  final double headerHeight = Get.width * 0.3;
  final double topSheetHeight = Get.width * 0.9;

  bool headerExpanded = false;

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
      child: GestureDetector(
        onTap: () {
          setState(() {
            headerExpanded = !headerExpanded;
          });
        },
        child: Column(
          children: [
            Container(
              height: headerHeight,
              color: Color(0xff00458C),
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/icons/contact.png',
                        width: Get.width * 0.05,
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
                  Spacer(),
                ],
              ),
            ),
            if (headerExpanded)
              Container(
                height: topSheetHeight,
                color: Color(0xff00458C),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.width * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.04),
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => Text(
                              'Id: ' +
                                  customerController
                                      .selectedCustomer!.customerId,
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: Get.width * 0.04,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.04),
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
                        children: customerController.relatedConsumersEntities
                            .map((e) {
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
                                      borderRadius: BorderRadius.circular(
                                          Get.width * 0.02)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
              ),
          ],
        ),
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
