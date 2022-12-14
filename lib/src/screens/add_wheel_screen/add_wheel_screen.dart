import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/global_settings_screen/global_settings_screen.dart';
import 'package:wheel_auction/src/screens/main_screen/model/list_of_wheels_model.dart';

class AddWheelScreen extends StatefulWidget {
  const AddWheelScreen({Key? key}) : super(key: key);

  static const routeName = '/add_wheel';

  @override
  State<AddWheelScreen> createState() => _AddWheelScreenState();
}

class _AddWheelScreenState extends State<AddWheelScreen> {
  /// кей для названий колес
  final _formKey = GlobalKey<FormState>();

  /// кей для анимированного листа(//? заполненных полей)
  final _listKey = GlobalKey<AnimatedListState>();

  final _data = <dynamic>[];

  /// контроллер text field для названий колес
  final TextEditingController controllerTextFieldNameWheel =
      TextEditingController();

  /// контроллер text field для вариантов колес
  final List<TextEditingController> controllerTextFieldEventsWheel = [];

  /// инициализация листа для фокус нод
  final List<FocusNode> _focusNodes = [];

  /// контроллер скролла
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    controllerTextFieldNameWheel.addListener(_printTitleValue);

    for (final TextEditingController event in controllerTextFieldEventsWheel) {
      event.addListener(_printOptionsValue);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _insert();
    });
  }

  // TODO Функции для тестирования состояния текс филдов
  void _printTitleValue() {
    print('название: ${controllerTextFieldNameWheel.text}');
  }

  void _printOptionsValue() {
    print('варианты: ${controllerTextFieldEventsWheel.map((e) => e.text)}');
  }

  @override
  void dispose() {
    controllerTextFieldNameWheel.dispose();

    for (final TextEditingController event in controllerTextFieldEventsWheel) {
      event.dispose();
    }

    for (final FocusNode node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _insert() {
    final event = TextEditingController();
    final focusNode = FocusNode();
    dynamic element = (_data.isEmpty ? 0 : _data.last) + 1;

    _data.add(element);
    controllerTextFieldEventsWheel.add(event);
    _focusNodes.add(focusNode);

    final index = _data.length - 1;
    _listKey.currentState?.insertItem(
      index,
      duration: const Duration(milliseconds: 300),
    );

    Timer(
      const Duration(milliseconds: 500),
      () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuart,
        );
      },
    );

    _focusNodes[index].requestFocus();

    // TODO Функция для тестирования состояния текс филдов
    print('варианты: ${controllerTextFieldEventsWheel.map((e) => e.text)}');
  }

  void _removeAtIndex(int index) {
    controllerTextFieldEventsWheel.removeAt(index);
    _focusNodes.removeAt(index);
    _data.removeAt(index);
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
    final listOfWheels = context.read<ListOfWheelsModel>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Добавить колесо'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButton: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: FloatingActionButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  Navigator.of(context).pop();
                },
                heroTag: null,
                child: const Icon(Icons.check_outlined),
              ),
            ),
            const Spacer(),
            FloatingActionButton(
              backgroundColor:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              foregroundColor:
                  Theme.of(context).floatingActionButtonTheme.foregroundColor,
              onPressed: () {
                _insert();
              },
              heroTag: null,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 75),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10),
                child: Form(
                  // !!!!!!!!!!
                  key: _formKey,
                  child: TextFormField(
                    controller: controllerTextFieldNameWheel,
                    onSaved: (newValue) {
                      listOfWheels.addNameWheel(newValue);
                    },
                    // !!!!!!!!!
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                              width: 2, color: Theme.of(context).focusColor)),
                      hintText: 'Название',
                      filled: true,
                      fillColor: Theme.of(context).primaryColorLight,
                    ),
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
              AnimatedList(
                key: _listKey,
                initialItemCount: _data.length,
                controller: _scrollController,
                primary: false,
                shrinkWrap: true,
                itemBuilder: ((context, index, animation) {
                  return SlideTransition(
                    position: animation.drive(Tween<Offset>(
                      begin: const Offset(-1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      // !!!!!!!!
                      child: TextFormField(
                        onChanged: (value) {
                          // print(value);
                        },
                        // !!!!!!!!!
                        controller: controllerTextFieldEventsWheel[index],
                        autofocus: true,
                        focusNode: _focusNodes[index],
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          if (_focusNodes.last.hasFocus) {
                            FocusScope.of(context).unfocus();
                          } else {
                            _focusNodes[index + 1].requestFocus();
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (() => _removeAtIndex(index)),
                              icon: const Icon(Icons.delete)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                width: 2, color: Theme.of(context).focusColor),
                          ),
                          hintText: 'Название варианта',
                          filled: true,
                          fillColor: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
