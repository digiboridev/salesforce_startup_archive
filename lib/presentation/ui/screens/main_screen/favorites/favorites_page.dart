import 'package:***REMOVED***/data/datasouces/favorites_remote_datasource.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({Key? key}) : super(key: key);

  final CustomerController customerController = Get.find();

  test() {
    FavoritesRemoteDatasourceImpl favoritesRemoteDatasourceImpl =
        FavoritesRemoteDatasourceImpl();

    favoritesRemoteDatasourceImpl.getFavoritesList(
        customerSAP: customerController.selectedCustomerSAP!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          GestureDetector(
              onTap: () => test(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('asdasd'),
              )),
        ],
      ),
    );
  }
}
