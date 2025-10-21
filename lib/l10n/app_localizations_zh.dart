// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'DeFi Staking Toolbox Pro';

  @override
  String get dashboard => '仪表盘';

  @override
  String get portfolio => '投资组合';

  @override
  String get tools => '工具';

  @override
  String get settings => '设置';

  @override
  String get disclaimerTitle => '免责声明';

  @override
  String get disclaimerText =>
      'This app is for educational purposes only, not investment advice. Calculations and AI may have errors; verify independently.';

  @override
  String get agree => 'Agree';

  @override
  String get theme => '主题';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => '语言';

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
  String get disclaimerContent => '这是应用程序的测试版。所有功能仅用于实验和教育目的。请勿用于真实资产。';

  @override
  String get accept => '接受';

  @override
  String get decline => '拒绝';

  @override
  String get portfolioTrackerTitle => '投资组合追踪器';

  @override
  String get noStakingItems => '没有质押项目';

  @override
  String get addStakingItemsToGetStarted => '添加质押项目以开始';

  @override
  String get totalStaked => '总质押';

  @override
  String get totalRewards => '总奖励';

  @override
  String get avgApy => '平均APY';

  @override
  String get portfolioDistribution => '投资组合分布';

  @override
  String get stakingPositions => '质押头寸';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get staked => '已质押';

  @override
  String get startDate => '开始日期';

  @override
  String get apy => 'APY';

  @override
  String stakingItemDeleted(Object coin) {
    return '$coin的质押项目已删除';
  }

  @override
  String get confirmDeletion => '确认删除';

  @override
  String areYouSureYouWantToDelete(Object coin) {
    return '您确定要删除$coin的质押项目吗？';
  }

  @override
  String get cancel => '取消';

  @override
  String get addStaking => '添加质押';

  @override
  String get editStaking => '编辑质押';

  @override
  String get coin => '币种';

  @override
  String get validator => '验证者';

  @override
  String get balance => '余额';

  @override
  String get lockPeriod => '锁定期（天）';

  @override
  String get stakingAddress => '质押地址（可选）';

  @override
  String get estimatedApy => '预计APY（%）';

  @override
  String get save => '保存';

  @override
  String get fieldCannotBeEmpty => '字段不能为空';

  @override
  String get invalidNumber => '无效数字';

  @override
  String get invalidApy => '无效的APY';

  @override
  String get addStakingDetails => '添加新质押头寸的详细信息。';

  @override
  String get editStakingDetails => '编辑质押头寸的详细信息。';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get appTitle => 'DeFi 质押工具箱 Pro';

  @override
  String get dashboard => '仪表盘';

  @override
  String get portfolio => '投资组合';

  @override
  String get tools => '工具';

  @override
  String get settings => '设置';

  @override
  String get disclaimerTitle => '免责声明';

  @override
  String get theme => '主题';

  @override
  String get language => '语言';

  @override
  String get disclaimerContent => '这是应用程序的测试版。所有功能仅用于实验和教育目的。请勿用于真实资产。';

  @override
  String get accept => '接受';

  @override
  String get decline => '拒绝';

  @override
  String get portfolioTrackerTitle => '投资组合追踪器';

  @override
  String get noStakingItems => '没有质押项目';

  @override
  String get addStakingItemsToGetStarted => '添加质押项目以开始';

  @override
  String get totalStaked => '总质押';

  @override
  String get totalRewards => '总奖励';

  @override
  String get avgApy => '平均APY';

  @override
  String get portfolioDistribution => '投资组合分布';

  @override
  String get stakingPositions => '质押头寸';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get staked => '已质押';

  @override
  String get startDate => '开始日期';

  @override
  String get apy => 'APY';

  @override
  String stakingItemDeleted(Object coin) {
    return '$coin的质押项目已删除';
  }

  @override
  String get confirmDeletion => '确认删除';

  @override
  String areYouSureYouWantToDelete(Object coin) {
    return '您确定要删除$coin的质押项目吗？';
  }

  @override
  String get cancel => '取消';

  @override
  String get addStaking => '添加质押';

  @override
  String get editStaking => '编辑质押';

  @override
  String get coin => '币种';

  @override
  String get validator => '验证者';

  @override
  String get balance => '余额';

  @override
  String get lockPeriod => '锁定期（天）';

  @override
  String get stakingAddress => '质押地址（可选）';

  @override
  String get estimatedApy => '预计APY（%）';

  @override
  String get save => '保存';

  @override
  String get fieldCannotBeEmpty => '字段不能为空';

  @override
  String get invalidNumber => '无效数字';

  @override
  String get invalidApy => '无效的APY';

  @override
  String get addStakingDetails => '添加新质押头寸的详细信息。';

  @override
  String get editStakingDetails => '编辑质押头寸的详细信息。';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get appTitle => 'DeFi 質押工具箱 Pro';

  @override
  String get dashboard => '儀表板';

  @override
  String get portfolio => '投資組合';

  @override
  String get tools => '工具';

  @override
  String get settings => '設定';

  @override
  String get disclaimerTitle => '免責聲明';

  @override
  String get theme => '主題';

  @override
  String get language => '語言';

  @override
  String get disclaimerContent => '這是應用程式的測試版。所有功能僅用於實驗和教育目的。請勿用於真實資產。';

  @override
  String get accept => '接受';

  @override
  String get decline => '拒絕';

  @override
  String get portfolioTrackerTitle => '投資組合追蹤器';

  @override
  String get noStakingItems => '沒有質押項目';

  @override
  String get addStakingItemsToGetStarted => '新增質押項目以開始';

  @override
  String get totalStaked => '總質押';

  @override
  String get totalRewards => '總獎勵';

  @override
  String get avgApy => '平均 APY';

  @override
  String get portfolioDistribution => '投資組合分佈';

  @override
  String get stakingPositions => '質押頭寸';

  @override
  String get edit => '編輯';

  @override
  String get delete => '刪除';

  @override
  String get staked => '已質押';

  @override
  String get startDate => '開始日期';

  @override
  String get apy => 'APY';

  @override
  String stakingItemDeleted(Object coin) {
    return '$coin 的質押項目已刪除';
  }

  @override
  String get confirmDeletion => '確認刪除';

  @override
  String areYouSureYouWantToDelete(Object coin) {
    return '您確定要刪除 $coin 的質押項目嗎？';
  }

  @override
  String get cancel => '取消';

  @override
  String get addStaking => '新增質押';

  @override
  String get editStaking => '編輯質押';

  @override
  String get coin => '幣種';

  @override
  String get validator => '驗證者';

  @override
  String get balance => '餘額';

  @override
  String get lockPeriod => '鎖定期（天）';

  @override
  String get stakingAddress => '質押地址（可選）';

  @override
  String get estimatedApy => '預計 APY（%）';

  @override
  String get save => '儲存';

  @override
  String get fieldCannotBeEmpty => '欄位不能為空';

  @override
  String get invalidNumber => '無效數字';

  @override
  String get invalidApy => '無效的 APY';

  @override
  String get addStakingDetails => '新增新質押頭寸的詳細資訊。';

  @override
  String get editStakingDetails => '編輯質押頭寸的詳細資訊。';
}
