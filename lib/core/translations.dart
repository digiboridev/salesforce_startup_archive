import 'package:get/get.dart';

class Trs extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'hello': 'Hello World',
        },
        'he': {
          'hello': 'Hallo 123',
        }
      };
}
