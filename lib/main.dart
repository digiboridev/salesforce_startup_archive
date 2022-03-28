import 'package:***REMOVED***/data/datasouces/user_data_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/user_data_remote_datasource.dart';
import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/usecases/accept_legal_doc.dart';
import 'package:***REMOVED***/domain/usecases/change_language.dart';
import 'package:***REMOVED***/domain/usecases/get_userdata_and_cache.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/widgets/legal_doc_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';


main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await injectDependency();
  await initServices();
  runApp(GetMaterialApp(
    home: Loader(),
  ));
}

Future injectDependency() async {
  // Repositories
  UserDataRepository userDataRepository = Get.put(UserDataRepositoryImpl(
      userDataLocalDatasource: UserDataLocalDatasourceImpl(),
      userDataRemoteDatasource: UserDataRemoteDatasourceImpl()));

  // Use cases
  Get.put<GetUserDataAndCache>(GetUserDataAndCache(userDataRepository));
  Get.put<AcceptLegalDoc>(AcceptLegalDoc(userDataRepository));
  Get.put<ChangeLanguage>(ChangeLanguage(userDataRepository));

  print('injected dependencies...');
}

Future initServices() async {
  await GetStorage.init();
  await Get.putAsync(() => ConnectionService().init());
  print('All services started...');
}

class Loader extends StatelessWidget {
  final UserDataController userDataController =
      Get.put(UserDataController(), permanent: true);
  final ConnectionService connectionService = Get.find();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          UserDataState userDataState = userDataController.userDataState;

          if (userDataState is UserDataLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (userDataState is UserDataLoadingErrorState) {
            return SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Loading error'),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  Text(userDataState.msg),
                  SizedBox(
                    height: Get.width * 0.06,
                  ),
                  GestureDetector(
                    onTap: () => userDataController.loadUserData(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.06)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.1,
                          vertical: Get.width * 0.03),
                      child: Text('try again'),
                    ),
                  )
                ],
              ),
            );
          }

          if (userDataState is UserDataAskLegalDocState) {
            return LegalDocView(userDataState: userDataState);
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

          return SizedBox();
        }),
      ),
    );
  }
}
