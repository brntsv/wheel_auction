import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/model/list_of_wheels_model.dart';
import 'package:wheel_auction/src/screens/global_settings_screen/global_settings_screen.dart';
import 'package:wheel_auction/src/theme/app_text_style.dart';
import 'package:wheel_auction/src/theme/app_theme.dart';

class AddWheelScreen extends StatefulWidget {
  const AddWheelScreen({Key? key}) : super(key: key);

  static const routeName = '/add_wheel';

  @override
  State<AddWheelScreen> createState() => _AddWheelScreenState();
}

class _AddWheelScreenState extends State<AddWheelScreen> {
  /// кей для названий колес
  final _formKey = GlobalKey<FormState>();

  /// кей для событий колес
  final _formListKey = GlobalKey<FormState>();
  // ? можно объединить в один формКей, нужно просто виджет Form перенести
  // ? выше Column и тогда будет достаточно одного _formKey

  /// кей для анимированного листа
  final _animKey = GlobalKey<AnimatedListState>();

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

  final List<double> _weight = [];

  @override
  void initState() {
    super.initState();

    // ! Функция для тестирования состояния названия
    controllerTextFieldNameWheel.addListener(_printTitleValue);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _insert();
    });
  }

  // ! Функция для тестирования состояния названия
  void _printTitleValue() {
    print('название: ${controllerTextFieldNameWheel.text}');
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
    _animKey.currentState?.insertItem(
      index,
      duration: const Duration(milliseconds: 300),
    );
    _weight.add(1);

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

    // ! Функция для тестирования состояния текс филдов
    print('варианты: ${controllerTextFieldEventsWheel.map((e) => e.text)}');
  }

  void _removeAtIndex(int index) {
    controllerTextFieldEventsWheel.removeAt(index);
    _focusNodes.removeAt(index);
    _data.removeAt(index);
    _weight.removeAt(index);
    _animKey.currentState?.removeItem(index, (context, animation) {
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
    final List<String?> listEvents = [];
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Добавить колесо'),
          backgroundColor: theme.primaryColor,
        ),
        floatingActionButton: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: FloatingActionButton(
                onPressed: () {
                  _formKey.currentState?.save();

                  _formListKey.currentState?.save();

                  listOfWheels.addWeightsOfEvents(_weight);

                  Navigator.of(context).pop();
                },
                heroTag: null,
                child: const Icon(Icons.check_outlined),
              ),
            ),
            const Spacer(),
            FloatingActionButton(
              backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
              foregroundColor: theme.floatingActionButtonTheme.foregroundColor,
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
            children: [
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
                    style: AppTextStyle.hintInputText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 2,
                            color: theme.focusColor,
                          )),
                      hintText: 'Название',
                      hintStyle: AppTextStyle.hintInputText,
                      filled: true,
                      fillColor: theme.primaryColorLight,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.restorablePushNamed(
                    context,
                    GlobalSettingsWheel.routeName,
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(theme.primaryColor),
                  minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: Text('Настройки', style: theme.textTheme.button),
              ),
              // !!!!!!
              Form(
                key: _formListKey,
                child: AnimatedList(
                  key: _animKey,
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
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: controllerTextFieldEventsWheel[index],
                              onSaved: ((newValue) {
                                listEvents.add(newValue);
                                listOfWheels.addListOfEvents(listEvents);
                              }),
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
                              style: AppTextStyle.hintInputText,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: (() => _removeAtIndex(index)),
                                    icon: const Icon(Icons.delete)),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: theme.focusColor,
                                  ),
                                ),
                                hintText: 'Название варианта',
                                hintStyle: AppTextStyle.hintInputText,
                                filled: true,
                                fillColor: theme.primaryColorLight,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 60,
                            right: 70,
                            child: _WeightPickerWidget(
                              index: index,
                              weight: _weight,
                            ),
                          ),
                          const Positioned(
                            top: 60,
                            right: 70,
                            child: Text(''),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _WeightPickerWidget extends StatefulWidget {
  final int index;
  final List<double> weight;

  const _WeightPickerWidget(
      {Key? key, required this.index, required this.weight})
      : super(key: key);

  @override
  State<_WeightPickerWidget> createState() => _WeightPickerWidgetState();
}

int selectedValue = 0;
List<double> form = [];
const List<double> weightsInPicker = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

class _WeightPickerWidgetState extends State<_WeightPickerWidget> {
  void saveWeight(int index, List<double> weight) {
    if (form.isEmpty) {
      form.add(weightsInPicker[selectedValue]);
    } else {
      form.clear();
      form.add(weightsInPicker[selectedValue]);
    }
    weight.replaceRange(index, index + 1, form);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.75, sigmaY: 0.75),
        child: ElevatedButton(
          onPressed: () {
            showCupertinoModalPopup<void>(
              barrierColor: AppColors.barrier,
              context: context,
              builder: (_) => ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 35,
                      onSelectedItemChanged: (int selectedItem) {
                        selectedValue = selectedItem;
                        saveWeight(widget.index, widget.weight);
                      },
                      children: List<Widget>.generate(weightsInPicker.length,
                          (int index) {
                        return Center(
                          child: Text(weightsInPicker[index].toString()),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            );
          },
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0.2),
            backgroundColor: MaterialStatePropertyAll(
                theme.primaryColorLight.withOpacity(0.85)),
            side: MaterialStatePropertyAll(BorderSide(
              width: 1.0,
              color: theme.dividerColor.withAlpha(150),
            )),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13))),
          ),
          child: Text('',
              style: AppTextStyle.buttonWeightText
                  .copyWith(color: theme.hintColor)),
        ),
      ),
    );
  }
}
