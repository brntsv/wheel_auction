import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wheel_auction/src/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // оставляет ориентацию экрана всегда в одном положении
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}
