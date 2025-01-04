import 'package:get/get.dart';

class TranslationModel extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'us': {
          'hello': 'hello',
          'world': 'world',
          'how are you?': 'how are you?'
        },
        'kh': {
          'hello': 'សួរស្ដី',
          'world': 'ពិភពលោក',
          'how are you?': 'តើអ្នកសុខសប្បាយជាទេ?'
        },
        'cn': {'hello': '你好', 'world': '世界', 'how are you?': '你好吗？'},
        'fr': {
          'hello': 'bonjour',
          'world': 'le monde',
          'how are you?': 'comment ça va?'
        },
      };
}
