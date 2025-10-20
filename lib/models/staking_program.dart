import 'package:hive/hive.dart';

part 'staking_program.g.dart';

@HiveType(typeId: 0)
class StakingProgram extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double apy;

  @HiveField(3)
  final String? coinId;

  @HiveField(4)
  final String? imageUrl;

  StakingProgram({
    required this.id,
    required this.name,
    required this.apy,
    this.coinId,
    this.imageUrl,
  });
}