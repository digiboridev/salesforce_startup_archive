import 'package:equatable/equatable.dart';

class FavoriteItem extends Equatable {
  final String materialNumber;
  final String sFId;
  final String unit;
  final num quantity;
  FavoriteItem({
    required this.materialNumber,
    required this.sFId,
    required this.unit,
    required this.quantity,
  });

  @override
  List<Object> get props => [materialNumber, sFId, unit, quantity];

  @override
  String toString() {
    return 'FavoriteItem(materialNumber: $materialNumber, sFId: $sFId, unit: $unit, quantity: $quantity)';
  }

  FavoriteItem copyWith({
    String? materialNumber,
    String? sFId,
    String? unit,
    num? quantity,
  }) {
    return FavoriteItem(
      materialNumber: materialNumber ?? this.materialNumber,
      sFId: sFId ?? this.sFId,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }
}
