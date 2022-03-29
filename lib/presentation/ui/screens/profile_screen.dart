import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final CustomerController customerController = Get.find();
  final UserDataController userDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          children: [
            buildHeader(),
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
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choose language'),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.width * 0.01,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.width * 0.04),
                    child: GestureDetector(
                      onTap: () {
                        userDataController.logout();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Log out'), Icon(Icons.logout)],
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }

  Container buildHeader() {
    return Container(
      height: Get.width * 0.3,
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
                  Get.back();
                },
                child: Icon(Icons.arrow_back),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
