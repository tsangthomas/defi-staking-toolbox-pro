import 'package:hive/hive.dart';

part 'crypto_holding.g.dart';

@HiveType(typeId: 1)
class CryptoHolding extends HiveObject {
  @HiveField(0)
  final String coin;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double amount;

  CryptoHolding({
    required this.coin,
    required this.name,
    required this.amount,
  });
}