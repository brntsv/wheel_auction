import 'package:flutter/material.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/wheel_group.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/constants.dart';
import 'package:wheel_auction/src/screens/main_screen/wheel/painter/helpers.dart'
    hide DoubleSum;

/// контроллер [Wheel] виджета.

/// [Wheel] использует [WheelController] для управления анимацией поворота
/// и [Wheel] отображает [WheelGroup].

class WheelController with ChangeNotifier {
  WheelController._(this._group, this._animation, this._controller);

  /// Создайте новый экземпляр WheelController.
  /// [group] - это отображаемая [WheelGroup].
  /// [vsync] - это [TickerProvider], используемый для анимации.
  factory WheelController({
    required WheelGroup group,
    required TickerProvider vsync,
  }) {
    final controller = AnimationController(vsync: vsync);
    final animation = controller.drive(Tween<double>(begin: 0, end: 0));
    return WheelController._(group, animation, controller);
  }

  WheelGroup _group;
  Animation<double> _animation;
  final AnimationController _controller;

  /// Текущая анимация поворота
  Animation<double> get animation => _animation;

  /// Получить текущее отображение [WheelGroup]
  WheelGroup get group => _group;

  /// Установите [WheelGroup] для обновления виджета
  set group(WheelGroup value) {
    _animation = _controller.drive(ConstantTween<double>(0));
    _group = value;
    notifyListeners();
    _controller.reset();
  }

  /// Вернуть анимацию в исходное состояние
  void resetAnimation() {
    _animation = _controller.drive(ConstantTween<double>(0));
    notifyListeners();
    _controller.reset();
  }

  /// Остановить текущую запущенную анимацию
  void stop({bool canceled = true}) {
    _controller.stop(canceled: canceled);
  }

  /// Запустите анимацию в [targetIndex], элемент [targetIndex] должен находиться в [group].
  /// [duration] - это продолжительность анимации.
  /// [clockwise] определяет, должен ли аниматор выполняться в противоположном направлении.
  /// Настройте [minRotateCircles], чтобы определить минимальный поворот перед установкой.
  /// Укажите [curve] для обновления кривой анимации.
  /// Укажите [offset] для положения остановки рулетки, по умолчанию 0 указывает на начало детали.

  Future<void> rollTo(
    int targetIndex,
    int minRotateCircles, {
    Duration duration = defaultDuration,
    // int minRotateCircles = defaultMinRotateCircles,
    bool clockwise = true,
    Curve? curve = Curves.fastOutSlowIn,
    double offset = 0,
  }) async {
    final targetRotate = calculateEndRotate(
      group,
      targetIndex,
      clockwise,
      minRotateCircles,
      offset: offset,
    );
    _controller.duration = duration;
    _animation = makeAnimation(_controller, targetRotate, curve,
        initialValue: animation.value);
    notifyListeners();
    await _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
