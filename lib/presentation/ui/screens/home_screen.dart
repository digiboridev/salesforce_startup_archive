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
    // test();
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
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.feed),
                      Text('Diplomat logo'),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => ProfileScreen());
                          },
                          child: Icon(Icons.settings))
                    ],
                  ),
                  Spacer(),
                  headerExpanded
                      ? Icon(Icons.arrow_circle_up)
                      : Icon(Icons.arrow_circle_down),
                  SizedBox(height: Get.width * 0.01),
                ],
              ),
            ),
            if (headerExpanded)
              Container(
                height: topSheetHeight,
                color: Colors.amber,
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
                        child: Text('Brunch: ' +
                            customerController.selectedCustomer!.customerName),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Id: ' +
                            customerController.selectedCustomer!.customerId),
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
                        child: Text('All branches:'),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      // color: Colors.blue,
                      child: ListView(
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
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(
                                          Get.width * 0.06)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(e.customerId),
                                      Text(e.customerName),
                                      Text(e.customerAddress),
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
        color: Colors.yellow,
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
