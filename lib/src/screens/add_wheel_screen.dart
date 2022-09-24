import 'package:flutter/material.dart';

import '../settings/settings_controller.dart';
import 'global_settings_screen.dart';

class AddWheelScreen extends StatefulWidget {
  const AddWheelScreen({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/add_wheel';

  final SettingsController controller;

  @override
  State<AddWheelScreen> createState() => _AddWheelScreenState();
}

class _AddWheelScreenState extends State<AddWheelScreen> {
  final _listKey = GlobalKey<AnimatedListState>();
  var _data = [0, 1, 2, 3, 4];

  void _insert() {
    final element = (_data.isEmpty ? 0 : _data.last) + 1;
    _data.add(element);
    final index = _data.length - 1;
    _listKey.currentState?.insertItem(index);
  }

  _removeAtIndex(int index) {
    final element = _data.removeAt(index);
    _listKey.currentState?.removeItem(index, (context, animation) {
      return SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        )),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.delete),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            labelText: 'Название варианта',
            filled: true,
            fillColor: Theme.of(context).primaryColorLight,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить колесо'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insert,
        child: const Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 10),
              child: TextField(
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
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _data.length,
                itemBuilder: ((context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(Tween<Offset>(
                      begin: const Offset(-1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (() => _removeAtIndex(index)),
                              icon: const Icon(Icons.delete)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          labelText: 'Название варианта',
                          filled: true,
                          fillColor: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
