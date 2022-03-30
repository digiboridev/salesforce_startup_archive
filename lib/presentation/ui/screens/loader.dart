import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/presentation/controllers/customer_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/home_screen.dart';
import 'package:***REMOVED***/presentation/ui/widgets/legal_doc_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Loader provides view functionality of initial loading process
// Handle loading state of core controllers and prsent usercases of retry load and legal doc acceptation
class Loader extends StatelessWidget {
  final UserDataController userDataController =
      Get.put(UserDataController(), permanent: true);
  final CustomerController customerController = Get.put(CustomerController());
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
          body: SafeArea(
              child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('User loading error'),
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
                        borderRadius: BorderRadius.circular(Get.width * 0.06)),
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: Get.width * 0.03),
                    child: Text('try again'),
                  ),
                )
              ],
            ),
          )),
        );
      }

      if (userDataState is UserDataAskLegalDocState) {
        return LegalDocView(
          legalDocLink: userDataState.legalDoc,
          buttonText: 'Understood',
          callback: () {
            if (!connectionService.hasConnection) {
              Get.snackbar('Error', 'No internet',
                  backgroundColor: Colors.amber);
              return;
            }

            userDataController.acceptLegalDoc();
          },
        );
      }

      if (userDataState is UserDataCommonState) {
        if (customerController.customerLoadingError is String) {
          return Scaffold(
            body: SafeArea(
                child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Customer loading error'),
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
                      child: Text('try again'),
                    ),
                  )
                ],
              ),
            )),
          );
        }

        if (customerController.selectedCustomer == null) {
          return JustLoadingScreen();
        }

        return HomeScreen();
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
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
