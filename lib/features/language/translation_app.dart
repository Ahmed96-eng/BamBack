import 'package:get/get.dart';
import 'package:qattan/features/language/lang/ar_json.dart';
import 'package:qattan/features/language/lang/en_json.dart';

class TranslationApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": en,
        "ar": ar,
      };
}
