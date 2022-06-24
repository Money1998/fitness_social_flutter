import 'package:flutter/material.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/customs/global_var.dart' as globals;

class GuidlinePage02View extends StatefulWidget {
  @override
  _GuidlinePage02ViewState createState() => _GuidlinePage02ViewState();
}

class _GuidlinePage02ViewState extends State<GuidlinePage02View> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, constraints) {
        return _body();
      },
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.only(top: paddingLarge * 2),
      decoration: BoxDecoration(gradient: lightgradientBG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                cardListView(),
                bottomLogo(),
              ],
            ),
          )
        ],
      ),
    );
  }

  cardListView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: paddingLarge * 2,
              right: paddingLarge * 2,
              top: paddingLarge),
          child: Text(
            'Okay '+ globals.userName +' , we are almost there.',
            textAlign: TextAlign.center,
            style: primaryRegular(
              fontSize: textLarge,
            ),
          ),
        ),
        SizedBox(
          height: paddingLarge * 2,
        ),
        Padding(
          padding: EdgeInsets.only(left: paddingLarge, right: paddingLarge),
          child: Column(
            children: [
              card(AssetsImage.chillImage, AppStrings.chill,
                  AppStrings.betterSleep, 1),
              SizedBox(
                height: paddingSmall * 2,
              ),
              card(AssetsImage.connectImage, AppStrings.connect,
                  AppStrings.supportGroup, 2),
              SizedBox(
                height: paddingSmall * 2,
              ),
              card(AssetsImage.chargeImage, AppStrings.charge,
                  AppStrings.buildUp, 3),
              SizedBox(
                height: paddingLarge * 2,
              ),
            ],
          ),
        )
      ],
    );
  }

  card(image, title, subTitle, index) {
    return InkWell(
      onTap: () {
        globals.categoryId = index == 1 ? '60393ef9434d43160ce01156' : index == 2 ? '60393f79434d43160ce01157' : '60393f90434d43160ce01158';
        Navigator.pushNamed(context, RouteGuildlinePage04);
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              child: Image.asset(
                image,
                color: Color.fromRGBO(255, 255, 255, 0.7),
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.cover,
              ),
            ),
          ),
          cardOvelyText(title, subTitle)
        ],
      ),
    );
  }

  cardOvelyText(title, subTitle) {
    return Padding(
      padding:
          EdgeInsets.only(left: paddingSmall, bottom: paddingMedium + 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: primarySemiBold(fontSize: textMedium + 2),
          ),
          SizedBox(
            height: paddingSmall,
          ),
          Text(
            subTitle,
            style: primaryLight(
              fontSize: textSmall,
            ),
          )
        ],
      ),
    );
  }

  bottomLogo() {
    return Column(
      children: [
        CircleAvatar(
          radius: 28.0,
          backgroundColor: colorBackground,
          child: Image.asset(
            AssetsImage.logo,
            height: smallIconSize * 2.5,
            width: smallIconSize * 2.5,
          ),
        ),
        SizedBox(
          height: paddingSmall,
        ),
        Text(
          AppStrings.poweredBy,
          style: primaryRegular(),
        ),
        SizedBox(
          height: paddingSmall * 2.5,
        ),
      ],
    );
  }
}
