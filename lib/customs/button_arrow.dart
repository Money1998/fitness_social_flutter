import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';

class ButtonArrow extends StatelessWidget {
  ButtonArrow(
      {@required this.onPressed,
      this.buttonText,
      this.borderRadius,
      this.isLeft = false,
      this.buttonPadding,
      this.fontSize,
      this.image});

  final GestureTapCallback onPressed;
  final String buttonText;
  final double borderRadius;
  final double buttonPadding;
  final bool isLeft;
  final double fontSize;
  final String image;

  @override
  Widget build(BuildContext context) {

    return Material(
      borderRadius: BorderRadius.all(
          Radius.circular(borderRadius == null ? paddingLarge : borderRadius)),
      color: colorPrimary,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(
            borderRadius == null ? paddingLarge : borderRadius)),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: buttonPadding == null ? paddingMedium : buttonPadding,
              horizontal: paddingMedium),
          child: isLeft == true
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      buttonText,
                      style: onPrimarySemiBold(fontSize:fontSize == null ?textMedium-2:fontSize),
                    ),
                    image != null ?
                    SvgPicture.asset(image,
                        height: smallIconSize, width: smallIconSize,color: colorOnPrimary,) :
                    Icon(
                      Icons.arrow_forward,
                      color: colorBackground,
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      buttonText,
                      style: onPrimarySemiBold(fontSize:textMedium-2),
                    ),
                    image != null ?
                    SvgPicture.asset(image,
                        height: smallIconSize, width: smallIconSize,color: colorOnPrimary) :
                    Icon(
                      Icons.arrow_forward,
                      color: colorBackground,
                    ),
                  ],
                ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
