import 'package:***REMOVED***/core/translations.dart';
import 'package:***REMOVED***/data/datasouces/cart_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/contact_us_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/contact_us_remote_datasource.dart';
import 'package:***REMOVED***/data/datasouces/customers_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/customers_remote_datasource.dart';
import 'package:***REMOVED***/data/datasouces/favorites_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/favorites_remote_datasource.dart';
import 'package:***REMOVED***/data/datasouces/materials_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/materials_remote_datasource.dart';
import 'package:***REMOVED***/data/datasouces/user_data_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/user_data_remote_datasource.dart';
import 'package:***REMOVED***/data/repositories/cart_repository.dart';
import 'package:***REMOVED***/data/repositories/contact_us_repository.dart';
import 'package:***REMOVED***/data/repositories/customers_repository.dart';
import 'package:***REMOVED***/data/repositories/favorites_repository.dart';
import 'package:***REMOVED***/data/repositories/materials_repository.dart';
import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/services/cache_fetching_service.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/services/image_caching_service.dart';
import 'package:***REMOVED***/domain/usecases/cart/get_cart_items.dart';
import 'package:***REMOVED***/domain/usecases/cart/set_cart_items.dart';
import 'package:***REMOVED***/domain/usecases/favorites/get_favorites_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/favorites/get_favorites_sync_time.dart';
import 'package:***REMOVED***/domain/usecases/materials/subscribe_to_material.dart';
import 'package:***REMOVED***/domain/usecases/user/accept_legal_doc.dart';
import 'package:***REMOVED***/domain/usecases/user/change_language.dart';
import 'package:***REMOVED***/domain/usecases/user/change_password.dart';
import 'package:***REMOVED***/domain/usecases/get_contactus_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/customer/get_customer_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/customer/get_customer_sync_data.dart';
import 'package:***REMOVED***/domain/usecases/materials/get_materials_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/materials/get_materials_sync_data.dart';
import 'package:***REMOVED***/domain/usecases/customer/get_selected_customer_sap.dart';
import 'package:***REMOVED***/domain/usecases/user/get_userdata_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/user/get_userdata_sync_time.dart';
import 'package:***REMOVED***/domain/usecases/customer/set_selected_customer_sap.dart';
import 'package:***REMOVED***/presentation/controllers/cart_controller.dart';
import 'package:***REMOVED***/presentation/controllers/contactus_controller.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/ui/screens/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await injectDependency();
  await initServices();
  await initControllers();
  runApp(GetMaterialApp(
    supportedLocales: [Locale('en'), Locale('he')],
    translations: Trs(),
    // Keep in mind,locale will owerwrite by user controller based on language from api
    locale: Get.deviceLocale,
    fallbackLocale: Locale('he'),
    theme: ThemeData(fontFamily: 'Almoni'),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
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

  ContactUsRepository contactUsRepository = Get.put(ContactUsRepositoryImpl(
      contactUsLocalDatasource: ContactUsLocalDatasourceImpl(),
      contactUsRemoteDatasource: ContactUsRemoteDatasourceImpl()));

  MaterialsRepository materialsRepository = Get.put(MaterialsRepositoryImpl(
      materialsLocalDataSource: MaterialsLocalDataSourceImpl(),
      materialsRemoteDatasource: MaterialsRemoteDatasourceImpl()));

  FavoritesRepository favoritesRepository = Get.put(FavoritesRepositoryImpl(
      favoritesRemoteDatasource: FavoritesRemoteDatasourceImpl(),
      favoritesLocalDatasource: FavoritesLocalDatasourceImpl()));

  CartRepository cartRepository = Get.put(
      CartRepositoryImpl(cartLocalDatasource: CartLocalDatasourceImpl()));

  // Use cases
  //-- userdata
  Get.put<GetUserDataAndCache>(GetUserDataAndCache(userDataRepository));
  Get.put<AcceptLegalDoc>(AcceptLegalDoc(userDataRepository));
  Get.put<ChangeLanguage>(ChangeLanguage(userDataRepository));
  Get.put<ChangePassword>(ChangePassword(userDataRepository));
  Get.put<GetUserDataSyncTime>(GetUserDataSyncTime(userDataRepository));

  //-- customers
  Get.put<GetSelectedCustomerSAP>(GetSelectedCustomerSAP(customersRepository));
  Get.put<SetSelectedCustomerSAP>(SetSelectedCustomerSAP(customersRepository));
  Get.put<GetCustomerAndCache>(GetCustomerAndCache(customersRepository));
  Get.put<GetCustomerSyncData>(GetCustomerSyncData(customersRepository));

  //-- contactus
  Get.put<GetContactusAndCache>(GetContactusAndCache(contactUsRepository));

  //-- materials
  Get.put<GetMaterialsAndCache>(GetMaterialsAndCache(materialsRepository));
  Get.put<GetMaterialsSyncData>(GetMaterialsSyncData(materialsRepository));
  Get.put<SubscribeToMaterial>(SubscribeToMaterial(materialsRepository));

  // Favorites
  Get.put<GetFavoritesAndCache>(GetFavoritesAndCache(favoritesRepository));
  Get.put<GetFavoritesSyncTime>(GetFavoritesSyncTime(favoritesRepository));

  // Cart
  Get.put<GetCartItems>(GetCartItems(cartRepository));
  Get.put<SetCartItems>(SetCartItems(cartRepository));

  print('injected dependencies...');
}

Future initServices() async {
  print('starting services ...');
  await GetStorage.init();
  await Get.putAsync(() => ConnectionService().init());
  await Get.put(ImageCachingService());
  await Get.putAsync(() => CacheFetchingService(Duration(minutes: 30)).init());
  print('All services started...');
}

Future initControllers() async {
  print('starting controllers ...');
  Get.put(UserDataController(), permanent: true);
  Get.put(CustomerController(), permanent: true);
  Get.put(ContactusController(), permanent: true);
  Get.put(MaterialsCatalogController(), permanent: true);
  Get.put(FavoritesController(), permanent: true);
  Get.put(CartController(), permanent: true);

  print('All controllers started...');
}
