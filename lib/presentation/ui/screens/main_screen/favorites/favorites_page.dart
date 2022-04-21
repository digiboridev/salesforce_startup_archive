import 'package:***REMOVED***/data/datasouces/favorites_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/favorites_remote_datasource.dart';
import 'package:***REMOVED***/data/models/favorites/favorite_list_model.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({Key? key}) : super(key: key);

  final CustomerController customerController = Get.find();

  test() async {
    FavoritesRemoteDatasourceImpl favoritesRemoteDatasourceImpl =
        FavoritesRemoteDatasourceImpl();

    FavoritesLocalDatasourceImpl favoritesLocalDatasourceImpl =
        FavoritesLocalDatasourceImpl();

    // List<FavoriteListModel> rs = await favoritesRemoteDatasourceImpl
    //     .getFavoritesList(customerSAP: customerController.selectedCustomerSAP!);

    // await favoritesLocalDatasourceImpl.setFavoritesLists(
    //     customerSAP: customerController.selectedCustomerSAP!,
    //     favoriteslists: rs);

    List<FavoriteListModel> rl =
        await favoritesLocalDatasourceImpl.getFavoritesLists(
            customerSAP: customerController.selectedCustomerSAP!);

    print(rl);

    // var rs = await favoritesRemoteDatasourceImpl.addList(
    //     customerSAP: customerController.selectedCustomerSAP!,
    //     favoriteListModel:
    //         FavoriteListModel(sFId: '', listName: 'HUEIM', favoriteItems: []));
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
