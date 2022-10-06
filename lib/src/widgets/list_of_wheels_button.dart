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
          barrierLabel: "Мои колеса",
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
                        horizontal: 24, vertical: 20),
                    elevation: 0,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Мои колеса'),
                          ),
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount:
                                6, //сюда массив передать сформированного листа
                            itemBuilder: ((context, index) {
                              return Card(
                                color: Theme.of(context).cardColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  splashColor: Colors.white.withAlpha(30),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 5),
                                    child: Row(
                                      children: [
                                        const Text('Название варианта'),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.keyboard_arrow_right),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
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
