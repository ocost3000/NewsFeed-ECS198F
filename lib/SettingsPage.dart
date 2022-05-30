import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'UpdateNotifier.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SettingsPage();

}

class _SettingsPage extends State<SettingsPage>{
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateNotifier>(
      builder: (context, themeData, child) {
        return Scaffold(
          body: SettingsList(
            sections: [
              SettingsSection(
                title: Text('Colors'),
                tiles: [
                  SettingsTile(
                    leading: Icon(Icons.color_lens),
                    title: Text('Amber'),
                    onPressed: (BuildContext context) {
                      themeData.setTheme(FlexScheme.amber);
                    },
                  ),
                  SettingsTile(
                    leading: Icon(Icons.color_lens),
                    title: Text('Aquablue'),
                    onPressed: (BuildContext context) {
                      themeData.setTheme(FlexScheme.aquaBlue);
                    },
                  ),

                ],
              ),
            ],
          ),
        );
      }
    );
  }

}



