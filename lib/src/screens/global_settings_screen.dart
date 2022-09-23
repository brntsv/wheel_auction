import 'package:flutter/material.dart';

class GlobalSettingsWheel extends StatefulWidget {
  GlobalSettingsWheel({Key? key}) : super(key: key);

  static const routeName = '/add_wheel/settings';

  @override
  State<GlobalSettingsWheel> createState() => _GlobalSettingsWheelState();
}

class _GlobalSettingsWheelState extends State<GlobalSettingsWheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки колеса'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
