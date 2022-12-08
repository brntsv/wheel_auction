import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/global_settings_screen/global_settings_screen.dart';

class AddWheelScreen extends StatefulWidget {
  const AddWheelScreen({Key? key}) : super(key: key);

  static const routeName = '/add_wheel';

  @override
  State<AddWheelScreen> createState() => _AddWheelScreenState();
}

class _AddWheelScreenState extends State<AddWheelScreen> {
  final _listKey = GlobalKey<AnimatedListState>();

  // late GlobalKey<FormState> _formKeyPart2;
  // late TextEditingController _controllerTextFieldNamesPart2;
  // var wheels;
  // var dynamicList;

  final _data = <dynamic>[];
  final _focusNodes = List.generate(100, (index) => FocusNode());
  //ограничение в 100 элементов. Если добавить больше 100 вариантов, будет crash
  // late final TextEditingController controllerTextField;
  final List<TextEditingController> controllerTextField =
      List.generate(100, (index) => TextEditingController());

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // _formKeyPart2 = GlobalKey<FormState>();
    // _controllerTextFieldNamesPart2 = TextEditingController();
    // wheels = Provider.of<ListOfWheelsProviderPart2>(context, listen: false);
    // dynamicList = DynamicList(wheels.list);

    for (final TextEditingController field in controllerTextField) {
      field.addListener(() {});
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _insert();
    });
  }

  @override
  void dispose() {
    for (final TextEditingController field in controllerTextField) {
      field.dispose();
    }

    for (final FocusNode node in _focusNodes) {
      node.dispose();
    }

    // _controllerTextFieldNamesPart2.dispose();

    super.dispose();
  }

  void _insert() {
    dynamic element = (_data.isEmpty ? 0 : _data.last) + 1;
    _data.add(element);
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

    _focusNodes[index + 1].requestFocus();
  }

  void _removeAtIndex(int index) {
    dynamic element = _data.removeAt(index);
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
    // var wheels = context.watch<ListOfWheelsProvider>().wheels;
    // var listOfWheel = context.watch<ListOfWheelsProvider>().listOfVariants;

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
                onPressed: () {},
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
              onPressed: () => _insert(),
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
                  // key: _formKeyPart2,
                  // ??????????????????????????
                  child: TextFormField(
                    // controller: _controllerTextFieldNamesPart2,
                    // ???????????????????????????????????
                    // onSaved: ((newValue) {
                    //   wheels.addWheel(newValue);
                    // }),
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
                      child: TextFormField(
                        controller: controllerTextField[index],
                        autofocus: true,
                        focusNode: _focusNodes[index],
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          _focusNodes[index + 1].requestFocus();
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
