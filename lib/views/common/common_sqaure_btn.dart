import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';

class CommonButton extends StatelessWidget {
  CommonButton({
    this.onPressed,
    this.buttonText,
    this.width,
    this.isleadIcon=false,
    this.leadIcon,
    this.isRightArrow=true,
    this.backgroundColor,
    this.borderColor,
    this.buttonFontStyle,
  });
  final Function onPressed;
  final String buttonText;
  final double width;
  final bool isleadIcon;
  final String leadIcon;
  final bool isRightArrow;
  final Color backgroundColor;
  final Color borderColor;
  final buttonFontStyle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor == null?Colors.transparent:backgroundColor,
          border: Border.all(color:borderColor ==null? colorPrimary:borderColor, width: 0.6),
        ),
        padding: EdgeInsets.only(
          top: paddingMedium - 2,
          bottom: paddingMedium - 2,
          left: paddingLarge,
          right: paddingLarge,
        ),
        child: Row(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isleadIcon?Image.asset(leadIcon,height:smallIconSize,width: smallIconSize,):Container(),
                  SizedBox(width: paddingVerySmall),
                  Text(
                    buttonText ?? '',
                    style:buttonFontStyle== null? primaryMedium(fontSize: textSmall):buttonFontStyle,
                  ),
                ],
              ),
            ),
           isRightArrow == true? SvgPicture.asset(
              SvgImages.rightArrowIc,
              height: smallIconSize * 1.5,
              width: smallIconSize * 1.5,
            ):Container(),
          ],
        ),
      ),
    );
  }
}
