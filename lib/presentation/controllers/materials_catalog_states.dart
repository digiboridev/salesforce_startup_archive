import 'package:***REMOVED***/domain/entities/materials/materials_catalog.dart';
import 'package:equatable/equatable.dart';

abstract class MaterialsCatalogState {}

class MCSInitial extends MaterialsCatalogState {}

class MCSLoading extends MaterialsCatalogState {}

class MCSLoadingError extends MaterialsCatalogState with EquatableMixin {
  final String errorMsg;
  MCSLoadingError({
    required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];

  @override
  String toString() => 'MCSLoadingError(errorMsg: $errorMsg)';
}

class MCSCommon extends MaterialsCatalogState with EquatableMixin {
  final MaterialsCatalog catalog;
  MCSCommon({
    required this.catalog,
  });

  @override
  List<Object> get props => [catalog];

  @override
  String toString() => 'MCSCommon(catalog: $catalog)';
}
