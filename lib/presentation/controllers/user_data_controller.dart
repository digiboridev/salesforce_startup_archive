import 'dart:async';
import 'package:***REMOVED***/core/languages.dart';
import 'package:***REMOVED***/domain/entities/auth_data.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';
import 'package:***REMOVED***/domain/services/cache_fetching_service.dart';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:***REMOVED***/domain/services/sf_sdk_service.dart';
import 'package:***REMOVED***/domain/usecases/usecase.dart';
import 'package:***REMOVED***/domain/usecases/user/accept_legal_doc.dart';
import 'package:***REMOVED***/domain/usecases/user/change_language.dart';
import 'package:***REMOVED***/domain/usecases/user/change_password.dart';
import 'package:***REMOVED***/domain/usecases/user/get_userdata_and_cache.dart';
import 'package:***REMOVED***/domain/usecases/user/get_userdata_sync_time.dart';
import 'package:***REMOVED***/presentation/controllers/user_data_controller_states.dart';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/default_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {
  // dependencies
  SFSDKService _sfsdkService = SFSDKService();
  CacheFetchingService _cacheFetchingService = Get.find();
  ConnectionService _connectionService = Get.find();

  // usecases
  GetUserDataAndCache _getUserDataAndCache = Get.find();
  AcceptLegalDoc _acceptLegaloc = Get.find();
  ChangeLanguage _changeLanguage = Get.find();
  ChangePassword _changePassword = Get.find();
  GetUserDataSyncTime _getUserDataSyncTime = Get.find();

  // valiables
  Rxn<AuthData> _authData = Rxn<AuthData>();
  AuthData? get authData => _authData.value;

  Rx<UserDataState> _userDataState = Rx(UserDataInitialState());
  UserDataState get userDataState => _userDataState.value;
  Rx<UserDataState> get userDataStateStream => _userDataState;

  StreamSubscription? _sub;

  @override
  void onReady() {
    super.onReady();
    bindToAuthEvent();
  }

  @override
  void onClose() {
    super.onClose();
    if (_sub is StreamSubscription) _sub!.cancel();
  }

  // Load last user data state and start listen to changes
  bindToAuthEvent() async {
    AuthData? d = await _sfsdkService.authData;
    handleAuthData(authData: d);

    _sub = _sfsdkService.authEventStream.listen((event) async {
      AuthData? d = await _sfsdkService.authData;
      handleAuthData(authData: d);
    });
  }

  // Reloads user data if new data not equal to old one
  handleAuthData({required AuthData? authData}) {
    if (_authData.value != authData) {
      _authData.value = authData;
      loadUserData();
    }
    print(_authData);
  }

  Future loadUserData() async {
    // Return to initial state, null means  the user log outed
    if (_authData.value == null) {
      _userDataState.value = UserDataInitialState();
      return;
    }

    // AppVersionService.checkVersion();

    // emit loading state
    _userDataState.value = UserDataLoadingState();

    // Load user data
    try {
      UserData userData = await _getUserDataAndCache(GetUserDataAndCacheParams(
          userId: _authData.value!.userId,
          hasConnection: _connectionService.hasConnection));

      // emmit accept legaldoc state if not

      if (!userData.hasAcceptedLegalDoc) {
        _userDataState.value =
            UserDataAskLegalDocState(legalDoc: userData.legalDoc);
      }
      // emmit change password state if needed

      else if (!userData.didChangePassword) {
        _userDataState.value = UserDataChangePasswordState();
      }
      // load complete
      else {
        _userDataState.value = UserDataCommonState(userData: userData);
        // Set locale based on user data
        setLocale();

        // Register in cache fetching service
        CacheUpdateEvent cacheUpdateEvent = CacheUpdateEvent(
            tag: 'user',
            updateActionCallback: updateUserData,
            lastUpdateTimeCallback: getLastSync);
        _cacheFetchingService.registerEvent(cacheUpdateEvent: cacheUpdateEvent);
      }
    } catch (e) {
      // emit error state
      print(e);
      _userDataState.value = UserDataLoadingErrorState(msg: e.toString());
    }
  }

  Future<DateTime> getLastSync() async {
    return _getUserDataSyncTime.call(_authData.value!.userId);
  }

  Future updateUserData() async {
    UserDataState oldState = _userDataState.value;
    if (oldState is UserDataCommonState) {
      try {
        UserData userData = await _getUserDataAndCache(
            GetUserDataAndCacheParams(
                userId: _authData.value!.userId,
                hasConnection: _connectionService.hasConnection));
        _userDataState.value = UserDataCommonState(userData: userData);

        setLocale();
      } catch (e) {
        print('Update user data error');
        print(e);
      }
    }
  }

  setLocale() {
    if (Get.locale!.languageCode != currentLanguage.identifier) {
      Get.updateLocale(Locale(currentLanguage.identifier));
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

  String get currencyKey {
    var state = _userDataState.value;
    if (state is UserDataCommonState) {
      return state.userData.currencyKey;
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
      {required String oldPass,
      required String newPass,
      bool onlogin = false}) async {
    try {
      defaultDialog();
      await _changePassword
          .call(ChangePasswordParams(oldPass: oldPass, newPass: newPass));
      Get.until((route) => !Get.isDialogOpen!);
      if (onlogin) loadUserData();
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
