import 'package:salesforce.startup/core/languages.dart';
import 'package:salesforce.startup/data/datasouces/user_data_local_datasource.dart';
import 'package:salesforce.startup/data/datasouces/user_data_remote_datasource.dart';
import 'package:salesforce.startup/data/models/user_data_model.dart';
import 'package:salesforce.startup/domain/entities/user_data.dart';

abstract class UserDataRepository {
  Future<UserData> get getRemoteUserData;
  Future<UserData> getLocalUserData({required userId});
  Future setLocalUserData({required userId, required UserData userData});
  Future setUserDataSyncTime({required String userId, required DateTime dateTime});
  Future<DateTime> getUserDataSyncTime({required String userId});
  Future<void> acceptLegalDoc();
  Future<void> changeLanguage({required Languages lang});
  Future<void> changePassword({required String oldPass, required String newPass});
}

class UserDataRepositoryImpl implements UserDataRepository {
  final UserDataRemoteDatasource userDataRemoteDatasource;
  final UserDataLocalDatasource userDataLocalDatasource;

  UserDataRepositoryImpl({required this.userDataRemoteDatasource, required this.userDataLocalDatasource});

  @override
  Future<UserData> get getRemoteUserData => userDataRemoteDatasource.getUserData;

  @override
  Future<UserData> getLocalUserData({required userId}) => userDataLocalDatasource.getUserData(userId: userId);

  @override
  Future setLocalUserData({required userId, required UserData userData}) =>
      userDataLocalDatasource.setUserData(userId: userId, userDataModel: UserDataModel.fromEnitty(userData));

  @override
  Future setUserDataSyncTime({required String userId, required DateTime dateTime}) =>
      userDataLocalDatasource.setUserDataSyncTime(userId: userId, dateTime: dateTime);

  @override
  Future<DateTime> getUserDataSyncTime({required String userId}) => userDataLocalDatasource.getUserDataSyncTime(userId: userId);

  @override
  Future<void> acceptLegalDoc() => userDataRemoteDatasource.acceptLegalDoc();

  @override
  Future<void> changeLanguage({required Languages lang}) => userDataRemoteDatasource.changeLanguage(lang: lang);
  @override
  Future<void> changePassword({required String oldPass, required String newPass}) =>
      userDataRemoteDatasource.changePassword(oldPass: oldPass, newPass: newPass);
}
