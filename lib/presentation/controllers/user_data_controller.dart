import 'dart:async';
import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/core/languages.dart';
import 'package:***REMOVED***/domain/entities/auth_data.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';
import 'package:***REMOVED***/domain/services/app_version_service.dart';
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
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/info_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {
  // dependencies
  SFSDKService _sfsdkService = Get.find();
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

  // Perform full load with loading states
  // Uses for initial loading, or auth changes
  Future loadUserData({bool forceRemote = false}) async {
    // Return to initial state, null means  the user log outed
    if (_authData.value == null) {
      _userDataState.value = UserDataInitialState();
      return;
    }

    // _userDataState.value = UserDataLoadingErrorState(msg: 'error');
    // return;

    // await AppVersionService.checkVersion();

    // emit loading state
    _userDataState.value = UserDataLoadingState();

    // Load user data
    try {
      UserData userData = await _getUserDataAndCache(GetUserDataAndCacheParams(
          userId: _authData.value!.userId,
          hasConnection: _connectionService.hasConnection,
          forceRemote: forceRemote));

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
        // Set locale based on user data
        setLocale(locale: userData.selectedLanguage);

        _userDataState.value = UserDataCommonState(userData: userData);

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
      Get.bottomSheet(
        WillPopScope(
          onWillPop: () async => false,
          child: InfoBottomSheet(
              headerText: 'Error while load user data',
              mainText: e.toString(),
              actions: [
                InfoAction(
                    text: 'Retry',
                    callback: () {
                      Get.back();
                      loadUserData(forceRemote: forceRemote);
                    })
              ],
              headerIconPath: AssetImages.info),
        ),
        isDismissible: false,
      );
    }
  }

  // Perform only update of data, without side states
  Future updateUserData({bool forceRemote = false}) async {
    UserDataState oldState = _userDataState.value;
    if (oldState is UserDataCommonState) {
      UserData userData = await _getUserDataAndCache(
        GetUserDataAndCacheParams(
          userId: _authData.value!.userId,
          hasConnection: _connectionService.hasConnection,
          forceRemote: forceRemote,
        ),
      );
      setLocale(locale: userData.selectedLanguage);
      _userDataState.value = UserDataCommonState(userData: userData);
    }
  }

  Future<DateTime> getLastSync() async {
    return _getUserDataSyncTime.call(_authData.value!.userId);
  }

  setLocale({required String locale}) {
    if (Get.locale!.languageCode != locale) {
      Get.updateLocale(Locale(locale));
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
      Get.bottomSheet(InfoBottomSheet(
          headerText: 'Error',
          mainText: e.toString(),
          actions: [InfoAction(text: 'Ok', callback: () => Get.back())],
          headerIconPath: AssetImages.info));
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
      await updateUserData(forceRemote: true);
      Get.until((route) => !Get.isDialogOpen!);
    } catch (e) {
      Get.until((route) => !Get.isDialogOpen!);
      Get.bottomSheet(InfoBottomSheet(
          headerText: 'Error',
          mainText: e.toString(),
          actions: [InfoAction(text: 'Ok', callback: () => Get.back())],
          headerIconPath: AssetImages.info));
    }
  }

  Future changePassword(
      {required String oldPass,
      required String newPass,
      bool onlogin = false}) async {
    try {
      await _changePassword
          .call(ChangePasswordParams(oldPass: oldPass, newPass: newPass));
      if (onlogin) loadUserData(forceRemote: true);
    } catch (e) {
      Get.bottomSheet(InfoBottomSheet(
          headerText: 'Error',
          mainText: e.toString(),
          actions: [InfoAction(text: 'Ok', callback: () => Get.back())],
          headerIconPath: AssetImages.info));
    }
  }

  Future<void> logout() async {
    _sfsdkService.logout();
    Get.until((route) => Get.currentRoute == '/');
  }
}
