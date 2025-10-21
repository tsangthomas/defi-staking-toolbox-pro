// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'DeFi 스테이킹 툴박스 프로';

  @override
  String get dashboard => '대시보드';

  @override
  String get portfolio => '포트폴리오';

  @override
  String get tools => '도구';

  @override
  String get settings => '설정';

  @override
  String get disclaimerTitle => '면책 조항';

  @override
  String get disclaimerText =>
      'This app is for educational purposes only, not investment advice. Calculations and AI may have errors; verify independently.';

  @override
  String get agree => 'Agree';

  @override
  String get theme => '테마';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => '언어';

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
      '이것은 앱의 베타 버전입니다. 모든 기능은 실험 및 교육 목적으로만 사용됩니다. 실제 자산에는 사용하지 마십시오.';

  @override
  String get accept => '동의';

  @override
  String get decline => '거부';

  @override
  String get portfolioTrackerTitle => '포트폴리오 트래커';

  @override
  String get noStakingItems => '스테이킹 항목 없음';

  @override
  String get addStakingItemsToGetStarted => '시작하려면 스테이킹 항목을 추가하세요';

  @override
  String get totalStaked => '총 스테이킹';

  @override
  String get totalRewards => '총 보상';

  @override
  String get avgApy => '평균 APY';

  @override
  String get portfolioDistribution => '포트폴리오 분포';

  @override
  String get stakingPositions => '스테이킹 포지션';

  @override
  String get edit => '편집';

  @override
  String get delete => '삭제';

  @override
  String get staked => '스테이킹됨';

  @override
  String get startDate => '시작일';

  @override
  String get apy => 'APY';

  @override
  String stakingItemDeleted(Object coin) {
    return '$coin에 대한 스테이킹 항목이 삭제되었습니다';
  }

  @override
  String get confirmDeletion => '삭제 확인';

  @override
  String areYouSureYouWantToDelete(Object coin) {
    return '$coin에 대한 스테이킹 항목을 삭제하시겠습니까?';
  }

  @override
  String get cancel => '취소';

  @override
  String get addStaking => '스테이킹 추가';

  @override
  String get editStaking => '스테이킹 편집';

  @override
  String get coin => '코인';

  @override
  String get validator => '검증자';

  @override
  String get balance => '잔액';

  @override
  String get lockPeriod => '잠금 기간 (일)';

  @override
  String get stakingAddress => '스테이킹 주소 (선택 사항)';

  @override
  String get estimatedApy => '예상 APY (%)';

  @override
  String get save => '저장';

  @override
  String get fieldCannotBeEmpty => '필드를 비워둘 수 없습니다';

  @override
  String get invalidNumber => '유효하지 않은 숫자';

  @override
  String get invalidApy => '유효하지 않은 APY';

  @override
  String get addStakingDetails => '새 스테이킹 포지션의 세부 정보를 추가하세요.';

  @override
  String get editStakingDetails => '스테이킹 포지션의 세부 정보를 편집하세요.';
}
