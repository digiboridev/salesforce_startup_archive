import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/contactus_controller.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/expired_password_screen.dart';
import 'package:***REMOVED***/presentation/ui/screens/just_loading_screen.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/main_screen.dart';
import 'package:***REMOVED***/presentation/ui/screens/legal_doc_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Loader provides view functionality of initial loading process
// Handle loading state of core controllers and prsent usercases of retry, load and legal doc acceptation
class Loader extends StatelessWidget {
  final UserDataController userDataController = Get.find();
  final CustomerController customerController = Get.find();
  final ContactusController contactusController = Get.find();
  final ConnectionService connectionService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      UserDataState userDataState = userDataController.userDataState;

      if (userDataState is UserDataLoadingState) {
        return JustLoadingScreen();
      }

      if (userDataState is UserDataLoadingErrorState) {
        return JustLoadingScreen();
      }

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
        if (customerController.customerLoadingError is String) {
          return JustLoadingScreen();
        }

        if (customerController.selectedCustomer == null) {
          return JustLoadingScreen();
        }

        return MainScreen();
      }

      return JustLoadingScreen();
    });
  }
}
