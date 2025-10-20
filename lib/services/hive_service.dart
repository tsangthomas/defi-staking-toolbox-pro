import 'package:hive/hive.dart';
import 'package:dstp/models/staking_program.dart';
import 'package:dstp/models/crypto_holding.dart';

class HiveService {
  Box<StakingProgram> getStakingProgramsBox() {
    return Hive.box<StakingProgram>('staking_programs');
  }

  Box<CryptoHolding> getCryptoHoldingsBox() {
    return Hive.box<CryptoHolding>('crypto_holdings');
  }

  Future<void> addStakingProgram(StakingProgram program) async {
    final box = getStakingProgramsBox();
    await box.add(program);
  }

  Future<void> deleteStakingProgram(int index) async {
    final box = getStakingProgramsBox();
    await box.deleteAt(index);
  }

  Future<void> updateStakingProgram(int index, StakingProgram program) async {
    final box = getStakingProgramsBox();
    await box.putAt(index, program);
  }

  Future<void> addCryptoHolding(CryptoHolding holding) async {
    final box = getCryptoHoldingsBox();
    await box.add(holding);
  }

  Future<void> deleteCryptoHolding(int index) async {
    final box = getCryptoHoldingsBox();
    await box.deleteAt(index);
  }

  Future<void> updateCryptoHolding(int index, CryptoHolding holding) async {
    final box = getCryptoHoldingsBox();
    await box.putAt(index, holding);
  }
}