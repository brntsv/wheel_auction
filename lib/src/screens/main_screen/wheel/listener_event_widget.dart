import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/model/list_of_wheels_model.dart';
import 'package:wheel_auction/src/theme/app_text_style.dart';

class ListenerEventWidget extends StatefulWidget {
  const ListenerEventWidget({Key? key}) : super(key: key);

  @override
  State<ListenerEventWidget> createState() => _ListenerEventWidgetState();
}

class _ListenerEventWidgetState extends State<ListenerEventWidget> {
  final StreamController<int> streamController = StreamController<int>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    streamController.add;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('ListEvent'),
        StreamBuilder(
          stream: streamController.stream,
          builder: (context, snapshot) =>
              snapshot.hasData ? WheelEvent(snapshot.data as int) : Container(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}

class WheelEvent extends StatelessWidget {
  final int selected;

  const WheelEvent(this.selected, {super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.read<ListOfWheelsModel>().events.first;
    final mapEvents =
        events.asMap().map((index, events) => MapEntry(index + 1, events));

    return Text(
      '${mapEvents[selected]}',
      style: AppTextStyle.wheelSectorsText,
    );
  }
}


































// class Listen extends StatelessWidget {
//   const Listen({super.key, required this.group});
//   final WheelGroup group;
//   void listenerSector() {
//     for (var i = 0; i < group.divide; i++) {
//       final unit = group.sectors[i];
//       final sweep = 2 * pi * unit.weight / group.totalWeights;
//       print(sweep);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(onPressed: listenerSector, child: const Text('SHTO'));
//   }
// }