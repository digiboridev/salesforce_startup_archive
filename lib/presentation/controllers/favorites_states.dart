import 'package:equatable/equatable.dart';

import 'package:salesforce.startup/domain/entities/favorites/favorite_list.dart';

abstract class FavoritesState {}

class FSInitial extends FavoritesState {}

class FSLoading extends FavoritesState {}

class FSLoadingError extends FavoritesState with EquatableMixin {
  final String errorMsg;
  FSLoadingError({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];

  @override
  String toString() => 'FSLoadingError(errorMsg: $errorMsg)';
}

class FSCommon extends FavoritesState with EquatableMixin {
  final List<FavoriteList> favoriteLists;
  FSCommon({
    required this.favoriteLists,
  });

  @override
  List<Object> get props => [favoriteLists];

  @override
  String toString() => 'FSCommon(favoriteLists: $favoriteLists)';
}
