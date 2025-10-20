import 'package:dstp/models/staking_program.dart';
import 'package:dstp/services/coin_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddStakingProgramDialog extends StatefulWidget {
  const AddStakingProgramDialog({super.key});

  @override
  State<AddStakingProgramDialog> createState() => _AddStakingProgramDialogState();
}

class _AddStakingProgramDialogState extends State<AddStakingProgramDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _programName;
  double? _apy;
  String? _coinId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Staking Program'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Program Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a program name';
                }
                return null;
              },
              onSaved: (value) {
                _programName = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Coin ID (from CoinGecko)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a coin ID';
                }
                return null;
              },
              onSaved: (value) {
                _coinId = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'APY (%)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an APY';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (value) {
                _apy = double.tryParse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final imageUrl = await CoinService().getCoinImageUrl(_coinId!);
              final newProgram = StakingProgram(
                name: _programName!,
                apy: _apy!,
                id: DateTime.now().toString(),
                coinId: _coinId,
                imageUrl: imageUrl,
              );
              await Hive.box<StakingProgram>('staking_programs').add(newProgram);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}