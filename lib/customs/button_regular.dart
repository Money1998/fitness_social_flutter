// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:montage/constants/svg_images.dart';
// import 'package:montage/utils/colors.dart';
// import 'package:montage/utils/dimens.dart';
// import 'package:montage/utils/text_styles.dart';

// class ButtonRegular extends StatelessWidget {
//   ButtonRegular({
//     @required this.onPressed,
//     this.buttonText,
//     this.padding,
//     this.borderRadius,
//     this.fontSize,
//     this.widget,
//     this.isEnable,
//     this.isCenter = true,
//     this.leadIcon = false,
//     this.leadIconSize,
//   });

//   final GestureTapCallback onPressed;
//   final String buttonText;
//   final Widget widget;
//   double padding;
//   final double borderRadius;
//   final double fontSize;
//   final bool isCenter;
//   final bool leadIcon;
//   final double leadIconSize;
//   bool isEnable;

//   @override
//   Widget build(BuildContext context) {
//     if (isEnable == null) isEnable = true;
//     if (padding == null) padding = paddingLarge;
//     return Material(
//         borderRadius: BorderRadius.all(Radius.circular(
//             this.borderRadius == null ? paddingSmall / 2 : this.borderRadius)),
//         color: isEnable ? colorPrimary : disableButton,
//         child: InkWell(
//           borderRadius: BorderRadius.all(Radius.circular(paddingSmall / 2)),
//           child: Container(
//             padding: EdgeInsets.symmetric(
//                 vertical: padding / 2.3, horizontal: padding),
//             child: isCenter == false
//                 ? Row(
//                     children: [
//                       Visibility(
//                         visible: leadIcon,
//                         child: SvgPicture.asset(
//                           SvgImages.add,
//                           height: smallIconSize - 4,
//                           width: smallIconSize - 4,
//                         ),
//                       ),
//                       SizedBox(
//                                   width:leadIcon== true? paddingSmall-4:0,
//                                 ),
//                       buttonText == null
//                           ? widget
//                           : Text(
//                               buttonText,
//                               style: isEnable
//                                   ? onPrimaryMedium(fontSize: fontSize)
//                                   : onBackgroundLightMedium(fontSize: fontSize),
//                             ),
//                     ],
//                   )
//                 : Center(
//                     child: buttonText == null
//                         ? widget
//                         : Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                                 Visibility(
//                                   visible: leadIcon,
//                                   child: SvgPicture.asset(
//                                     SvgImages.add,
//                                     height: leadIconSize == null
//                                         ? smallIconSize - 3
//                                         : leadIconSize,
//                                     width: leadIconSize == null
//                                         ? smallIconSize - 3
//                                         : leadIconSize,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width:leadIcon== true? paddingSmall-4:0,
//                                 ),
//                                 Text(
//                                   buttonText,
//                                   style: isEnable
//                                       ? onPrimaryMedium(fontSize: fontSize)
//                                       : onBackgroundLightRegular(
//                                           fontSize: fontSize),
//                                 ),
//                               ])),
//           ),
//           onTap: isEnable ? onPressed : null,
//         ));
//   }
// }
