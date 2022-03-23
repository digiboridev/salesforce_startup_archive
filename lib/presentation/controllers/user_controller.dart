import 'dart:async';
import 'package:***REMOVED***/presentation/controllers/user_controller_states.dart';
import 'package:get/get.dart';

import 'package:***REMOVED***/data/datasouces/user_data_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/user_data_remote_datasource.dart';
import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/entities/auth_data.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';
import 'package:***REMOVED***/domain/services/sf_sdk_service.dart';
import 'package:***REMOVED***/domain/usecases/get_userdata_and_cache.dart';

class UserController extends GetxController {
  SFSDKService sfsdkService = SFSDKService();

  GetUserDataAndCache getUserDataAndCache = GetUserDataAndCache(
      UserDataRepositoryImpl(
          userDataLocalDatasource: UserDataLocalDatasourceImpl(),
          userDataRemoteDatasource: UserDataRemoteDatasourceImpl()));

  Rxn<AuthData> _authData = Rxn<AuthData>();
  AuthData? get authData => _authData.value;

  Rx<UserDataState> _userDataState = Rx(UserDataInitialState());
  UserDataState get userDataState => _userDataState.value;

  @override
  void onReady() {
    super.onReady();
    listenByTimer();
  }

  listenByTimer() {
    Timer.periodic(Duration(seconds: 1), (t) async {
      AuthData? d = await sfsdkService.authData;
      if (_authData.value != d) {
        _authData.value = d;
        loadUserData();
        print(_authData);
      }
    });
  }

  Future loadUserData() async {
    if (_authData.value == null) {
      _userDataState.value = UserDataInitialState();
    }
    _userDataState.value = UserDataLoadingState();
    try {
      UserData userData = await getUserDataAndCache(_authData.value!.userId);
      UserDataState state = _userDataState.value;
      if (state is UserDataCommonState) {
        print('Sameobj');
        print(state.userData == userData);
      }

      _userDataState.value = UserDataCommonState(userData: userData);
    } catch (e) {
      _userDataState.value = UserDataLoadingErrorState(msg: e.toString());
    }
  }

  Future updateUserData() async {
    try {
      UserData userData = await getUserDataAndCache(_authData.value!.userId);
      UserDataState state = _userDataState.value;
      if (state is UserDataCommonState) {
        print('Sameobj');
        print(state.userData == userData);
      }

      _userDataState.value = UserDataCommonState(userData: userData);
    } catch (e) {
      print('Update user data error');
      print(e);
    }
  }
}
