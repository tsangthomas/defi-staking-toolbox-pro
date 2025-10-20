import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dstp/providers/theme_provider.dart';
import 'package:dstp/providers/language_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dstp/l10n/app_localizations.dart';
import 'package:dstp/screens/main_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dstp/models/staking_program.dart';
import 'package:dstp/models/crypto_holding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(StakingProgramAdapter());
  Hive.registerAdapter(CryptoHoldingAdapter());
  await Hive.openBox<StakingProgram>('staking_programs');
  await Hive.openBox<CryptoHolding>('crypto_holdings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return MaterialApp(
                title: AppLocalizations.of(context)?.appTitle ?? 'DeFi Staking Toolbox Pro',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: Colors.blue,
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.blue,
                ),
                themeMode: themeProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
                locale: languageProvider.appLocale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                home: const MainScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
