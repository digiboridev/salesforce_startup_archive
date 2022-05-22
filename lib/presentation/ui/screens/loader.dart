import 'package:***REMOVED***/core/mycolors.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/contactus_controller.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/expired_password_screen.dart';
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
        return Scaffold(
          backgroundColor: MyColors.blue_003E7E,
          body: SafeArea(
              bottom: false,
              child: Container(
                color: MyColors.white_F4F4F6,
                child: SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('User loading error'.tr),
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
                          child: Text('try again'.tr),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        );
      }

      if (userDataState is UserDataAskLegalDocState) {
        return LegalDocScreen(
          legalDocLink: userDataState.legalDoc,
          buttonText: 'Understood'.tr,
          callback: () {
            if (!connectionService.hasConnection) {
              Get.snackbar('Error'.tr, 'No internet'.tr,
                  backgroundColor: Colors.amber);
              return;
            }

            userDataController.acceptLegalDoc();
          },
        );
      }

      if (userDataState is UserDataChangePasswordState) {
        return ExpiredPasswordScreen();
      }

      if (userDataState is UserDataCommonState) {
        if (customerController.customerLoadingError is String) {
          return Scaffold(
            backgroundColor: MyColors.blue_003E7E,
            body: SafeArea(
                bottom: false,
                child: Container(
                  color: MyColors.white_F4F4F6,
                  child: SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Customer loading error'.tr),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        Text(customerController.customerLoadingError!),
                        SizedBox(
                          height: Get.width * 0.06,
                        ),
                        GestureDetector(
                          onTap: () => customerController.loadCustomers(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.06)),
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.1,
                                vertical: Get.width * 0.03),
                            child: Text('try again'.tr),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
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

class JustLoadingScreen extends StatelessWidget {
  const JustLoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue_003E7E,
      body: Container(
          color: MyColors.white_F4F4F6,
          child: Center(child: CircularProgressIndicator())),
    );
  }
}
