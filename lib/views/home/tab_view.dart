import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/custom_appBar.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/views/home/charge_view.dart';
import 'package:montage/views/home/chill_view.dart';
import 'package:montage/views/home/connect_view.dart';
import 'package:montage/views/myprofile/profile_view.dart';
import 'package:toast/toast.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _cIndex = 0;
  TextEditingController searchController = TextEditingController();
  Key index;
  bool showSearchBox = false;

  @override
  void initState() {
    super.initState();
  }

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show('Tap again to exit', context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                showSearchBox == true
                    ? search()
                    : CustomAppBar(
                        color: colorBackground,
                        logo: AssetsImage.logo,
                        actionButtons: actionButton(),
                      ),
                Expanded(
                  child: Container(
                    child: getContent(),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                left: paddingLarge + 4,
                right: paddingLarge + 4,
              ),
              padding: EdgeInsets.symmetric(
                vertical: paddingSmall,
              ),
              decoration: BoxDecoration(
                color: Color(0xffF1F1F1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    16,
                  ),
                  topLeft: Radius.circular(
                    16,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0,
                    blurRadius: paddingSmall / 3,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: paddingLarge * 3,
                      right: paddingLarge * 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.asset(AssetsImage.logo,height:60,width:60),
                        tab(0, 'Montage', SvgImages.blockLogoIc),
                        tab(
                          1,
                          'Chill',
                          SvgImages.chillTabIc,
                        ),
                        tab(
                          2,
                          'Connect',
                          SvgImages.connectIc,
                        ),
                        tab(
                          3,
                          'Charge',
                          SvgImages.chargeTabIc,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  search() {
    return Padding(
      padding: EdgeInsets.only(
        left: commonPadding,
        right: commonPadding,
        top: paddingSmall + 4,
        bottom: paddingSmall,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showSearchBox = false;
              setState(() {});
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorTheme,
            ),
          ),
          Flexible(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: colorTheme),
                  borderRadius: BorderRadius.circular(2.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      onSubmitted: (text) {
                        // if (textInputAction == TextInputAction.next)
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (text) {},
                      controller: searchController,
                      cursorColor: colorBackground,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                            right: paddingSmall,
                          ),
                          child: Icon(
                            Icons.mic,
                            size: smallIconSize + 4,
                            color: inactivetabColor,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints.loose(
                          Size.fromWidth(30),
                        ),
                        suffixIconConstraints: BoxConstraints.loose(
                          Size.fromWidth(30),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: paddingSmall,
                            right: paddingSmall * 2,
                          ),
                          child: Icon(
                            Icons.search,
                            color: colorTheme,
                            size: smallIconSize + 4,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          bottom: paddingSmall * 2,
                        ),
                        hintText: 'SEARCH',
                        hintStyle: themeFontRegular(),
                      ),
                      style: commontextStyle(
                        fontSize: textSmall + 2,
                        color: colorOnBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  tab(index, title, icon) {
    return InkWell(
      onTap: () {
        if (_cIndex != index) {
          setState(() {
            _cIndex = index;
          });
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: paddingVerySmall - 2),
            child: SvgPicture.asset(
              icon,
              height: iconSize - 4,
              width: iconSize - 4,
              color: _cIndex == index ? colorTheme : inactivetabColor,
            ),
          ),
          SizedBox(
            height: paddingSmall,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: FontNameRegular,
              fontSize: textSmall - 2,
              color: _cIndex == index ? colorTheme : colorOnBackgroundLight,
            ),
          ),
          SizedBox(
            height: paddingVerySmall,
          ),
          _cIndex == index
              ? Container(
                  height: 2.0,
                  color: colorTheme,
                  width: 30,
                )
              : Container()
        ],
      ),
    );
  }

  double actionButtonPadding = paddingSmall;

  List<Widget> actionButton() {
    return [
      IconButton(
        onPressed: () {
          setState(() {
            showSearchBox = true;
          });
        },
        icon: actionButtonItem(Icons.search),
      ),
      IconButton(
        onPressed: () {},
        icon: actionButtonItem(Icons.notifications),
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteChatView);
        },
        icon: actionButtonItem(Icons.mode_comment),
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteSettingView);
        },
        icon: actionButtonItem(Icons.settings),
      ),
    ];
  }

  actionButtonItem(icon) {
    return Icon(
      icon,
      size: smallIconSize * 1.5,
      color: Color(0xff858585),
    );
  }

  getContent() {
    switch (_cIndex) {
      case 0:
        return ProfileView(from: "Tabview");
      case 1:
        return ChillView();
      case 2:
        return ConnectView();
      case 3:
        return ChargeView();
    }
  }
}
