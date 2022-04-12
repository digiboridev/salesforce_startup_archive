abstract class UnitType {
  String get salesUnitString;
  String get text;

  factory UnitType.fromSalesUnit(String salesUnitString) {
    if (salesUnitString == 'EA') {
      return UnitUT();
    }
    if (salesUnitString == 'ZIN') {
      return InnerUT();
    }
    if (salesUnitString == 'KAR') {
      return CartonUT();
    }
    if (salesUnitString == 'PAL') {
      return PalletUT();
    }
    throw Exception('Unknown type');
  }

  factory UnitType.unit() {
    return UnitUT();
  }
  factory UnitType.inner() {
    return InnerUT();
  }
  factory UnitType.carton() {
    return CartonUT();
  }
  factory UnitType.pallet() {
    return PalletUT();
  }
}

class UnitUT implements UnitType {
  final String salesUnitString = 'EA';
  final String text = 'Unit';
}

class InnerUT implements UnitType {
  final String salesUnitString = 'ZIN';
  final String text = 'Inner';
}

class CartonUT implements UnitType {
  final String salesUnitString = 'KAR';
  final String text = 'Carton';
}

class PalletUT implements UnitType {
  final String salesUnitString = 'PAL';
  final String text = 'Palete';
}
