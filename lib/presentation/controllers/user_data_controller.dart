import 'dart:async';
import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/domain/usecases/accept_legal_doc.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:***REMOVED***/data/datasouces/user_data_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/user_data_remote_datasource.dart';
import 'package:***REMOVED***/data/repositories/user_data_repository.dart';
import 'package:***REMOVED***/domain/entities/auth_data.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';
import 'package:***REMOVED***/domain/services/sf_sdk_service.dart';
import 'package:***REMOVED***/domain/usecases/get_userdata_and_cache.dart';

class UserDataController extends GetxController {
  SFSDKService sfsdkService = SFSDKService();

  GetUserDataAndCache _getUserDataAndCache = GetUserDataAndCache(
      UserDataRepositoryImpl(
          userDataLocalDatasource: UserDataLocalDatasourceImpl(),
          userDataRemoteDatasource: UserDataRemoteDatasourceImpl()));

  AcceptLegalDoc _acceptLegaloc = AcceptLegalDoc(UserDataRepositoryImpl(
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
      UserData userData = await _getUserDataAndCache(_authData.value!.userId);
      if (userData.hasAcceptedLegalDoc) {
        _userDataState.value =
            UserDataAskLegalDocState(legalDoc: userData.legalDoc);
      } else {
        _userDataState.value = UserDataCommonState(userData: userData);
      }
    } catch (e) {
      _userDataState.value = UserDataLoadingErrorState(msg: e.toString());
    }
  }

  Future updateUserData() async {
    UserDataState oldState = _userDataState.value;
    if (oldState is UserDataCommonState) {
      _userDataState.value = UserDataUpdatingState(userData: oldState.userData);
      try {
        UserData userData = await _getUserDataAndCache(_authData.value!.userId);
        _userDataState.value = UserDataCommonState(userData: userData);
      } catch (e) {
        print('Update user data error');
        print(e);
        _userDataState.value = oldState;
      }
    }
  }

  Future acceptLegalDoc() async {
    try {
      await _acceptLegaloc(null);
      loadUserData();
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.amber);
    }
  }
}
