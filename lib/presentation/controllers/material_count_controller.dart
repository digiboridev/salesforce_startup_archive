import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/domain/entities/materials/unit_types.dart';
import 'package:get/get.dart';

class MaterialCountController extends GetxController {
  final Materiale material;

  MaterialCountController({
    required this.material,
  }) {
    _unit_count = RxInt(0);

    _unitType = Rx(material.avaliableUnitTtypes.first);
  }

  late final Rx<UnitType> _unitType;
  UnitType get unitType => _unitType.value;

  late RxInt _unit_count;
  Stream<int> get unit_countStream => _unit_count.stream;
  int get unit_count => _unit_count.value;

  void increaseCount() {
    _unit_count.value++;
  }

  void decreaseCount() {
    if (_unit_count.value < 1) {
      return;
    }
    _unit_count.value--;
  }

  void resetCount() {
    _unit_count.value = 0;
  }

  void setCountManual({required int count}) {
    _unit_count.value = count;
  }

  void setUnitType({required UnitType unitType}) {
    _unitType.value = unitType;
  }
}
