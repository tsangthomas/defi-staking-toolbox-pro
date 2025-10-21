// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DeFi Staking Toolbox Pro';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get portfolio => 'Portfolio';

  @override
  String get tools => 'Tools';

  @override
  String get settings => 'Settings';

  @override
  String get disclaimerTitle => 'Disclaimer';

  @override
  String get disclaimerText =>
      'This app is for educational purposes only, not investment advice. Calculations and AI may have errors; verify independently.';

  @override
  String get agree => 'Agree';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get dashboardScreen => 'Dashboard Screen';

  @override
  String get chartsPlaceholder => 'Charts will be here';

  @override
  String get stakingPrograms => 'Staking Programs';

  @override
  String get programListPlaceholder => 'Staking program list will be here';

  @override
  String get addStakingProgram => 'Add Staking Program';

  @override
  String get toolsScreen => 'Tools Screen';

  @override
  String get english => 'English';

  @override
  String get chinese => 'Chinese';

  @override
  String get japanese => 'Japanese';

  @override
  String get korean => 'Korean';

  @override
  String get spanish => 'Spanish';

  @override
  String get chineseSimplified => 'Chinese (Simplified)';

  @override
  String get chineseTraditional => 'Chinese (Traditional)';

  @override
  String get aiAnalysis => 'AI Analysis';

  @override
  String get disclaimerContent =>
      'This is a beta version of the app. All features are for experimental and educational purposes only. Do not use with real assets.';

  @override
  String get accept => 'Accept';

  @override
  String get decline => 'Decline';

  @override
  String get portfolioTrackerTitle => 'Portfolio Tracker';

  @override
  String get noStakingItems => 'No Staking Items';

  @override
  String get addStakingItemsToGetStarted => 'Add staking items to get started';

  @override
  String get totalStaked => 'Total Staked';

  @override
  String get totalRewards => 'Total Rewards';

  @override
  String get avgApy => 'Average APY';

  @override
  String get portfolioDistribution => 'Portfolio Distribution';

  @override
  String get stakingPositions => 'Staking Positions';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get staked => 'Staked';

  @override
  String get startDate => 'Start Date';

  @override
  String get apy => 'APY';

  @override
  String stakingItemDeleted(Object coin) {
    return 'Staking item for $coin deleted';
  }

  @override
  String get confirmDeletion => 'Confirm Deletion';

  @override
  String areYouSureYouWantToDelete(Object coin) {
    return 'Are you sure you want to delete the staking item for $coin?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get addStaking => 'Add Staking';

  @override
  String get editStaking => 'Edit Staking';

  @override
  String get coin => 'Coin';

  @override
  String get validator => 'Validator';

  @override
  String get balance => 'Balance';

  @override
  String get lockPeriod => 'Lock Period (days)';

  @override
  String get stakingAddress => 'Staking Address (optional)';

  @override
  String get estimatedApy => 'Estimated APY (%)';

  @override
  String get save => 'Save';

  @override
  String get fieldCannotBeEmpty => 'Field cannot be empty';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String get invalidApy => 'Invalid APY';

  @override
  String get addStakingDetails =>
      'Add the details of your new staking position.';

  @override
  String get editStakingDetails => 'Edit the details of your staking position.';
}
