import 'package:equatable/equatable.dart';

abstract class Languages {
  Languages();

  String get languageString;
  String get identifier;

  factory Languages.fromIdentifier({required String identifier}) {
    if (identifier == 'en') {
      return English();
    } else if (identifier == 'he') {
      return Hebrew();
    } else {
      throw Exception('Unsupported language');
    }
  }

  factory Languages.english() => English();

  factory Languages.hebrew() => Hebrew();
}

class English extends Languages with EquatableMixin {
  final String languageString = 'English';
  final String identifier = 'en';

  @override
  List<Object> get props {
    return [
      languageString,
      identifier,
    ];
  }
}

class Hebrew extends Languages with EquatableMixin {
  final String languageString = 'Hebrew';
  final String identifier = 'he';

  @override
  List<Object> get props {
    return [
      languageString,
      identifier,
    ];
  }
}
