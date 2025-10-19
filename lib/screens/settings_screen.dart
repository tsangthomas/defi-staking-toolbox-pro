import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dstp/providers/theme_provider.dart';
import 'package:dstp/providers/language_provider.dart';
import 'package:dstp/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.settings ?? 'Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.theme ?? 'Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)?.darkMode ?? 'Dark Mode'),
              value: themeProvider.darkTheme,
              onChanged: (value) {
                themeProvider.darkTheme = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)?.language ?? 'Language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<Locale>(
              value: languageProvider.appLocale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  languageProvider.changeLanguage(newLocale);
                }
              },
              items: AppLocalizations.supportedLocales.where((locale) => locale.languageCode != 'zh' || locale.countryCode != null).map((locale) {
                return DropdownMenuItem<Locale>(
                  value: locale,
                  child: Text(languageProvider.getLanguageName(context, locale.toString())),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}