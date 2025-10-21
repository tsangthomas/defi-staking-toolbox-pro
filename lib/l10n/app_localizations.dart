import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'DeFi Staking Toolbox Pro'**
  String get appTitle;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @portfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolio;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @disclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerText.
  ///
  /// In en, this message translates to:
  /// **'This app is for educational purposes only, not investment advice. Calculations and AI may have errors; verify independently.'**
  String get disclaimerText;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @dashboardScreen.
  ///
  /// In en, this message translates to:
  /// **'Dashboard Screen'**
  String get dashboardScreen;

  /// No description provided for @chartsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Charts will be here'**
  String get chartsPlaceholder;

  /// No description provided for @stakingPrograms.
  ///
  /// In en, this message translates to:
  /// **'Staking Programs'**
  String get stakingPrograms;

  /// No description provided for @programListPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Staking program list will be here'**
  String get programListPlaceholder;

  /// No description provided for @addStakingProgram.
  ///
  /// In en, this message translates to:
  /// **'Add Staking Program'**
  String get addStakingProgram;

  /// No description provided for @toolsScreen.
  ///
  /// In en, this message translates to:
  /// **'Tools Screen'**
  String get toolsScreen;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @japanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japanese;

  /// No description provided for @korean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get korean;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @chineseSimplified.
  ///
  /// In en, this message translates to:
  /// **'Chinese (Simplified)'**
  String get chineseSimplified;

  /// No description provided for @chineseTraditional.
  ///
  /// In en, this message translates to:
  /// **'Chinese (Traditional)'**
  String get chineseTraditional;

  /// No description provided for @aiAnalysis.
  ///
  /// In en, this message translates to:
  /// **'AI Analysis'**
  String get aiAnalysis;

  /// No description provided for @disclaimerContent.
  ///
  /// In en, this message translates to:
  /// **'This is a beta version of the app. All features are for experimental and educational purposes only. Do not use with real assets.'**
  String get disclaimerContent;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @portfolioTrackerTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio Tracker'**
  String get portfolioTrackerTitle;

  /// No description provided for @noStakingItems.
  ///
  /// In en, this message translates to:
  /// **'No Staking Items'**
  String get noStakingItems;

  /// No description provided for @addStakingItemsToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Add staking items to get started'**
  String get addStakingItemsToGetStarted;

  /// No description provided for @totalStaked.
  ///
  /// In en, this message translates to:
  /// **'Total Staked'**
  String get totalStaked;

  /// No description provided for @totalRewards.
  ///
  /// In en, this message translates to:
  /// **'Total Rewards'**
  String get totalRewards;

  /// No description provided for @avgApy.
  ///
  /// In en, this message translates to:
  /// **'Average APY'**
  String get avgApy;

  /// No description provided for @portfolioDistribution.
  ///
  /// In en, this message translates to:
  /// **'Portfolio Distribution'**
  String get portfolioDistribution;

  /// No description provided for @stakingPositions.
  ///
  /// In en, this message translates to:
  /// **'Staking Positions'**
  String get stakingPositions;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @staked.
  ///
  /// In en, this message translates to:
  /// **'Staked'**
  String get staked;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @apy.
  ///
  /// In en, this message translates to:
  /// **'APY'**
  String get apy;

  /// No description provided for @stakingItemDeleted.
  ///
  /// In en, this message translates to:
  /// **'Staking item for {coin} deleted'**
  String stakingItemDeleted(Object coin);

  /// No description provided for @confirmDeletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirmDeletion;

  /// No description provided for @areYouSureYouWantToDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the staking item for {coin}?'**
  String areYouSureYouWantToDelete(Object coin);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @addStaking.
  ///
  /// In en, this message translates to:
  /// **'Add Staking'**
  String get addStaking;

  /// No description provided for @editStaking.
  ///
  /// In en, this message translates to:
  /// **'Edit Staking'**
  String get editStaking;

  /// No description provided for @coin.
  ///
  /// In en, this message translates to:
  /// **'Coin'**
  String get coin;

  /// No description provided for @validator.
  ///
  /// In en, this message translates to:
  /// **'Validator'**
  String get validator;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @lockPeriod.
  ///
  /// In en, this message translates to:
  /// **'Lock Period (days)'**
  String get lockPeriod;

  /// No description provided for @stakingAddress.
  ///
  /// In en, this message translates to:
  /// **'Staking Address (optional)'**
  String get stakingAddress;

  /// No description provided for @estimatedApy.
  ///
  /// In en, this message translates to:
  /// **'Estimated APY (%)'**
  String get estimatedApy;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @fieldCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Field cannot be empty'**
  String get fieldCannotBeEmpty;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @invalidApy.
  ///
  /// In en, this message translates to:
  /// **'Invalid APY'**
  String get invalidApy;

  /// No description provided for @addStakingDetails.
  ///
  /// In en, this message translates to:
  /// **'Add the details of your new staking position.'**
  String get addStakingDetails;

  /// No description provided for @editStakingDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit the details of your staking position.'**
  String get editStakingDetails;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ja', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
