import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:montage/utils/colors.dart';

import 'constants/router.dart' as router;

// ignore: must_be_immutable
class MontageApp extends StatefulWidget {
  String defaultWidgets;

  MontageApp({this.defaultWidgets});

  @override
  _MontageAppState createState() => _MontageAppState();
}

class _MontageAppState extends State<MontageApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Montage',
      theme: _appTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: widget.defaultWidgets,
      builder: EasyLoading.init(),
    );
  }
}

ThemeData _appTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    highlightColor: Colors.transparent,
    canvasColor: Colors.transparent,
    backgroundColor: colorBackground,
  );
}
