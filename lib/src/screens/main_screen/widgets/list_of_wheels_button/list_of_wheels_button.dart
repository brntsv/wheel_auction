import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/main_screen/model/list_of_wheels_model.dart';

class ListOfWheelsButton extends StatelessWidget {
  const ListOfWheelsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListOfWheelsModel>();
    final wheels = provider.wheels;

    return TextButton(
      onPressed: () {
        showGeneralDialog(
          barrierLabel: 'Мои колеса',
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.2),
          transitionDuration: const Duration(milliseconds: 250),
          context: context,
          pageBuilder: (context, anim1, anim2) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints:
                    const BoxConstraints(maxHeight: 315, minHeight: 100),
                margin: const EdgeInsets.only(bottom: 410, left: 50, right: 50),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: StatefulBuilder(
                  builder: (context, setState) => Dialog(
                    alignment: Alignment.topCenter,
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
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: Text('Мои колеса'),
                          ),
                          Consumer<ListOfWheelsModel>(
                            builder: ((context, value, child) {
                              return ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: wheels.length,
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
                                            Text('${wheels[index]}'),
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
        (wheels.isEmpty ? '' : wheels.last) ?? '',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
