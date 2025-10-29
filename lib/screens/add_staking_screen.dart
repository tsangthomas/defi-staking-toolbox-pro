import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:dstp/data/coin_data.dart';
import 'package:dstp/models/staking_item.dart';
import 'package:dstp/providers/portfolio_provider.dart';
import 'package:dstp/l10n/app_localizations.dart';

class AddStakingScreen extends StatefulWidget {
  final StakingItem? stakingItem;
  final int? index;

  const AddStakingScreen({super.key, this.stakingItem, this.index});

  @override
  _AddStakingScreenState createState() => _AddStakingScreenState();
}

class _AddStakingScreenState extends State<AddStakingScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _coinController = TextEditingController();
  final _walletController = TextEditingController();
  final _validatorController = TextEditingController();
  final _balanceController = TextEditingController(); // Initial Balance
  final _gasFeeController = TextEditingController();
  final _currentBalanceController = TextEditingController();
  final _lockPeriodController = TextEditingController();
  final _stakingAddressController = TextEditingController();
  final _initialEstimatedApyController = TextEditingController();
  late FocusNode _initialBalanceFocusNode;

  // Dates
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  // Status and flow
  String _status = 'Planning';
  bool _saved = false;

  // Tabs
  late TabController _tabController;

  // Analysis
  final double _currentPriceUsd = 0.50; // placeholder price
  bool _loadingPrice = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _initialBalanceFocusNode = FocusNode();
    _initialBalanceFocusNode.addListener(_onInitialBalanceFocusChange);

    // Pre-fill from existing item if provided
    if (widget.stakingItem != null) {
      _coinController.text = widget.stakingItem!.coin;
      _validatorController.text = widget.stakingItem!.validator ?? '';
      _balanceController.text = widget.stakingItem!.balance.toString();
      _lockPeriodController.text = widget.stakingItem!.lockPeriodDays.toString();
      _stakingAddressController.text = widget.stakingItem!.stakingAddress ?? '';
      _initialEstimatedApyController.text = widget.stakingItem!.estimatedAPY.toString();
      _startDate = widget.stakingItem!.startDate;
    } else {
      _coinController.clear();
    }

    // Analysis reacts to these fields
    _balanceController.addListener(_recomputeAnalysis);
    _currentBalanceController.addListener(_recomputeAnalysis);
    _gasFeeController.addListener(_recomputeAnalysis);

    _fetchMarketPrice();
  }

  @override
  void dispose() {
    _tabController.dispose();

    _coinController.dispose();
    _walletController.dispose();
    _validatorController.dispose();
    _balanceController.dispose();
    _gasFeeController.dispose();
    _currentBalanceController.dispose();
    _lockPeriodController.dispose();
    _stakingAddressController.dispose();
    _initialEstimatedApyController.dispose();
    _initialBalanceFocusNode.dispose();

    super.dispose();
  }

  Future<void> _fetchMarketPrice() async {
    setState(() => _loadingPrice = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _loadingPrice = false);
    // keep placeholder price at 0.50 as requested
  }

  void _recomputeAnalysis() {
    setState(() {});
  }

  void _onInitialBalanceFocusChange() {
    if (!_initialBalanceFocusNode.hasFocus) {
      if (_currentBalanceController.text.trim().isEmpty) {
        _currentBalanceController.text = _balanceController.text.trim();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.stakingItem != null ? localizations.editStaking : localizations.addStaking),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Material(
            color: theme.colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              tabs: [
                const Tab(text: 'Details'),
                Tab(text: localizations.aiAnalysis),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDetailsTab(context),
          _buildAnalysisTab(context),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildDetailsTab(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
     final coinNames = CoinData.coins.map((c) => c['name']!).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coin selector with images
                Autocomplete<String>(
                  initialValue: TextEditingValue(text: _coinController.text),
                  optionsBuilder: (TextEditingValue value) {
                    final query = value.text.toLowerCase();
                    return coinNames.where((name) =>
                        query.isEmpty || name.toLowerCase().contains(query));
                  },
                  displayStringForOption: (option) => option,
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    controller.text = _coinController.text;
                    controller.addListener(() {
                      _coinController.text = controller.text;
                      setState(() {});
                    });
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: localizations.coin,
                        hintText: 'e.g., ADA',
                        border: const OutlineInputBorder(),
                      ),
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                          return localizations.fieldCannotBeEmpty;
                         }
                         if (!coinNames.contains(value)) {
                          return localizations.fieldCannotBeEmpty;
                         }
                         return null;
                       },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (_) => setState(() {}),
                      textInputAction: TextInputAction.next,
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 240),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);
                              final coin = CoinData.coins.firstWhere((c) => c['name'] == option);
                              return ListTile(
                                leading: Image.network(coin['imageUrl']!, width: 24, height: 24),
                                title: Text(option),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: (selection) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _walletController,
                  decoration: const InputDecoration(
                    labelText: 'Wallet / Platform',
                    hintText: 'e.g., Ledger, Coinbase, Binance',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (_) => setState(() {}),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a wallet/platform';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _validatorController,
                  decoration: InputDecoration(
                    labelText: localizations.validator,
                    hintText: 'Enter validator name or address',
                    border: const OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (_) => setState(() {}),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return localizations.fieldCannotBeEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _balanceController,
                  focusNode: _initialBalanceFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Initial Balance',
                    hintText: 'e.g., 100.0',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.fieldCannotBeEmpty;
                    }
                    if (double.tryParse(value) == null) {
                      return localizations.invalidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _gasFeeController,
                  decoration: const InputDecoration(
                    labelText: 'Gas Fee',
                    hintText: 'e.g., 0.1',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _currentBalanceController,
                  decoration: const InputDecoration(
                    labelText: 'Current Balance',
                    hintText: 'e.g., 102.5',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.fieldCannotBeEmpty;
                    }
                    if (double.tryParse(value) == null) {
                      return localizations.invalidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _initialEstimatedApyController,
                  decoration: InputDecoration(
                    labelText: localizations.estimatedApy,
                    hintText: 'e.g., 7.5',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.fieldCannotBeEmpty;
                    }
                    if (double.tryParse(value) == null) {
                      return localizations.invalidApy;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _lockPeriodController,
                  decoration: InputDecoration(
                    labelText: localizations.lockPeriod,
                    hintText: 'e.g., 30',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                if (_coinController.text == 'ETH' || _coinController.text == 'SOL')
                  Column(
                    children: [
                      TextFormField(
                        controller: _stakingAddressController,
                        decoration: InputDecoration(
                          labelText: localizations.stakingAddress,
                            hintText: 'Enter staking address',
                            border: const OutlineInputBorder(),
                          ),
                      // Note: label is conditional and we keep English hint.
                       ),
                      const SizedBox(height: 16),
                    ],
                  ),

                // Dates
                Row(
                  children: [
                    Expanded(
                      child: Text('${AppLocalizations.of(context)!.startDate}: ${DateFormat.yMd().format(_startDate)}'),
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text('End Date: ${_endDate == null ? '-' : DateFormat.yMd().format(_endDate!)}'),
                    ),
                    TextButton(
                      onPressed: _status == 'Unstaking'
                          ? () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _endDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              );
                              if (pickedDate != null) {
                                setState(() => _endDate = pickedDate);
                              }
                            }
                          : null,
                      child: const Text('Select Date'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Read-only Status display
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color.alphaBlend(
                        (_status == 'Staking'
                            ? Colors.green
                            : _status == 'Unstaking'
                                ? Colors.orange
                                : Colors.blue).withOpacity(0.35),
                        Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  child: Semantics(
                    label: 'Status: $_status',
                    child: Row(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          child: Icon(
                            _status == 'Staking'
                                ? Icons.autorenew
                                : _status == 'Unstaking'
                                    ? Icons.hourglass_bottom
                                    : Icons.schedule_outlined,
                            key: ValueKey(_status),
                            size: 18,
                            color: _status == 'Staking'
                                ? Colors.green
                                : _status == 'Unstaking'
                                    ? Colors.orange
                                    : Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          child: Text(
                            'Status: $_status',
                            key: ValueKey('text_$_status'),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  letterSpacing: 0.2,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisTab(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
     final initialBalance = double.tryParse(_balanceController.text) ?? 0.0;
     final currentBalance = double.tryParse(_currentBalanceController.text) ?? 0.0;
     final gasFeeCoin = double.tryParse(_gasFeeController.text) ?? 0.0;

     final rewardCoin = currentBalance - initialBalance;
     final gasFeeUsd = gasFeeCoin * _currentPriceUsd;
     final actualRewardsUsd =
         (currentBalance * _currentPriceUsd) - (initialBalance * _currentPriceUsd) - gasFeeUsd;

     return SingleChildScrollView(
       padding: const EdgeInsets.all(16),
       child: Card(
         elevation: 2,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
         child: Padding(
           padding: const EdgeInsets.all(16),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                  const Text(
                    'Current Market Price (USD)',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  _loadingPrice
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text('\$${_currentPriceUsd.toStringAsFixed(2)}'),
                ],
              ),
              const Divider(height: 24),

              _analysisRow('Actual Rewards Earned (Coin)', rewardCoin.toStringAsFixed(6)),
               const SizedBox(height: 8),
              _analysisRow('Actual Rewards Earned (USD)', actualRewardsUsd.toStringAsFixed(2)),
               const SizedBox(height: 8),
              _analysisRow('Gas Fee (USD)', gasFeeUsd.toStringAsFixed(2)),
               const SizedBox(height: 8),
              _analysisRow('Validator Score', _validatorController.text.isEmpty ? 'N/A' : '80/100'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _analysisRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  BottomAppBar _buildBottomBar() {
    final cs = Theme.of(context).colorScheme;
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(60),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: Text(
                AppLocalizations.of(context)?.save ?? 'Save',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textAction(String label, Color bg, Color fg, VoidCallback onPressed) {
    return SizedBox(
      height: 56,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _iconAction(IconData icon, String tooltip, Color bg, Color fg, VoidCallback onPressed) {
    final cs = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        splashColor: cs.primary.withOpacity(0.10),
        highlightColor: cs.primary.withOpacity(0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: fg),
              const SizedBox(height: 2),
              Text(
                tooltip,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: cs.onSurface.withOpacity(0.85),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState?.validate() != true) return;

    final selectedCoinName = _coinController.text;
    final selectedCoinData = CoinData.coins.firstWhere((coin) => coin['name'] == selectedCoinName);
    final initialBalance = double.tryParse(_balanceController.text) ?? 0.0;
    final currentBalance = _currentBalanceController.text.trim().isEmpty
        ? initialBalance
        : (double.tryParse(_currentBalanceController.text) ?? initialBalance);

    final newItem = StakingItem(
      coin: selectedCoinName,
      validator: _validatorController.text,
      balance: currentBalance,
      lockPeriodDays: int.tryParse(_lockPeriodController.text) ?? 0,
      startDate: _startDate,
      stakingAddress: _stakingAddressController.text,
      estimatedAPY: double.tryParse(_initialEstimatedApyController.text) ?? 0.0,
      imageUrl: selectedCoinData['imageUrl']!,
    );

    final provider = Provider.of<PortfolioProvider>(context, listen: false);
    if (widget.stakingItem == null) {
      provider.addStakingItem(newItem);
    } else {
      provider.updateStakingItem(widget.index!, newItem);
    }

    setState(() {
      _saved = true;
      _status = 'Planning';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Staking saved (status: Planning)')),
    );
  }

  Future<void> _onStartStaking() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
        _status = 'Staking';
      });

      final provider = Provider.of<PortfolioProvider>(context, listen: false);
      if (widget.stakingItem != null && widget.index != null) {
        final selectedCoinName = _coinController.text;
        final selectedCoinData =
            CoinData.coins.firstWhere((coin) => coin['name'] == selectedCoinName);
        final initialBalance = double.tryParse(_balanceController.text) ?? 0.0;
        final currentBalance = _currentBalanceController.text.trim().isEmpty
            ? initialBalance
            : (double.tryParse(_currentBalanceController.text) ?? initialBalance);
        final updatedItem = StakingItem(
          coin: selectedCoinName,
          validator: _validatorController.text,
          balance: currentBalance,
          lockPeriodDays: int.tryParse(_lockPeriodController.text) ?? 0,
          startDate: _startDate,
          stakingAddress: _stakingAddressController.text,
          estimatedAPY: double.tryParse(_initialEstimatedApyController.text) ?? 0.0,
          imageUrl: selectedCoinData['imageUrl']!,
        );
        provider.updateStakingItem(widget.index!, updatedItem);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Staking started')),
      );
    }
  }

  void _onUnstaking() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        _endDate = pickedDate;
        _status = 'Unstaking';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unstaking initiated')),
      );
    }
  }

  void _onOtcAddCoin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTC action recorded')),
    );
  }

  void _onStakingEarn() {
    // Placeholder for navigating to staking earn
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Staking earn coming soon')),
    );
  }

  void _onDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(ctx)!.confirmDeletion),
        content: const Text('Are you sure you want to delete this staking entry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(AppLocalizations.of(ctx)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(AppLocalizations.of(ctx)!.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Optionally navigate back, or clear fields
      _coinController.clear();
      _walletController.clear();
      _validatorController.clear();
      _balanceController.clear();
      _gasFeeController.clear();
      _currentBalanceController.clear();
      _lockPeriodController.clear();
      _stakingAddressController.clear();
      _initialEstimatedApyController.clear();
      _startDate = DateTime.now();
      _endDate = null;

      setState(() {
        _saved = false;
        _status = 'Planning';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.stakingItemDeleted(_coinController.text.isEmpty ? 'Staking' : _coinController.text))),
      );

      // If editing existing, you may also remove from provider
      // (keeping current behavior: deletion is handled elsewhere in the list view)
    }
  }

  Future<void> _onAddToBalance() async {
    final addController = TextEditingController();
    final addAmount = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add to Balance'),
        content: TextField(
          controller: addController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Amount to add'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final v = double.tryParse(addController.text.trim());
              Navigator.of(ctx).pop(v);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (addAmount != null && addAmount > 0) {
      final current = double.tryParse(_currentBalanceController.text.trim()) ?? 0.0;
      final updated = current + addAmount;
      setState(() {
        _currentBalanceController.text = updated.toStringAsFixed(2);
      });

      // If editing an existing item, persist the update
      final provider = Provider.of<PortfolioProvider>(context, listen: false);
      if (widget.stakingItem != null && widget.index != null) {
        final selectedCoinName = _coinController.text;
        final selectedCoinData =
            CoinData.coins.firstWhere((coin) => coin['name'] == selectedCoinName);
        final updatedItem = StakingItem(
          coin: selectedCoinName,
          validator: _validatorController.text,
          balance: updated,
          lockPeriodDays: int.tryParse(_lockPeriodController.text) ?? 0,
          startDate: _startDate,
          stakingAddress: _stakingAddressController.text,
          estimatedAPY: double.tryParse(_initialEstimatedApyController.text) ?? 0.0,
          imageUrl: selectedCoinData['imageUrl']!,
        );
        provider.updateStakingItem(widget.index!, updatedItem);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${addAmount.toStringAsFixed(2)} to balance')),
      );
    }
  }
}