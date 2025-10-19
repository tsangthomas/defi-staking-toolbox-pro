import 'package:flutter/material.dart';
import 'package:dstp/l10n/app_localizations.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.dashboard ?? 'Dashboard'),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)?.dashboardScreen ?? 'Dashboard Screen'),
      ),
    );
  }
}