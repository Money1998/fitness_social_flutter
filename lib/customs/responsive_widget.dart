import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montage/customs/size_information.dart';
import 'package:montage/utils/colors.dart';

class ResponsiveWidget extends StatelessWidget {
  final AppBar appBar;
  // final SidebarDrawer drawer;
  final Theme bottomNavigationBar;
  final GlobalKey scaffoldKey;
  final Widget Function(BuildContext context, SizeInformation constraints)
      builder;

  ResponsiveWidget(
      {@required this.builder,
      this.appBar,
      // this.drawer,
      this.scaffoldKey,
      this.bottomNavigationBar
      });

  // ignore: unused_field
  final _navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.transparent, // status bar color
      statusBarBrightness: Brightness.light,//status bar brigtness
      statusBarIconBrightness:Brightness.light , //status barIcon Brightness
      systemNavigationBarDividerColor: colorPrimary,//Navigation bar divider color
      systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icon

    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;
  

    SizeInformation information = SizeInformation(width, height, orientation);

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      // drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      extendBody: true,
      body: Builder(builder: (context) {
        return builder(context, information);
      }),
    );
  }
}
