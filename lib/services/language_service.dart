import 'dart:convert';
import 'package:flutter/services.dart';

class LanguageService {
  static Map<String, String> _localizedStrings = {};
  static String currentLanguage = "en";

  /// Load language JSON
  static Future<void> loadLanguage(String languageCode) async {
    try {
      currentLanguage = languageCode;

      final String jsonString =
      await rootBundle.loadString('assets/lang/$languageCode.json');

      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      /// fallback to English if error
      if (languageCode != "en") {
        await loadLanguage("en");
      }
    }
  }

  /// Translate text
  static String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  /// Short alias (easy to use in UI)
  static String t(String key) {
    return translate(key);
  }
}