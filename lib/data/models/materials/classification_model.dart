import 'dart:convert';
import 'package:***REMOVED***/domain/entities/materials/classification.dart';

class ClassificationModel extends Classification {
  ClassificationModel({
    required String SFId,
    required int Index,
    required String Display,
  }) : super(SFId: SFId, Index: Index, Display: Display);

  Map<String, dynamic> toMap() {
    return {
      'SFId': SFId,
      'Index': Index,
      'Display': Display,
    };
  }

  factory ClassificationModel.fromMap(Map<String, dynamic> map) {
    return ClassificationModel(
      SFId: map['SFId'],
      Index: map['Index'],
      Display: map['Display'],
    );
  }

  factory ClassificationModel.fromEntity(Classification classification) {
    return ClassificationModel(
      SFId: classification.SFId,
      Index: classification.Index,
      Display: classification.Display,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassificationModel.fromJson(String source) =>
      ClassificationModel.fromMap(json.decode(source));
}
