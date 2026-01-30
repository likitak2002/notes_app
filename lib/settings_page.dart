import 'package:database_wscube/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  // const SettingsPage({super.key});

  //   @override
  //   State<SettingsPage> createState() => _SettingsPageState();
  // }

  // class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      // body: SwitchListTile.adaptive(
      //   title: Text('Dark Mode'),
      //   subtitle: Text('Enable or disable dark mode'),
      //   onChanged: (value) {
      //     setState(() {
      //       isDarkMode = value;
      //     });
      //     // Handle switch change
      //   },
      //   value: isDarkMode,
      // ),
      body: Consumer<ThemeProvider>(
        builder: (_, provider, _) {
          return SwitchListTile(
            title: Text("Dark Mode"),
            subtitle: Text("Enable or disable dark mode"),
            onChanged: (value) {
              provider.updateTheme(value: value);
            },
            value: provider.getValue(),
          );
        },
      ),
    );
  }
}
