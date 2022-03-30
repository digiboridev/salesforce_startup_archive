import 'package:***REMOVED***/data/datasouces/customers_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/customers_remote_datasource.dart';
import 'package:***REMOVED***/data/datasouces/user_data_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/user_data_remote_datasource.dart';
import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/usecases/accept_legal_doc.dart';
import 'package:***REMOVED***/domain/usecases/change_language.dart';
import 'package:***REMOVED***/domain/usecases/get_customers_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/get_selected_customer_sap.dart';
import 'package:***REMOVED***/domain/usecases/get_userdata_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/set_selected_customer_sap.dart';
import 'package:***REMOVED***/presentation/ui/screens/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  CustomersRepository customersRepository = Get.put(CustomersRepositoryImpl(
      customersLocalDatasource: CustomersLocalDatasourceImpl(),
      customersRemoteDatasource: CustomersRemoteDatasourceImpl()));

  // Use cases
  Get.put<GetUserDataAndCache>(GetUserDataAndCache(userDataRepository));
  Get.put<AcceptLegalDoc>(AcceptLegalDoc(userDataRepository));
  Get.put<ChangeLanguage>(ChangeLanguage(userDataRepository));

  Get.put<GetSelectedCustomerSAP>(GetSelectedCustomerSAP(customersRepository));
  Get.put<SetSelectedCustomerSAP>(SetSelectedCustomerSAP(customersRepository));
  Get.put<GetCustomersAndCache>(GetCustomersAndCache(customersRepository));

  print('injected dependencies...');
}

Future initServices() async {
  print('starting services ...');
  await GetStorage.init();
  await Get.putAsync(() => ConnectionService().init());
  final EventChannel channel = new EventChannel('authSF');

  channel.receiveBroadcastStream().listen((data) {
    print("recv:");
    //authSuccess
    //authLogout
    print(data);
  });

  print('All services started...');
}
