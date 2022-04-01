import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/homepage/home_page_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ConnectionService connectionService = Get.find();

  final double headerHeight = Get.width * 0.3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBody(),
        HomePageHeader(
          headerHeight: headerHeight,
        )
      ],
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
            Obx(() => Align(
                  alignment: Alignment.centerRight,
                  child: Text(connectionService.hasConnection
                      ? 'Online mode'
                      : 'Offline mode'),
                )),
          ],
        ),
      ),
    );
  }
}
