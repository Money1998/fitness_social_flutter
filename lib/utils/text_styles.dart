import 'package:flutter/material.dart';

import 'colors.dart';

const String FontNameBold = 'comfortaaBold';
const String FontNameSemiBold = 'comfortaaSemiBold';
const String FontNameMedium = 'comfortaaMedium';
const String FontNameRegular = 'comfortaaRegular';
const String FontNamelight = 'ComfortaaLight';

TextStyle commontextStyle(
    {double fontSize = 12.0, String fontFamily, Color color}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily == null ? FontNameRegular : fontFamily,
    color: color == null ? colorTheme : color,
  );
}

TextStyle inputBoxHintStyle({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: whiteWithOpacityFonts,
  );
}

TextStyle themeFontMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorTheme,
  );
}

TextStyle themeFontBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorTheme,
  );
}

TextStyle themeFontSemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorTheme,
  );
}

TextStyle themeFontRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: colorTheme,
  );
}

TextStyle primarySemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorPrimary,
  );
}
TextStyle primaryLargeBold({double fontSize = 16.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorPrimary,
  );
}

TextStyle primaryRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: colorPrimary,
  );
}

TextStyle primaryMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorPrimary,
  );
}

TextStyle primaryBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorPrimary,
  );
}

TextStyle primaryLight({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNamelight,
    color: colorPrimary,
  );
}

TextStyle onLightprimaryRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: whiteWithOpacityFonts,
  );
}

TextStyle errorTextRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: colorError,
  );
}

TextStyle errorTextMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorError,
  );
}

TextStyle errorTextBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorError,
  );
}

TextStyle errorTextSemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorError,
  );
}

/* MONTAGE */

TextStyle onPrimaryBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorOnPrimary,
  );
}

TextStyle onPrimarySemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorOnPrimary,
  );
}

TextStyle onPrimaryRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: colorOnPrimary,
  );
}

TextStyle onPrimaryMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorOnPrimary,
  );
}

TextStyle onSuccessBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorGreen,
  );
}

TextStyle onSuccessSemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorGreen,
  );
}

TextStyle onSuccessRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: colorGreen,
  );
}

TextStyle onSuccessMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorGreen,
  );
}

TextStyle onBackgroundBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorOnBackground,
  );
}

TextStyle onBackgroundSemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorOnBackground,
  );
}

TextStyle onBackgroundRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: colorOnBackground,
  );
}

TextStyle onBackgroundMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorOnBackground,
  );
}

TextStyle blueTextBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorBlue,
  );
}

TextStyle blueTextSemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorBlue,
  );
}

TextStyle blueTextRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: colorBlue,
  );
}

TextStyle blueTextMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorBlue,
  );
}

TextStyle onBackgroundLightBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorOnBackgroundLight,
  );
}

TextStyle onBackgroundLightSemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameSemiBold,
    color: colorOnBackgroundLight,
  );
}

TextStyle onBackgroundLightRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameRegular,
    color: colorOnBackgroundLight,
  );
}

TextStyle onBackgroundLightMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorOnBackgroundLight,
  );
}

// Sagar textStyle

TextStyle primaryDisableBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: offPrimary,
  );
}

// TextStyle onLightprimaryRegular({double fontSize = 12.0}) {
//   return TextStyle(
//     fontSize: fontSize,
//   fontFamily: FontNameMedium,
//   color: colorPrimary,
//   );
// }

TextStyle onLightprimarySemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameBold,
    color: colorOnBackgroundLight,
  );
}

TextStyle onLightprimaryMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontNameMedium,
    color: colorOnBackgroundLight,
  );
}

TextStyle onBackgoundWitheightBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    height: 1.5,
    fontFamily: FontNameBold,
    color: colorOnBackground,
  );
}

TextStyle onBackgoundWitheightSemiBold({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    height: 1.5,
    fontFamily: FontNameSemiBold,
    color: colorOnBackground,
  );
}

TextStyle onBackgoundWitheightRegular({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    height: 1.5,
    fontFamily: FontNameRegular,
    color: colorOnBackground,
  );
}

TextStyle onBackgoundWitheightMedium({double fontSize = 12.0}) {
  return TextStyle(
    fontSize: fontSize,
    height: 1.5,
    fontFamily: FontNameMedium,
    color: colorOnBackground,
  );
}
