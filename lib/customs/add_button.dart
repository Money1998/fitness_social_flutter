import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';


class AddButton extends StatelessWidget {
  AddButton(
      {@required this.onPressed,
      this.buttonText,
      this.addIconSize,
      this.borderRadius});

  final GestureTapCallback onPressed;
  final String buttonText;
  final double addIconSize;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(
          Radius.circular(borderRadius == null ? paddingSmall : borderRadius)),
      color: colorPrimary,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(
            borderRadius == null ? paddingSmall : borderRadius)),
        child: Container(
          padding: const EdgeInsets.all(paddingMedium - 2),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                Icons.add,
                color: colorBackground,
                size: addIconSize == null ? smallIconSize : addIconSize,
              ),
              SizedBox(
                width: paddingSmall,
              ),
              Text(
                buttonText,
                style: onPrimaryRegular(fontSize: textSmall + 4),
              ),
            ],
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
