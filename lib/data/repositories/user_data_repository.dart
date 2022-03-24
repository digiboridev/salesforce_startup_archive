import 'package:***REMOVED***/core/languages.dart';
import 'package:***REMOVED***/data/datasouces/user_data_local_datasource.dart';
import 'package:***REMOVED***/data/datasouces/user_data_remote_datasource.dart';
import 'package:***REMOVED***/data/models/user_data_model.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';

abstract class UserDataRepository {
  Future<UserData> get getRemoteUserData;
  Future<UserData> getLocalUserData({required userId});
  Future setLocalUserData({required userId, required UserData userData});
  Future<void> acceptLegalDoc();
  Future<void> changeLanguage({required Languages lang});
}

class UserDataRepositoryImpl implements UserDataRepository {
  final UserDataRemoteDatasource userDataRemoteDatasource;
  final UserDataLocalDatasource userDataLocalDatasource;

  UserDataRepositoryImpl(
      {required this.userDataRemoteDatasource,
      required this.userDataLocalDatasource});

  @override
  Future<UserData> get getRemoteUserData =>
      userDataRemoteDatasource.getUserData;

  @override
  Future<UserData> getLocalUserData({required userId}) =>
      userDataLocalDatasource.getUserData(userId: userId);

  @override
  Future setLocalUserData({required userId, required UserData userData}) =>
      userDataLocalDatasource.setUserData(
          userId: userId, userDataModel: UserDataModel.fromEnitty(userData));

  @override
  Future<void> acceptLegalDoc() => userDataRemoteDatasource.acceptLegalDoc();

  @override
  Future<void> changeLanguage({required Languages lang}) =>
      userDataRemoteDatasource.changeLanguage(lang: lang);
}
