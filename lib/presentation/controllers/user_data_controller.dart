import 'dart:async';
import 'package:***REMOVED***/core/languages.dart';
import 'package:***REMOVED***/domain/usecases/accept_legal_doc.dart';
import 'package:***REMOVED***/domain/usecases/change_language.dart';
import 'package:***REMOVED***/domain/usecases/change_password.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/default_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:***REMOVED***/domain/entities/auth_data.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';
import 'package:***REMOVED***/domain/services/sf_sdk_service.dart';
import 'package:***REMOVED***/domain/usecases/get_userdata_and_cache.dart';

class UserDataController extends GetxController {
  // dependencies
  SFSDKService _sfsdkService = SFSDKService();

  // usecases
  GetUserDataAndCache _getUserDataAndCache = Get.find();
  AcceptLegalDoc _acceptLegaloc = Get.find();
  ChangeLanguage _changeLanguage = Get.find();
  ChangePassword _changePassword = Get.find();

  // valiables
  Rxn<AuthData> _authData = Rxn<AuthData>();
  AuthData? get authData => _authData.value;

  Rx<UserDataState> _userDataState = Rx(UserDataInitialState());
  UserDataState get userDataState => _userDataState.value;
  Rx<UserDataState> get userDataStateStream => _userDataState;

  late StreamSubscription _sub;

  @override
  void onReady() {
    super.onReady();
    bindToAuthEvent();
  }

  @override
  void onClose() {
    super.onClose();
    if (_sub is StreamSubscription) _sub.cancel();
  }

  bindToAuthEvent() async {
    AuthData? d = await _sfsdkService.authData;
    handleAuthData(authData: d);

    _sub = _sfsdkService.authEventStream.listen((event) async {
      AuthData? d = await _sfsdkService.authData;
      handleAuthData(authData: d);
    });
  }

  handleAuthData({required AuthData? authData}) {
    _authData.value = authData;
    loadUserData();
    print(_authData);
  }

  Future loadUserData() async {
    if (_authData.value == null) {
      _userDataState.value = UserDataInitialState();
    }
    _userDataState.value = UserDataLoadingState();
    try {
      UserData userData = await _getUserDataAndCache(_authData.value!.userId);
      if (!userData.hasAcceptedLegalDoc) {
        _userDataState.value =
            UserDataAskLegalDocState(legalDoc: userData.legalDoc);
      } else {
        _userDataState.value = UserDataCommonState(userData: userData);
      }
    } catch (e) {
      print(e);
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

  Uri get legalocLink {
    var state = _userDataState.value;
    if (state is UserDataCommonState) {
      return state.userData.legalDoc;
    } else {
      throw Exception('Operation denied');
    }
  }

  Future acceptLegalDoc() async {
    try {
      await _acceptLegaloc(NoParams());
      loadUserData();
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.amber);
    }
  }

  List<Languages> get avaliableLanguages {
    var state = _userDataState.value;
    if (state is UserDataCommonState) {
      List<Languages> languages = [];
      state.userData.availableLanguages.split(',').forEach((identifier) {
        var l = Languages.fromIdentifier(identifier: identifier);
        languages.add(l);
      });
      return languages;
    } else {
      throw Exception('Operation denied');
    }
  }

  Languages get currentLanguage {
    var state = _userDataState.value;
    if (state is UserDataCommonState) {
      return Languages.fromIdentifier(
          identifier: state.userData.selectedLanguage);
    } else {
      throw Exception('Operation denied');
    }
  }

  Future changeLanguage({required Languages lang}) async {
    try {
      defaultDialog();

      await _changeLanguage(ChangeLanguageParams(lang: lang));
      await updateUserData();
      Get.until((route) => !Get.isDialogOpen!);
    } catch (e) {
      Get.until((route) => !Get.isDialogOpen!);
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.amber);
    }
  }

  Future changePassword(
      {required String oldPass, required String newPass}) async {
    try {
      defaultDialog();
      await _changePassword
          .call(ChangePasswordParams(oldPass: oldPass, newPass: newPass));
      Get.until((route) => !Get.isDialogOpen!);
    } catch (e) {
      Get.until((route) => !Get.isDialogOpen!);
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.amber);
    }
  }

  Future<void> logout() async {
    _sfsdkService.logout();
    Get.until((route) => Get.currentRoute == '/');
  }
}
