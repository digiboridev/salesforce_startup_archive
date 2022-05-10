import 'package:equatable/equatable.dart';

class Hierarchy extends Equatable {
  final String SFId;
  final String Display;
  Hierarchy({
    required this.SFId,
    required this.Display,
  });

  @override
  List<Object> get props => [SFId, Display];

  @override
  String toString() => 'Hierarchy(SFId: $SFId, Display: $Display)';
}
