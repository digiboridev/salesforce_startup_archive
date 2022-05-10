import 'package:equatable/equatable.dart';

class Classification extends Equatable {
  final String SFId;
  final int Index;
  final String Display;
  Classification({
    required this.SFId,
    required this.Index,
    required this.Display,
  });

  @override
  List<Object> get props => [SFId, Index, Display];

  @override
  String toString() =>
      'Classification(SFId: $SFId, Index: $Index, Display: $Display)';
}
