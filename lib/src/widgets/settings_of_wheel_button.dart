import 'package:flutter/material.dart';

import '../screens/settings_of_wheel.dart';

class SettingsOfWheelButton extends StatefulWidget {
  SettingsOfWheelButton({Key? key}) : super(key: key);

  @override
  State<SettingsOfWheelButton> createState() => _SettingsOfWheelButtonState();
}

class _SettingsOfWheelButtonState extends State<SettingsOfWheelButton> {
  bool _value = true;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 300),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 600,
                margin: const EdgeInsets.only(bottom: 50, left: 50, right: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Dialog(
                  insetPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  elevation: 0,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            splashColor: Colors.white.withAlpha(30),
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 5),
                              child: Row(
                                children: [
                                  const Text('Режим на выбывание'),
                                  const Spacer(),
                                  Switch.adaptive(
                                      value: _value,
                                      onChanged: (newValue) {
                                        _value = newValue;
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            splashColor: Colors.white.withAlpha(30),
                            onTap: () {
                              Navigator.restorablePushNamed(
                                  context, SettingsOfWheelGlobal.routeName);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 5),
                              child: Row(
                                children: const [
                                  Text('Редактировать колесо'),
                                  Spacer(),
                                  Icon(Icons.keyboard_arrow_right)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position:
                  Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                      .animate(anim1),
              child: child,
            );
          },
        );
      },
      icon: const Icon(Icons.menu_sharp),
    );
  }
}
