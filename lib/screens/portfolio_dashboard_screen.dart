import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:dstp/providers/portfolio_provider.dart';
import 'package:dstp/models/staking_item.dart';
import 'package:dstp/screens/add_staking_screen.dart';
import 'package:dstp/l10n/app_localizations.dart';

class PortfolioDashboardScreen extends StatefulWidget {
  const PortfolioDashboardScreen({super.key});

  @override
  State<PortfolioDashboardScreen> createState() =>
      _PortfolioDashboardScreenState();
}

class _PortfolioDashboardScreenState extends State<PortfolioDashboardScreen> {
  late Offset _fabPosition;
  bool _fabInitialized = false;

  // Distinct coin colors
  final Map<String, Color> _coinColorMap = {};
  final List<Color> _coinPalette = const [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    Colors.amber,
    Colors.teal,
    Colors.lime,
    Colors.pink,
    Colors.indigo,
    Colors.brown,
  ];

  @override
  void initState() {
    super.initState();
    _fabPosition = const Offset(16, 16); // placeholder until layout known
    // Removed post-frame repositioning; we will compute initial bottom-left in build using constraints
  }

  @override
  Widget build(BuildContext context) {
    final portfolioProvider = Provider.of<PortfolioProvider>(context);
    final portfolio = portfolioProvider.portfolio;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          toBeginningOfSentenceCase(localizations.portfolio) ?? 'Portfolio',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              if (portfolio.isEmpty)
                _buildEmptyPortfolioView(localizations)
              else
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildSummary(
                          context,
                          portfolioProvider,
                          localizations,
                        ),
                        const SizedBox(height: 24),
                        _buildPortfolioChart(
                          context,
                          portfolioProvider,
                          localizations,
                        ),
                        const SizedBox(height: 24),
                        _buildStakingList(
                          context,
                          portfolioProvider,
                          localizations,
                        ),
                      ],
                    ),
                  ),
                ),
              _buildDraggableFab(context, localizations, constraints),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyPortfolioView(AppLocalizations localizations) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.trending_down, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            localizations.noStakingItems,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            localizations.addStakingItemsToGetStarted,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableFab(
    BuildContext context,
    AppLocalizations localizations,
    BoxConstraints constraints,
  ) {
    final fabSize = 56.0;
    final screenWidth = constraints.maxWidth;
    final screenHeight = constraints.maxHeight;
    const margin = 16.0;

    // Initial position: bottom-right within the visible body area
    final left = _fabInitialized
        ? _fabPosition.dx
        : (screenWidth - fabSize - margin)
            .clamp(0.0, screenWidth - fabSize);
    final top = _fabInitialized
        ? _fabPosition.dy
        : (screenHeight - fabSize - margin)
            .clamp(0.0, screenHeight - fabSize);

    return Positioned(
      left: left,
      top: top,
      child: LongPressDraggable(
        feedback: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          // Convert global pointer offset to local Stack coordinates
          final renderBox = context.findRenderObject() as RenderBox?;
          final localOffset = renderBox != null
              ? renderBox.globalToLocal(details.offset)
              : details.offset;

          setState(() {
            final newDx = localOffset.dx.clamp(0.0, screenWidth - fabSize);
            final newDy = localOffset.dy.clamp(0.0, screenHeight - fabSize);
            _fabPosition = Offset(newDx, newDy);
            _fabInitialized = true;
          });
        },
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const AddStakingScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSummary(
    BuildContext context,
    PortfolioProvider provider,
    AppLocalizations localizations,
  ) {
    final summary = provider.getPortfolioSummary();
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem(
              context,
              localizations.totalStaked,
              currencyFormat.format(summary['totalStakedValue'] ?? 0),
            ),
            _buildSummaryItem(
              context,
              localizations.totalRewards,
              currencyFormat.format(summary['totalEstimatedRewards'] ?? 0),
            ),
            _buildSummaryItem(
              context,
              localizations.avgApy,
              '${(summary['averageApy'] ?? 0).toStringAsFixed(2)}%',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String title,
    String value, {
    bool isLast = false,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: !isLast
                ? BorderSide(color: Colors.grey.withOpacity(0.5))
                : BorderSide.none,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioChart(
    BuildContext context,
    PortfolioProvider provider,
    AppLocalizations localizations,
  ) {
    final distribution = provider.getPortfolioDistribution();

    // Compute absolute totals per coin for legend display
    final Map<String, double> totals = {};
    for (final item in provider.portfolio) {
      totals.update(item.coin, (prev) => prev + item.balance, ifAbsent: () => item.balance);
    }

    final List<PieChartSectionData> sections = distribution.entries.map((entry) {
      return PieChartSectionData(
        color: _getCoinColor(entry.key),
        value: entry.value,
        title: '${entry.key} (${entry.value.toStringAsFixed(1)}%)',
        radius: 50.0,
        titleStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return SizedBox(
      height: 300,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.portfolioDistribution,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                          ),
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 2,
                          centerSpaceRadius: 60,
                          sections: sections,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _buildLegendRight(totals, distribution),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStakingList(
    BuildContext context,
    PortfolioProvider provider,
    AppLocalizations localizations,
  ) {
    final portfolio = provider.portfolio;
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.stakingPositions,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: portfolio.length,
          itemBuilder: (ctx, index) {
            final item = portfolio[index];
            return Slidable(
              key: ValueKey(item.key),
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>
                              AddStakingScreen(stakingItem: item, index: index),
                        ),
                      );
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: localizations.edit,
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {
                    provider.deleteStakingItem(item.key);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          localizations.stakingItemDeleted(item.coin),
                        ),
                      ),
                    );
                  },
                ),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      _confirmDelete(context, provider, item, localizations);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: localizations.delete,
                  ),
                ],
              ),
              child: _buildStakingItemCard(
                context,
                item,
                dateFormat,
                localizations,
              ),
            );
          },
        ),
      ],
    );
  }

  void _confirmDelete(
    BuildContext context,
    PortfolioProvider provider,
    StakingItem item,
    AppLocalizations localizations,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(localizations.confirmDeletion),
        content: Text(localizations.areYouSureYouWantToDelete(item.coin)),
        actions: [
          TextButton(
            child: Text(localizations.cancel),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text(localizations.delete),
            onPressed: () {
              provider.deleteStakingItem(item.key);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(localizations.stakingItemDeleted(item.coin)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStakingItemCard(
    BuildContext context,
    StakingItem item,
    DateFormat dateFormat,
    AppLocalizations localizations,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                        ? Image.network(item.imageUrl!, width: 40, height: 40)
                        : CircleAvatar(
                            radius: 20,
                            child: Text(
                              item.coin.isNotEmpty ? item.coin[0] : '',
                            ),
                          ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.coin,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (item.validator != null &&
                            item.validator!.isNotEmpty)
                          Text(
                            item.validator!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      NumberFormat.decimalPattern().format(item.balance),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '~${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(item.balance * 1.0)} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ), // Placeholder for price
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn(
                  context,
                  localizations.staked,
                  dateFormat.format(item.startDate),
                ),
                _buildInfoColumn(
                  context,
                  localizations.apy,
                  '${item.estimatedAPY.toStringAsFixed(2)}%',
                ),
                _buildInfoColumn(
                  context,
                  localizations.lockPeriod,
                  '${item.lockPeriodDays} days',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildLegendRight(
    Map<String, double> totals,
    Map<String, double> distribution,
  ) {
    final numberFormatter = NumberFormat.decimalPattern();
    return Align(
      alignment: Alignment.centerLeft,
      child: ListView(
        children: distribution.entries.map((e) {
          final amount = totals[e.key] ?? 0.0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _getCoinColor(e.key),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text('${e.key} (${numberFormatter.format(amount)})'),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getCoinColor(String coin) {
    if (_coinColorMap.containsKey(coin)) return _coinColorMap[coin]!;
    final nextIndex = _coinColorMap.length % _coinPalette.length;
    final color = _coinPalette[nextIndex];
    _coinColorMap[coin] = color;
    return color;
  }
}
