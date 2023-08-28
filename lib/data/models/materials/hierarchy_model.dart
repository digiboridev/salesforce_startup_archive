import 'dart:convert';
import 'package:salesforce.startup/domain/entities/materials/hierarchy.dart';

class HierarchyModel extends Hierarchy {
  HierarchyModel({
    required String SFId,
    required String Display,
  }) : super(SFId: SFId, Display: Display);

  Map<String, dynamic> toMap() {
    return {
      'SFId': SFId,
      'Display': Display,
    };
  }

  factory HierarchyModel.fromMap(Map<String, dynamic> map) {
    return HierarchyModel(
      SFId: map['SFId'],
      Display: map['Display'],
    );
  }

  factory HierarchyModel.fromEntity(Hierarchy hierarchy) {
    return HierarchyModel(
      SFId: hierarchy.SFId,
      Display: hierarchy.Display,
    );
  }

  String toJson() => json.encode(toMap());

  factory HierarchyModel.fromJson(String source) => HierarchyModel.fromMap(json.decode(source));
}
