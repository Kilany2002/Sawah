import 'package:flutter/material.dart';
import 'package:sawah_app/generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  final ValueChanged<Locale> onLocaleChange;

  SettingsPage({required this.onLocaleChange});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'en'; // Default language

  void _changeLanguage(String? languageCode) {
    if (languageCode != null) {
      setState(() {
        _selectedLanguage = languageCode;
      });
    }
  }

  void _saveSettings() {
    Locale newLocale = Locale(_selectedLanguage);
    widget.onLocaleChange(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 76, 175),
        title: Text(
          S.of(context).settings,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).language,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedLanguage,
              items: [
                DropdownMenuItem(
                  child: Text('English'),
                  value: 'en',
                ),
                DropdownMenuItem(
                  child: Text('Arabic'),
                  value: 'ar',
                ),
              ],
              onChanged: _changeLanguage,
            ),
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text(S.of(context).save),
            ),
          ],
        ),
      ),
    );
  }
}
