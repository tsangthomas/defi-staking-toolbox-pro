import 'package:flutter/material.dart';
import 'package:dstp/l10n/app_localizations.dart';

class ToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.tools ?? 'Tools'),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)?.toolsScreen ?? 'Tools Screen'),
      ),
    );
  }
}