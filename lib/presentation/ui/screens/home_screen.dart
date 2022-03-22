import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final UserDataController userDataController = Get.put(UserDataController());
  final ConnectionService connectionService = Get.find();

  test() async {
    print("do some");

    // SalesforcePlugin.logoutCurrentUser();

    // Map<String, dynamic> asd =
    //     await SalesforcePlugin.getAuthCredentials() as Map<String, dynamic>;

    // Map<String, dynamic> asd = await SalesforcePlugin.sendRequest(
    //   endPoint: '***REMOVED***',
    //   path: '/me',
    // ) as Map<String, dynamic>;

    // UserDataModel d = UserDataModel.fromMap(asd['result']);

    // var asd = await SalesforcePlugin.sendRequest(
    //     endPoint: '***REMOVED***',
    //     path: '/me/changeLang',
    //     method: 'POST',
    //     payload: {"langCode": "en"});

    // var asd = await SalesforcePlugin.sendRequest(
    //     endPoint: '***REMOVED***', path: '/customer/1015586');

    // var asd = await SalesforcePlugin.sendRequest(
    //     endPoint: '***REMOVED***',
    //     path: '/materials/catalog/1009006');

    // UseCase c = GetRemoteUserData(UserDataRepositoryImpl(
    //     userDataRemoteDatasource: UserDataRemoteDatasourceImpl()));

    // var asd = await c(null);

    // print(asd);
  }

  @override
  Widget build(BuildContext context) {
    // test();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => test(),
        child: Icon(Icons.refresh),
      ),
      body: Obx(() {
        return Center(
          child: Text(userDataController.authData.toString()),
        );
      }),
    );
  }
}
