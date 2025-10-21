import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dstp/models/staking_item.dart';

class PortfolioProvider with ChangeNotifier {
  late Box<StakingItem> _stakingItemsBox;

  List<StakingItem> _portfolio = [];
  List<StakingItem> get portfolio => _portfolio;

  PortfolioProvider() {
    _initHive();
  }

  Future<void> _initHive() async {
    _stakingItemsBox = await Hive.openBox<StakingItem>('stakingItems');
    _loadPortfolio();
  }

  void _loadPortfolio() {
    _portfolio = _stakingItemsBox.values.toList();
    notifyListeners();
  }

  Future<void> addStakingItem(StakingItem item) async {
    await _stakingItemsBox.add(item);
    _loadPortfolio();
  }

  Future<void> updateStakingItem(dynamic key, StakingItem item) async {
    await _stakingItemsBox.put(key, item);
    _loadPortfolio();
  }

  Future<void> deleteStakingItem(dynamic key) async {
    await _stakingItemsBox.delete(key);
    _loadPortfolio();
  }

  Map<String, double> getPortfolioSummary() {
    double totalStakedValue = _portfolio.fold(0.0, (sum, item) => sum + (item.balance * 1.0)); // Placeholder for price
    double totalEstimatedRewards = _portfolio.fold(0.0, (sum, item) => sum + (item.balance * item.estimatedAPY / 100));
    double averageApy = _portfolio.isEmpty ? 0.0 : _portfolio.fold(0.0, (sum, item) => sum + item.estimatedAPY) / _portfolio.length;

    return {
      'totalStakedValue': totalStakedValue,
      'totalEstimatedRewards': totalEstimatedRewards,
      'averageApy': averageApy,
    };
  }

  Map<String, double> getPortfolioDistribution() {
    if (_portfolio.isEmpty) {
      return {};
    }
    final Map<String, double> distribution = {};
    double totalValue = _portfolio.fold(0.0, (sum, item) => sum + (item.balance * 1.0)); // Placeholder price

    for (var item in _portfolio) {
      final value = item.balance * 1.0; // Placeholder price
      distribution.update(item.coin, (existing) => existing + value, ifAbsent: () => value);
    }

    if (totalValue == 0) {
        return distribution.map((key, value) => MapEntry(key, 0.0));
    }

    return distribution.map((key, value) => MapEntry(key, (value / totalValue) * 100));
  }
}