// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'DeFiステーキングツールボックスプロ';

  @override
  String get dashboard => 'ダッシュボード';

  @override
  String get portfolio => 'ポートフォリオ';

  @override
  String get tools => 'ツール';

  @override
  String get settings => '設定';

  @override
  String get disclaimerTitle => '免責事項';

  @override
  String get disclaimerText =>
      'This app is for educational purposes only, not investment advice. Calculations and AI may have errors; verify independently.';

  @override
  String get agree => 'Agree';

  @override
  String get theme => 'テーマ';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => '言語';

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
      'これはアプリのベータ版です。すべての機能は実験的および教育的な目的のみのものです。実際の資産では使用しないでください。';

  @override
  String get accept => '同意する';

  @override
  String get decline => '拒否する';

  @override
  String get portfolioTrackerTitle => 'ポートフォリオトラッカー';

  @override
  String get noStakingItems => 'ステーキングアイテムがありません';

  @override
  String get addStakingItemsToGetStarted => '開始するにはステーキングアイテムを追加してください';

  @override
  String get totalStaked => '合計ステーク額';

  @override
  String get totalRewards => '合計報酬';

  @override
  String get avgApy => '平均APY';

  @override
  String get portfolioDistribution => 'ポートフォリオ分布';

  @override
  String get stakingPositions => 'ステーキングポジション';

  @override
  String get edit => '編集';

  @override
  String get delete => '削除';

  @override
  String get staked => 'ステーク済み';

  @override
  String get startDate => '開始日';

  @override
  String get apy => 'APY';

  @override
  String stakingItemDeleted(Object coin) {
    return '$coinのステーキングアイテムが削除されました';
  }

  @override
  String get confirmDeletion => '削除の確認';

  @override
  String areYouSureYouWantToDelete(Object coin) {
    return '$coinのステーakingアイテムを本当に削除しますか？';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String get addStaking => 'ステーキングを追加';

  @override
  String get editStaking => 'ステーキングを編集';

  @override
  String get coin => 'コイン';

  @override
  String get validator => 'バリデーター';

  @override
  String get balance => '残高';

  @override
  String get lockPeriod => 'ロック期間（日）';

  @override
  String get stakingAddress => 'ステーキングアドレス（オプション）';

  @override
  String get estimatedApy => '推定APY（％）';

  @override
  String get save => '保存';

  @override
  String get fieldCannotBeEmpty => 'フィールドを空にすることはできません';

  @override
  String get invalidNumber => '無効な数値です';

  @override
  String get invalidApy => '無効なAPYです';

  @override
  String get addStakingDetails => '新しいステーキングポジションの詳細を追加してください。';

  @override
  String get editStakingDetails => 'ステーキングポジションの詳細を編集してください。';
}
