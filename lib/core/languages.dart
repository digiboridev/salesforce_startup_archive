abstract class Languages {
  Languages();

  String get languageString;
  String get identifier;

  factory Languages.fromIdentifier({required String identifier}) {
    if (identifier == 'en') {
      return Eanglish();
    } else if (identifier == 'he') {
      return Hebrew();
    } else {
      throw Exception('Unsupported language');
    }
  }

  factory Languages.english() => Eanglish();

  factory Languages.hebrew() => Hebrew();
}

class Eanglish extends Languages {
  final String languageString = 'Eanglish';
  final String identifier = 'en';
}

class Hebrew extends Languages {
  final String languageString = 'Hebrew';
  final String identifier = 'he';
}
