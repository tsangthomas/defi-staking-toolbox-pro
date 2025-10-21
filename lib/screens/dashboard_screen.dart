<<<<<<< HEAD
import 'package:dstp/models/staking_program.dart';
import 'package:dstp/services/coin_service.dart';
import 'package:dstp/services/shared_preferences_service.dart';
import 'package:dstp/widgets/dialogs/add_staking_program_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isPaid = false;
  final _prefsService = SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    _loadPaidStatus();
  }

  Future<void> _loadPaidStatus() async {
    final isPaid = await _prefsService.isPaid();
    setState(() {
      _isPaid = isPaid;
    });
  }

  Future<void> _togglePaidStatus(bool value) async {
    await _prefsService.setPaid(value);
    setState(() {
      _isPaid = value;
    });
  }

=======
import 'package:flutter/material.dart';
import 'package:dstp/l10n/app_localizations.dart';

class DashboardScreen extends StatelessWidget {
>>>>>>> 967defac7509451801a88e58b2ad642d615e6ef1
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text(
          toBeginningOfSentenceCase(AppLocalizations.of(context)!.dashboard) ??
              'Dashboard',
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<StakingProgram>(
          'staking_programs',
        ).listenable(),
        builder: (context, Box<StakingProgram> box, _) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.blue,
                          value: 40,
                          title: '40%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.red,
                          value: 30,
                          title: '30%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.green,
                          value: 30,
                          title: '30%',
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 8,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 10,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 14,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 15,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 13,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 5,
                          barRods: [
                            BarChartRodData(
                              toY: 12,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              const style = TextStyle(
                                color: Color(0xff7589a2),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              );
                              Widget text;
                              switch (value.toInt()) {
                                case 0:
                                  text = const Text('Mn', style: style);
                                  break;
                                case 1:
                                  text = const Text('Te', style: style);
                                  break;
                                case 2:
                                  text = const Text('Wd', style: style);
                                  break;
                                case 3:
                                  text = const Text('Tu', style: style);
                                  break;
                                case 4:
                                  text = const Text('Fr', style: style);
                                  break;
                                case 5:
                                  text = const Text('St', style: style);
                                  break;
                                default:
                                  text = const Text('', style: style);
                                  break;
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 16.0,
                                child: text,
                              );
                            },
                            reservedSize: 42,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    toBeginningOfSentenceCase(
                          AppLocalizations.of(context)!.stakingPrograms,
                        ) ??
                        'Staking Programs',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SwitchListTile(
                  title: const Text('Is Paid'),
                  value: _isPaid,
                  onChanged: _togglePaidStatus,
                ),
              ),
              if (_isPaid)
                if (box.values.isEmpty)
                  SliverToBoxAdapter(
                    child: ListTile(
                      title: Text(
                        toBeginningOfSentenceCase(
                              AppLocalizations.of(
                                context,
                              )?.programListPlaceholder,
                            ) ??
                            'Staking program list will be here',
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final program = box.getAt(index)!;
                      return ListTile(
                        leading: program.imageUrl != null
                            ? Image.network(program.imageUrl!)
                            : const Icon(Icons.monetization_on),
                        title: Text(program.name),
                        subtitle: Text('APY: ${program.apy}%'),
                      );
                    }, childCount: box.values.length),
                  ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: null, // Disabled
                    child: Text(
                      toBeginningOfSentenceCase(
                            AppLocalizations.of(context)?.aiAnalysis,
                          ) ??
                          'AI Analysis',
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddStakingProgramDialog(),
          );
        },
        child: const Icon(Icons.add),
        tooltip:
            toBeginningOfSentenceCase(
              AppLocalizations.of(context)!.addStakingProgram,
            ) ??
            'Add Staking Program',
      ),
    );
  }
}
=======
        title: Text(AppLocalizations.of(context)?.dashboard ?? 'Dashboard'),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)?.dashboardScreen ?? 'Dashboard Screen'),
      ),
    );
  }
}
>>>>>>> 967defac7509451801a88e58b2ad642d615e6ef1
