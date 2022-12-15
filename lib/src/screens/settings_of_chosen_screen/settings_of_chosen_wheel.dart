import 'package:flutter/material.dart';
import 'package:wheel_auction/src/theme/app_text_style.dart';

class SettingsOfChosenWheel extends StatefulWidget {
  const SettingsOfChosenWheel({Key? key}) : super(key: key);

  static const routeName = '/chosen_wheel';

  @override
  State<SettingsOfChosenWheel> createState() => _SettingsOfChosenWheelState();
}

class _SettingsOfChosenWheelState extends State<SettingsOfChosenWheel> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование'),
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
              child: TextFormField(
                style: AppTextStyle.hintInputText,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  hintText: 'Название',
                  hintStyle: AppTextStyle.hintInputText,
                  filled: true,
                  fillColor: theme.primaryColorLight,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.restorablePushNamed(
                //     context, GlobalSettingsWheel.routeName);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(theme.primaryColor),
                minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Text(
                'Настройки',
                style: theme.textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
