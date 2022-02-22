import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:montage/constants/assets_images.dart';

import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  final String logo;
  final void Function() onPressed;
  final Color color;
  
  List<Widget> actionButtons = [];
  final bool centerTitle;

  CustomAppBar(
      {this.logo,
      this.actionButtons,
      this.onPressed(),
      this.centerTitle = false,
      this.color,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:0),
      color: color == null ? colorBackground : color,
      padding: EdgeInsets.only(
        top: paddingSmall+4,
        bottom: paddingSmall,
        left: paddingLarge,
        right: paddingLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            logo == null ? AssetsImage.logo : logo,
            height: iconSize*1.7,
            width: iconSize*1.7,
          ),
          actionButtons == null
              ? SizedBox(
                  width: 30,
                )
              : Row(children: actionButtons,)
        ],
      ),
    );
  }
}
