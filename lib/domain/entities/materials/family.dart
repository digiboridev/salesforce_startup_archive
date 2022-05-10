import 'package:equatable/equatable.dart';

class Family extends Equatable {
  final String SFId;
  final int IndexNumber;
  final String ImageUrl;
  final String Display;
  Family({
    required this.SFId,
    required this.IndexNumber,
    required this.ImageUrl,
    required this.Display,
  });

  @override
  List<Object> get props => [SFId, IndexNumber, ImageUrl, Display];

  @override
  String toString() {
    return 'Family(SFId: $SFId, IndexNumber: $IndexNumber, ImageUrl: $ImageUrl, Display: $Display)';
  }
}
