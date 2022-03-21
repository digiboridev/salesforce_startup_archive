import 'package:***REMOVED***/data/datasouces/user_data_remote_datasource.dart';
import 'package:***REMOVED***/data/models/user_data_model.dart';
import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/usecases/get_remote_userdata.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/salesforce.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: App(),
  ));
}
// Random().nextInt(100)

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserDataController userDataController = Get.put(UserDataController());

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

    // UserDataRemoteDatasourceImpl userDataRemoteDatasourceImpl =
    //     UserDataRemoteDatasourceImpl();
    UseCase c = GetRemoteUserData(UserDataRepositoryImpl(
        userDataRemoteDatasource: UserDataRemoteDatasourceImpl()));

    var asd = await c(null);

    print(asd);

    // Repo repo = Repo();
    // repo.setEnt(ent: TEntity(index: 123));
  }

  @override
  Widget build(BuildContext context) {
    // print(Get.context!.size.toString());
    // test();
    return Obx(() {
      if (userDataController.authData != null) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Test"),
          ),
          body: Obx(() => Center(
                child: Text(userDataController.authData.toString()),
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: () => test(),
            child: Icon(Icons.refresh),
          ),
        );
      }
      return Scaffold(
        body: SizedBox(),
      );
    });
  }
}
