import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';

import 'package:dstp/data/coin_data.dart';
import 'package:dstp/models/staking_item.dart';
import 'package:dstp/providers/portfolio_provider.dart';

class AddStakingScreen extends StatefulWidget {
  final StakingItem? stakingItem;
  final int? index;

  const AddStakingScreen({Key? key, this.stakingItem, this.index}) : super(key: key);

  @override
  _AddStakingScreenState createState() => _AddStakingScreenState();
}

class _AddStakingScreenState extends State<AddStakingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _coinController = TextEditingController();
  final _validatorController = TextEditingController();
  final _balanceController = TextEditingController();
  final _lockPeriodController = TextEditingController();
  final _stakingAddressController = TextEditingController();
  final _estimatedApyController = TextEditingController();
  DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.stakingItem != null) {
      _coinController.text = widget.stakingItem!.coin;
      _validatorController.text = widget.stakingItem!.validator ?? '';
      _balanceController.text = widget.stakingItem!.balance.toString();
      _lockPeriodController.text = widget.stakingItem!.lockPeriodDays.toString();
      _stakingAddressController.text = widget.stakingItem!.stakingAddress ?? '';
      _estimatedApyController.text = widget.stakingItem!.estimatedAPY.toString();
      _startDate = widget.stakingItem!.startDate;
    } else {
      final initialCoin = CoinData.coins.first;
      _coinController.text = initialCoin['name']!;
    }
  }

  @override
  void dispose() {
    _coinController.dispose();
    _validatorController.dispose();
    _balanceController.dispose();
    _lockPeriodController.dispose();
    _stakingAddressController.dispose();
    _estimatedApyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stakingItem == null ? 'Add Staking' : 'Edit Staking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SearchField(
                controller: _coinController,
                suggestions: CoinData.coins
                    .map((coin) => SearchFieldListItem(
                          coin['name']!,
                          item: coin,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(coin['imageUrl']!, width: 24, height: 24),
                                const SizedBox(width: 10),
                                Text(coin['name']!),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                onSuggestionTap: (SearchFieldListItem<Map<String, String>> item) {
                  setState(() {
                    _coinController.text = item.item!['name']!;
                  });
                },
                suggestionState: Suggestion.expand,
                textInputAction: TextInputAction.next,
                hint: 'Select Coin',
                searchInputDecoration: SearchInputDecoration(
                  labelText: 'Coin',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a coin';
                  }
                  if (!CoinData.coins.any((coin) => coin['name'] == value)) {
                    return 'Please select a valid coin from the list';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _validatorController,
                decoration: const InputDecoration(labelText: 'Validator'),
              ),
              TextFormField(
                controller: _balanceController,
                decoration: const InputDecoration(labelText: 'Balance'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a balance';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lockPeriodController,
                decoration: const InputDecoration(labelText: 'Lock Period (Days)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a lock period';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              if (_coinController.text == 'ETH' || _coinController.text == 'SOL')
                TextFormField(
                  controller: _stakingAddressController,
                  decoration: const InputDecoration(labelText: 'Staking Address'),
                ),
              TextFormField(
                controller: _estimatedApyController,
                decoration: const InputDecoration(labelText: 'Estimated APY (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an estimated APY';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text('Start Date: ${DateFormat.yMd().format(_startDate)}'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null && pickedDate != _startDate) {
                        setState(() {
                          _startDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final selectedCoinName = _coinController.text;
                    final selectedCoinData = CoinData.coins.firstWhere((coin) => coin['name'] == selectedCoinName);
                    final newItem = StakingItem(
                      coin: selectedCoinName,
                      validator: _validatorController.text,
                      balance: double.parse(_balanceController.text),
                      lockPeriodDays: int.parse(_lockPeriodController.text),
                      startDate: _startDate,
                      stakingAddress: _stakingAddressController.text,
                      estimatedAPY: double.parse(_estimatedApyController.text),
                      imageUrl: selectedCoinData['imageUrl']!,
                    );

                    final provider = Provider.of<PortfolioProvider>(context, listen: false);
                    if (widget.stakingItem == null) {
                      provider.addStakingItem(newItem);
                    } else {
                      provider.updateStakingItem(widget.index!, newItem);
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}