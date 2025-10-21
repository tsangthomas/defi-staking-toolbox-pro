import 'package:flutter/material.dart';
import 'package:dstp/l10n/app_localizations.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.tools ?? 'Tools', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)?.toolsScreen ?? 'Tools Screen'),
      ),
    );
  }
}