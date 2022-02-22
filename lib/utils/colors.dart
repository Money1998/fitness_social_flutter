import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
}

var gradientBG = LinearGradient(
  colors: [
    HexColor("#BA00FF"),
    HexColor("#3C0662"),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

var lightgradientBG = LinearGradient(
  colors: [
    HexColor("#F8E5FF"),
    HexColor("#A35CC4"),
    HexColor("#400B65"),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const colorPrimary = const Color(0xffFFFFFF);
const colorTheme = const Color(0xff7817C8);
const lightFonts = const Color(0xffCB78E8);
const inactivetabColor = const Color(0xff636363);
var whiteWithOpacityFonts = const Color(0xffFFFFFF).withOpacity(0.4);
var dividerColor = const Color(0xffD8D8D8);
var lightThemeFonts = const Color(0xff511F74).withOpacity(0.5);
const colorOnBackground = const Color(0xff000000);
const colorOnBackgroundLight = const Color(0xff141319);




  /* MoNTAGE COLORS*/

// const colorPrimary = const Color(0xff2498E2);
const colorPrimaryLight = const Color(0xff2498E2);
const colorPrimaryDark = const Color(0xff2498E2);
const colorBackground = const Color(0xffFFFFFF);
const colorBackgroundLight = const Color(0xfff0f9f2);
const colorBackgroundTillLight = const Color(0xffe2f3ff);

const colorProfileBorder = const Color(0xffc7c7ca);

const colorBorder = const Color(0xffD0D0D0);
const cardBorder = const Color(0xfff1eeee);

const colorSurface = const Color(0xff2498E2);

const colorBackgroundgrey = const Color(0xFFf5f5f5);

const colorOnSurface = const Color(0xffFFFFFF);
const colorOnSurfaceLight = const Color(0xffFFFFFF);
const colorOnPrimary = const Color(0xffFFFFFF);
const colorError = const Color(0xffCE3625);


const lightRed = const Color(0xFFFFCDD2);
const colorLightRed = const Color(0xFFFFEBEE);
const colorPrimaryLightBorder = const Color(0xFFf4f5f8);
const colorPrimaryLightBackground =
    const Color(0xfff0f9f2); //const Color(0xFFE3F2FD);
const colorBlue = const Color(0xff012a36);

const colorRedBorder = const Color(0xFFb5a6);
const colorActiveBackground = const Color(0xfff4f5f8);
const obTabpageAppBarBG = const Color(0xffffef99);
const profileBackground = const Color(0xffeef2ff);
const greyBackground = const Color(0xffececec);
const sanctuaryElementBackground = const Color(0xffffedfa);
const moanaPasifikaAppBackground = const Color(0xff90fae5);
const iconBackground = const Color(0xfff2f2f2);
const offersAppBackground = const Color(0xffb0e5e0);
const offPrimary = const Color(0xff90cbf0);

const colorBackgoundGreen = const Color(0xff93c572);
const colorGreen = const Color(0xff3db24b);

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
