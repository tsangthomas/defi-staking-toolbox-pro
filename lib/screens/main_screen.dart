import 'package:dstp/widgets/disclaimer_modal.dart';
import 'package:flutter/material.dart';
import 'package:dstp/screens/dashboard_screen.dart';
import 'package:dstp/screens/tools_screen.dart';
import 'package:dstp/screens/settings_screen.dart';
import 'package:dstp/l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    DashboardScreen(),
    ToolsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisclaimerModal(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: AppLocalizations.of(context)?.dashboard ?? 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: AppLocalizations.of(context)?.tools ?? 'Tools',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context)?.settings ?? 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}