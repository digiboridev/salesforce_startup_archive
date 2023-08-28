import 'package:salesforce.startup/domain/services/connections_service.dart';
import 'package:salesforce.startup/presentation/controllers/contactus_controller.dart';
import 'package:salesforce.startup/presentation/controllers/customer_controller.dart';
import 'package:salesforce.startup/presentation/controllers/materials_catalog_controller.dart';
import 'package:salesforce.startup/presentation/controllers/materials_catalog_states.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller.dart';
import 'package:salesforce.startup/presentation/controllers/user_data_controller_states.dart';
import 'package:salesforce.startup/presentation/ui/screens/expired_password_screen.dart';
import 'package:salesforce.startup/presentation/ui/screens/just_loading_screen.dart';
import 'package:salesforce.startup/presentation/ui/screens/main_screen/main_screen.dart';
import 'package:salesforce.startup/presentation/ui/screens/legal_doc_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Loader provides view functionality of initial loading process
// Handle loading state of core controllers and prsent usercases of retry, load and legal doc acceptation
class Loader extends StatelessWidget {
  final UserDataController userDataController = Get.find();
  final CustomerController customerController = Get.find();
  final ContactusController contactusController = Get.find();
  final ConnectionService connectionService = Get.find();
  final MaterialsCatalogController materialsCatalogController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      UserDataState userDataState = userDataController.userDataState;

      // User data loading part
      //
      if (userDataState is UserDataAskLegalDocState) {
        return LegalDocScreen(
          legalDocLink: userDataState.legalDoc,
          buttonText: 'Understood'.tr,
          callback: () => userDataController.acceptLegalDoc(),
        );
      }

      if (userDataState is UserDataChangePasswordState) {
        return ExpiredPasswordScreen();
      }

      if (userDataState is UserDataCommonState) {
        // Customer loading part
        //
        if (customerController.selectedCustomer != null) {
          // Catalog loading part
          //
          if (materialsCatalogController.materialsCatalogState.value is MCSCommon) {
            return MainScreen();
          }
        }
      }

      return JustLoadingScreen();
    });
  }
}
