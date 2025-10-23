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
    final List<PieChartSectionData> sections = distribution.entries.map((
      entry,
    ) {
      final isTouched = false; // Placeholder for interactivity
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: _getCoinColor(entry.key),
        value: entry.value,
        title: '${entry.key}\n${entry.value.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    }).toList();

    return SizedBox(
      height: 250,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                localizations.portfolioDistribution,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        // Handle touch events for interactivity
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                    sections: sections,
                  ),
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

  Color _getCoinColor(String coin) {
    switch (coin) {
      case 'ETH':
        return Colors.indigo;
      case 'SOL':
        return Colors.purple;
      case 'ADA':
        return Colors.blue;
      case 'DOT':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }
}
