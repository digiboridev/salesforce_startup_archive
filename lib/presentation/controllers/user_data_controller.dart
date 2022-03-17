import 'dart:async';

import 'package:***REMOVED***/domain/entities/auth_data.dart';
import 'package:***REMOVED***/domain/services/sf_sdk_service.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {
  SFSDKService sfsdkService = SFSDKService();

  Rxn<AuthData> authData = Rxn<AuthData>();

  @override
  void onReady() {
    super.onReady();
    listenByTimer();
  }

  listenByTimer() {
    Timer.periodic(Duration(seconds: 1), (t) async {
      AuthData? d = await sfsdkService.authData;
      authData.value = d;
      print(authData);
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
