import 'package:flutter/material.dart';

class ListOfWheelsButton extends StatefulWidget {
  ListOfWheelsButton({Key? key}) : super(key: key);

  @override
  State<ListOfWheelsButton> createState() => _ListOfWheelsButtonState();
}

class _ListOfWheelsButtonState extends State<ListOfWheelsButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showGeneralDialog(
          barrierLabel: "Label",
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.2),
          transitionDuration: const Duration(milliseconds: 250),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                margin: const EdgeInsets.only(bottom: 425, left: 50, right: 50),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: StatefulBuilder(
                  builder: (context, setState) => Dialog(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    insetPadding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    elevation: 0,
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position:
                  Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                      .animate(anim1),
              child: child,
            );
          },
        );
      },
      child: Text(
        'NameWheelButton',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
