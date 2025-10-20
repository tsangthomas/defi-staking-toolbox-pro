import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dstp/l10n/app_localizations.dart';

class DisclaimerModal extends StatefulWidget {
  final Widget child;

  const DisclaimerModal({required this.child});

  @override
  _DisclaimerModalState createState() => _DisclaimerModalState();
}

class _DisclaimerModalState extends State<DisclaimerModal> {
  static const String _hasAgreedToDisclaimer = 'hasAgreedToDisclaimer';

  @override
  void initState() {
    super.initState();
    _checkDisclaimer();
  }

  Future<void> _checkDisclaimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasAgreed = prefs.getBool(_hasAgreedToDisclaimer) ?? false;

    if (!hasAgreed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)?.disclaimerTitle ?? 'Disclaimer'),
              content: Text(AppLocalizations.of(context)?.disclaimerText ?? 'This app is for educational purposes only, not investment advice. Calculations and AI may have errors; verify independently.'),
              actions: <Widget>[
                TextButton(
                  child: Text(AppLocalizations.of(context)?.agree ?? 'Agree'),
                  onPressed: () async {
                    await prefs.setBool(_hasAgreedToDisclaimer, true);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}