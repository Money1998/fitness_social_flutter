import 'dart:async';

import 'package:flutter/material.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/views/home/tab_view.dart';

class WelcomeScreenView extends StatefulWidget {
  const WelcomeScreenView({Key key}) : super(key: key);

  @override
  _WelcomeScreenViewState createState() => _WelcomeScreenViewState();
}

class _WelcomeScreenViewState extends State<WelcomeScreenView>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   /* controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(1.5, 0.0))
        .animate(controller);

    controller.forward();*/

    Timer(Duration(seconds: 2), () {
      // 5 seconds over, navigate to Page2.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => TabView(),
        ),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(gradient: gradientBG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*SlideTransition(
                      position: offset,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: colorBackground,
                        child: Image.asset(
                          AssetsImage.logo,
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                    ),*/
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: colorBackground,
                      child: Image.asset(
                        AssetsImage.logo,
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                    SizedBox(
                      height: paddingLarge * 2,
                    ),
                    Text(
                      "Welcome",
                      softWrap: true,
                      style: onPrimarySemiBold(
                        fontSize: textLarge * 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
