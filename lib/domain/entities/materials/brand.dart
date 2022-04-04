import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final String SFId;
  final int? Index;
  final String ImageUrl;
  final String Display;
  Brand({
    required this.SFId,
    required this.Index,
    required this.ImageUrl,
    required this.Display,
  });

  @override
  List<Object> get props => [SFId, Index ?? 0, ImageUrl, Display];

  @override
  String toString() {
    return 'Brand(SFId: $SFId, Index: $Index, ImageUrl: $ImageUrl, Display: $Display)';
  }
}
