import 'package:hive/hive.dart';

part 'staking_item.g.dart';

@HiveType(typeId: 2)
class StakingItem extends HiveObject {
  @HiveField(0)
  final String coin;

  @HiveField(1)
  final String? validator;

  @HiveField(2)
  final double balance;

  @HiveField(3)
  final int lockPeriodDays;

  @HiveField(4)
  final DateTime startDate;

  @HiveField(5)
  final String? stakingAddress;

  @HiveField(6)
  final double estimatedAPY;

  @HiveField(7)
  final String? imageUrl;

  StakingItem({
    required this.coin,
    this.validator,
    required this.balance,
    required this.lockPeriodDays,
    required this.startDate,
    this.stakingAddress,
    required this.estimatedAPY,
    this.imageUrl,
  });
}