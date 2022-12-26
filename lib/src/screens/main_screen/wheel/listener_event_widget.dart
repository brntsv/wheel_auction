import 'package:flutter/material.dart';

class ListenerEventWidget extends StatefulWidget {
  const ListenerEventWidget({Key? key}) : super(key: key);

  @override
  State<ListenerEventWidget> createState() => _ListenerEventWidgetState();
}

class _ListenerEventWidgetState extends State<ListenerEventWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text('ListenerEvent');
  }
}
