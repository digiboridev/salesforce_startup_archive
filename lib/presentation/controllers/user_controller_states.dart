import 'package:***REMOVED***/domain/entities/user_data.dart';

abstract class UserDataState {}

class UserDataInitialState extends UserDataState {}

class UserDataLoadingState extends UserDataState {}

class UserDataLoadingErrorState extends UserDataState {
  final String msg;
  UserDataLoadingErrorState({
    required this.msg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDataLoadingErrorState && other.msg == msg;
  }

  @override
  int get hashCode => msg.hashCode;

  @override
  String toString() => 'UserDataLoadingErrorState(msg: $msg)';
}

class UserDataCommonState extends UserDataState {
  final UserData userData;
  UserDataCommonState({
    required this.userData,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDataCommonState && other.userData == userData;
  }

  @override
  int get hashCode => userData.hashCode;

  @override
  String toString() => 'UserDataCommonState(userData: $userData)';
}
