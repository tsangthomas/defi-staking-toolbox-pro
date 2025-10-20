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
            PopupMenuButton<Locale>(
              onSelected: (Locale newLocale) {
                languageProvider.changeLanguage(newLocale);
              },
              itemBuilder: (BuildContext context) {
                return AppLocalizations.supportedLocales
                    .where((locale) =>
                        locale.languageCode != 'zh' || locale.countryCode != null)
                    .map((locale) {
                  return PopupMenuItem<Locale>(
                    value: locale,
                    child: Text(
                        languageProvider.getLanguageName(context, locale.toString())),
                  );
                }).toList();
              },
              child: ListTile(
                title: Text(
                  languageProvider.getLanguageName(
                      context, languageProvider.appLocale.toString()),
                ),
                trailing: Icon(Icons.arrow_drop_down, color: Theme.of(context).hintColor),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}