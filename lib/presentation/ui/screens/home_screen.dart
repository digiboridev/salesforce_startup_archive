import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    // test();
    return Scaffold(
      body: SafeArea(child: Text('home')),
    );
  }
}
