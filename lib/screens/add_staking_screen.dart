import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
  String _selectedCoin = 'ETH';
  final _validatorController = TextEditingController();
  final _balanceController = TextEditingController();
  final _lockPeriodController = TextEditingController();
  final _stakingAddressController = TextEditingController();
  final _estimatedApyController = TextEditingController();
  DateTime _startDate = DateTime.now();

  final List<String> _coins = ['ETH', 'SOL', 'ADA', 'DOT'];

  @override
  void initState() {
    super.initState();
    if (widget.stakingItem != null) {
      _selectedCoin = widget.stakingItem!.coin;
      _validatorController.text = widget.stakingItem!.validator ?? '';
      _balanceController.text = widget.stakingItem!.balance.toString();
      _lockPeriodController.text = widget.stakingItem!.lockPeriodDays.toString();
      _stakingAddressController.text = widget.stakingItem!.stakingAddress ?? '';
      _estimatedApyController.text = widget.stakingItem!.estimatedAPY.toString();
      _startDate = widget.stakingItem!.startDate;
    }
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
              DropdownButtonFormField<String>(
                value: _selectedCoin,
                items: _coins.map((String coin) {
                  return DropdownMenuItem<String>(
                    value: coin,
                    child: Text(coin),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCoin = newValue!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Coin'),
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
              if (_selectedCoin == 'ETH' || _selectedCoin == 'SOL')
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
                    final newItem = StakingItem(
                      coin: _selectedCoin,
                      validator: _validatorController.text,
                      balance: double.parse(_balanceController.text),
                      lockPeriodDays: int.parse(_lockPeriodController.text),
                      startDate: _startDate,
                      stakingAddress: _stakingAddressController.text,
                      estimatedAPY: double.parse(_estimatedApyController.text),
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