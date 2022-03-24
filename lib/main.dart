import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/widgets/legal_doc_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

main() async {
  await initServices();
  runApp(GetMaterialApp(
    home: Loader(),
  ));
}

Future initServices() async {
  print('starting services ...');
  await GetStorage.init();
  await Get.putAsync(() => ConnectionService().init());
  print('All services started...');
}

class Loader extends StatelessWidget {
  final UserDataController userDataController =
      Get.put(UserDataController(), permanent: true);
  final ConnectionService connectionService = Get.find();

  test() async {
    print("do some");
    userDataController.updateUserData();

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

    // print(asd);
  }

  @override
  Widget build(BuildContext context) {
    // test();
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => test(),
      //   child: Icon(Icons.refresh),
      // ),
      body: SafeArea(
        child: Obx(() {
          UserDataState userDataState = userDataController.userDataState;

          if (userDataState is UserDataLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (userDataState is UserDataUpdatingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (userDataState is UserDataLoadingErrorState) {
            return Column(
              children: [
                Text('Loaing error'),
                Text(userDataState.msg),
                Container(
                  color: Colors.amber,
                  child: GestureDetector(
                      onTap: () => userDataController.loadUserData(),
                      child: Text('try again')),
                ),
              ],
            );
          }

          if (userDataState is UserDataCommonState) {
            print(userDataState.userData.hashCode);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text('Loaded'),
                  Text(userDataState.userData.toString()),
                ],
              ),
            );
          }

          if (userDataState is UserDataAskLegalDocState) {
            return LegalDocView(userDataState: userDataState);
          }

          return SizedBox();
        }),
      ),
    );
  }
}
