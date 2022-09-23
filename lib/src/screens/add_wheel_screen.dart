import 'package:flutter/material.dart';

import '../settings/settings_controller.dart';
import 'global_settings_screen.dart';

class AddWheelScreen extends StatelessWidget {
  const AddWheelScreen({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/add_wheel';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить колесо'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  labelText: 'Название',
                  filled: true,
                  fillColor: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.restorablePushNamed(
                    context, GlobalSettingsWheel.routeName);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Theme.of(context).primaryColor),
                minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Text(
                'Настройки',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
