import 'package:hive/hive.dart';

part 'staking_program.g.dart';

@HiveType(typeId: 0)
class StakingProgram extends HiveObject {
  @HiveField(0)
  final String coin;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String validator;

  @HiveField(3)
  final int lockPeriod;

  @HiveField(4)
  final String lockPeriodUnit;

  StakingProgram({
    required this.coin,
    required this.amount,
    required this.validator,
    required this.lockPeriod,
    required this.lockPeriodUnit,
  });
}