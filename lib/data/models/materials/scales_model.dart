import 'dart:convert';
import 'package:salesforce.startup/domain/entities/materials/scales.dart';

class ScalesModel extends Scales {
  ScalesModel({
    required String Unit,
    required num ScaleQuantityFrom,
    required num Rate,
  }) : super(
          Unit: Unit,
          ScaleQuantityFrom: ScaleQuantityFrom,
          Rate: Rate,
        );

  Map<String, dynamic> toMap() {
    return {
      'Unit': Unit,
      'ScaleQuantityFrom': ScaleQuantityFrom,
      'Rate': Rate,
    };
  }

  factory ScalesModel.fromMap(Map<String, dynamic> map) {
    return ScalesModel(
      Unit: map['Unit'] ?? '',
      ScaleQuantityFrom: map['ScaleQuantityFrom'] ?? 0,
      Rate: map['Rate'] ?? 0,
    );
  }

  factory ScalesModel.fromEntity(Scales scales) {
    return ScalesModel(
      Unit: scales.Unit,
      ScaleQuantityFrom: scales.ScaleQuantityFrom,
      Rate: scales.Rate,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScalesModel.fromJson(String source) => ScalesModel.fromMap(json.decode(source));
}
