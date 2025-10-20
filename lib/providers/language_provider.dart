import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dstp/l10n/app_localizations.dart';

class LanguageProvider with ChangeNotifier {
  static const LANGUAGE_CODE = "LANGUAGE_CODE";
  Locale _appLocale = Locale('en');

  Locale get appLocale => _appLocale;

  LanguageProvider() {
    _loadLocale();
  }

  void changeLanguage(Locale locale) async {
    if (_appLocale == locale) {
      return;
    }

    _appLocale = locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_CODE, locale.toString());
    notifyListeners();
  }

  String getLanguageName(BuildContext context, String localeCode) {
    final localizations = AppLocalizations.of(context)!;
    switch (localeCode) {
      case 'en':
        return localizations.english;
      case 'es':
        return localizations.spanish;
      case 'ja':
        return localizations.japanese;
      case 'ko':
        return localizations.korean;
      case 'zh':
        return localizations.chinese;
      case 'zh_CN':
        return localizations.chineseSimplified;
      case 'zh_TW':
        return localizations.chineseTraditional;
      default:
        // Handle cases like 'zh_Hant' if necessary
        if (localeCode.startsWith('zh')) {
          return localizations.chinese;
        }
        return 'Unknown';
    }
  }

  _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(LANGUAGE_CODE);

    if (languageCode == null) {
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final supportedLanguageCodes =
          AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet();

      if (supportedLanguageCodes.contains(deviceLocale.languageCode)) {
        if (deviceLocale.languageCode == 'zh') {
          // Handle Chinese script/region variations
          if (deviceLocale.scriptCode == 'Hant' ||
              deviceLocale.countryCode == 'TW') {
            languageCode = 'zh_TW';
          } else {
            languageCode = 'zh_CN';
          }
        } else {
          languageCode = deviceLocale.languageCode;
        }
      } else {
        languageCode = 'en'; // Default to English if device language not supported
      }
    }

    if (languageCode == 'zh') {
      languageCode = 'zh_CN'; // Default to Simplified Chinese
    }

    if (languageCode.contains('_')) {
      final parts = languageCode.split('_');
      _appLocale = Locale(parts[0], parts[1]);
    } else {
      _appLocale = Locale(languageCode);
    }
    notifyListeners();
  }
}