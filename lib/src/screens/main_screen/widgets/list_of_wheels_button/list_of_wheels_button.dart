import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheel_auction/src/screens/add_wheel_screen/model/list_of_wheels_model.dart';
import 'package:wheel_auction/src/theme/app_text_style.dart';
import 'package:wheel_auction/src/theme/app_theme.dart';

class ListOfWheelsButton extends StatelessWidget {
  const ListOfWheelsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Принимает список колес от Add Wheel Screen
    final provider = context.watch<ListOfWheelsModel>();
    final wheels = provider.wheels;

    final theme = Theme.of(context);

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
                  color: theme.primaryColorDark,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: StatefulBuilder(
                  builder: (context, setState) => Dialog(
                    alignment: Alignment.topCenter,
                    backgroundColor: theme.primaryColorDark,
                    insetPadding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    elevation: 0,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            child: Text(
                              'Мои колеса',
                              style: AppTextStyle.listWheelsHeader,
                            ),
                          ),
                          Consumer<ListOfWheelsModel>(
                            builder: ((context, value, child) {
                              return MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: wheels.length,
                                  itemBuilder: ((context, index) {
                                    return Card(
                                      color: theme.cardColor,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 4,
                                                child: Text(
                                                  '${wheels[index]}',
                                                  style: AppTextStyle
                                                      .cardListWheel,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_right),
                                                  splashColor:
                                                      AppColors.transparent,
                                                  highlightColor:
                                                      AppColors.transparent,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
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
        (wheels.isEmpty ? '' : wheels.first) ?? '',
        style: theme.textTheme.bodyText2,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
