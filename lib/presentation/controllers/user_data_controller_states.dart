import 'package:equatable/equatable.dart';

import 'package:***REMOVED***/domain/entities/user_data.dart';

abstract class UserDataState {}

class UserDataInitialState extends UserDataState {}

class UserDataLoadingState extends UserDataState {}

class UserDataLoadingErrorState extends UserDataState with EquatableMixin {
  final String msg;
  UserDataLoadingErrorState({
    required this.msg,
  });

  @override
  List<Object> get props => [msg];

  @override
  String toString() => 'UserDataLoadingErrorState(msg: $msg)';
}

class UserDataCommonState extends UserDataState with EquatableMixin {
  final UserData userData;
  UserDataCommonState({
    required this.userData,
  });

  @override
  List<Object> get props => [userData];

  @override
  String toString() => 'UserDataCommonState(userData: $userData)';
}

class UserDataUpdatingState extends UserDataCommonState {
  UserDataUpdatingState({
    required UserData userData,
  }) : super(userData: userData);
}

class UserDataAskLegalDocState extends UserDataState with EquatableMixin {
  final Uri legalDoc;
  UserDataAskLegalDocState({
    required this.legalDoc,
  });

  @override
  List<Object> get props => [legalDoc];

  @override
  String toString() => 'UserDataAskLegalDocState(legalDoc: $legalDoc)';
}
