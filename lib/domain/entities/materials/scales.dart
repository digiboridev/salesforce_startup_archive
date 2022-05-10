import 'package:equatable/equatable.dart';

class Scales extends Equatable {
  final String Unit;
  final num ScaleQuantityFrom;
  final num Rate;
  Scales({
    required this.Unit,
    required this.ScaleQuantityFrom,
    required this.Rate,
  });

  @override
  List<Object> get props => [Unit, ScaleQuantityFrom, Rate];

  @override
  String toString() =>
      'Scales(Unit: $Unit, ScaleQuantityFrom: $ScaleQuantityFrom, Rate: $Rate)';
}
