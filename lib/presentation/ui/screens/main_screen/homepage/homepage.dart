import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ConnectionService connectionService = Get.find();

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Container(
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          Spacer(),
          Text('Homescreen'),
          Spacer(),
          Obx(() => Align(
                alignment: Alignment.centerRight,
                child: Text(connectionService.hasConnection
                    ? 'Online mode'
                    : 'Offline mode'),
              )),
        ],
      ),
    );
  }
}
