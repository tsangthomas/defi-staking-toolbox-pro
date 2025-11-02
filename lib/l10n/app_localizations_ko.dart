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
      '이 앱은 교육 목적으로만 제공되며 투자 조언이 아닙니다. 계산 및 AI에 오류가 있을 수 있습니다. 반드시 독립적으로 확인하세요.';

  @override
  String get agree => '동의합니다';

  @override
  String get theme => '테마';

  @override
  String get darkMode => '다크 모드';

  @override
  String get language => '언어';

  @override
  String get dashboardScreen => '대시보드 화면';

  @override
  String get chartsPlaceholder => '여기에 차트가 표시됩니다';

  @override
  String get stakingPrograms => '스테이킹 프로그램';

  @override
  String get programListPlaceholder => '스테이킹 프로그램 목록이 여기에 표시됩니다';

  @override
  String get addStakingProgram => '스테이킹 프로그램 추가';

  @override
  String get toolsScreen => '도구 화면';

  @override
  String get english => '영어';

  @override
  String get chinese => '중국어';

  @override
  String get japanese => '일본어';

  @override
  String get korean => '한국어';

  @override
  String get spanish => '스페인어';

  @override
  String get chineseSimplified => '중국어(간체)';

  @override
  String get chineseTraditional => '중국어(번체)';

  @override
  String get aiAnalysis => 'AI 분석';

  @override
  String get disclaimerContent =>
      '이 앱은 베타 버전입니다. 모든 기능은 실험적이며 교육 목적만을 위한 것입니다. 실제 자산에 사용하지 마십시오.';

  @override
  String get accept => '동의';

  @override
  String get decline => '거절';

  @override
  String get portfolioTrackerTitle => '포트폴리오 추적기';

  @override
  String get noStakingItems => '스테이킹 항목이 없습니다';

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
  String get startDate => '시작 날짜';

  @override
  String get apy => 'APY';

  @override
  String stakingItemDeleted(Object coin) {
    return '$coin의 스테이킹 항목이 삭제되었습니다';
  }

  @override
  String get confirmDeletion => '삭제 확인';

  @override
  String areYouSureYouWantToDelete(Object coin) {
    return '$coin의 스테이킹 항목을 정말 삭제하시겠습니까?';
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
  String get lockPeriod => '잠금 기간(일)';

  @override
  String get stakingAddress => '스테이킹 주소(선택)';

  @override
  String get estimatedApy => '예상 APY(%)';

  @override
  String get save => '저장';

  @override
  String get fieldCannotBeEmpty => '필드를 비워둘 수 없습니다';

  @override
  String get invalidNumber => '잘못된 숫자입니다';

  @override
  String get invalidApy => '잘못된 APY입니다';

  @override
  String get addStakingDetails => '새 스테이킹 포지션의 세부 정보를 추가하세요.';

  @override
  String get editStakingDetails => '새 스테이킹 포지션의 세부 정보를 편집합니다.';

  @override
  String get status => '상태';

  @override
  String get endDate => '종료 날짜';

  @override
  String get selectDate => '날짜 선택';

  @override
  String get details => '세부 정보';

  @override
  String get initialBalance => '초기 잔액';

  @override
  String get currentBalance => '현재 잔액';

  @override
  String get gasFee => '가스 수수료';

  @override
  String get walletPlatform => '지갑 / 플랫폼';

  @override
  String get startStaking => '스테이킹 시작';

  @override
  String get unstake => '언스테이킹';

  @override
  String get addToBalance => '잔액에 추가';
}
