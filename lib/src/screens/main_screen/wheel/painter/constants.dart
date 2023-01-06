import 'package:wheel_auction/resources/app_images.dart';

/// Вращать значения, которые использовались для имитации начала
const int defaultMinRotateCircles = 3;

/// Время выполнения анимации поворота по умолчанию
const Duration defaultDuration = Duration(seconds: 5);

class Default {
  static List<String> get events => const <String>[
        'Flutter',
        'Developer',
        'local',
        'MANTRA -',
        'Everything...',
        'is WIDGET',
        'Hey',
        'I`m',
      ];
}

class CenterGifWidget {
  static List<String> get gifs => const <String>[
        AppImages.whiteCat,
        AppImages.pepegaCoolman,
        AppImages.pepegaSad,
        AppImages.papich,
        AppImages.punch,
        AppImages.jillette,
        AppImages.pepegaBusiness,
        AppImages.pepegaEyes,
        AppImages.clap,
        AppImages.duck,
        AppImages.hesus,
        AppImages.yellowboyAngry,
        AppImages.yellowboyCringe,
        AppImages.yellowboyNamaz,
        AppImages.blackCat,
        AppImages.anime,
        AppImages.dovolen,
        AppImages.praden,
        AppImages.wheelpog,
      ];
}
