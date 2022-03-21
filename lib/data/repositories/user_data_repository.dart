import 'package:***REMOVED***/data/datasouces/user_data_remote_datasource.dart';
import 'package:***REMOVED***/domain/entities/user_data.dart';

abstract class UserDataRepository {
  Future<UserData> get getRemoteUserData;
}

class UserDataRepositoryImpl implements UserDataRepository {
  final UserDataRemoteDatasource userDataRemoteDatasource;

  UserDataRepositoryImpl({
    required this.userDataRemoteDatasource,
  });

  @override
  Future<UserData> get getRemoteUserData =>
      userDataRemoteDatasource.getUserData;
}
