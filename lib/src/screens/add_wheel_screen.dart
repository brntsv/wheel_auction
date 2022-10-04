import 'dart:async';

import 'package:flutter/material.dart';

import '../settings/settings_controller.dart';
import 'global_settings_screen.dart';

class AddWheelScreen extends StatefulWidget {
  const AddWheelScreen({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/add_wheel';

  final SettingsController controller; // это удалить

  @override
  State<AddWheelScreen> createState() => _AddWheelScreenState();
}

class _AddWheelScreenState extends State<AddWheelScreen> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _data = [];
  final _focusNodes = List.generate(100, (index) => FocusNode());
  //ограничение в 100 элементов. Если добавить больше 100 вариантов, будет crash

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _insert();
    });
  }

  @override
  void dispose() {
    // controller.dispose();

    for (final FocusNode node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _insert() {
    final element = (_data.isEmpty ? 0 : _data.last) + 1;
    _data.add(element);
    final index = _data.length - 1;
    _listKey.currentState?.insertItem(
      index,
      duration: const Duration(milliseconds: 200),
    );

    Timer(
      const Duration(milliseconds: 220),
      () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Добавить колесо'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          foregroundColor:
              Theme.of(context).floatingActionButtonTheme.foregroundColor,
          onPressed: () {
            setState(() {
              _insert();
            });
          },
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
                child: TextFormField(
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
                  controller: _scrollController,
                  itemBuilder: ((context, index, animation) {
                    return SlideTransition(
                      position: animation.drive(Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          // controller: controller,
                          autofocus: index == 0,
                          focusNode: _focusNodes[index],
                          // textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            if (index < _data.length) {
                              if (text.isEmpty) {
                                _focusNodes[index - 1].requestFocus();
                              } else {
                                _focusNodes[index + 1].requestFocus();
                              }
                            }
                            //тут три бага, переписать.
                            //нужно выяснить как поставить delay на ввод текста
                            //еще тут remove удаляет value соседнего элемента
                            //если в последнем поле удалить последний символ, краш
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
                                  width: 2,
                                  color: Theme.of(context).focusColor),
                            ),
                            hintText: 'Название варианта',
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
        // bottomSheet: SizedBox(
        //   width: double.infinity,
        //   height: 50,
        //   child: ElevatedButton(
        //     style: ButtonStyle(
        //         backgroundColor: MaterialStatePropertyAll<Color>(
        //             Theme.of(context).primaryColor)),
        //     onPressed: () {
        //       setState(() {
        //         _insert();
        //       });
        //     },
        //     child: const Text('+ Добавить вариант'),
        //   ),
        // ),
      ),
    );
  }
}
