import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:montage/app.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/customs/global_var.dart' as globals;
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/views/auth/guidline_view.dart';

void main() async {
  print(globals.isLoggedIn);
  print("IS LOGGED IN ");
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    bool _result = await SessionManager.getBooleanData(IS_LOGIN);
    bool _resultStep = await SessionManager.getBooleanData(IS_ROUTINE);
    if (_result == true) {
      runApp(MontageApp(defaultWidgets: RouteTabVIew));
    }
    else if(_resultStep==true){
      runApp(MontageApp(defaultWidgets: RouteLoginView));
    }
    else {
      runApp(MontageApp(defaultWidgets: RouteGuideLineView));
    }
  } on SocketException catch (_) {
    runApp(MontageApp(defaultWidgets: RouteNoInternetConnectionView));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Montage',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        highlightColor: Colors.transparent,
        canvasColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GuidlineView(),
    );
  }
}
