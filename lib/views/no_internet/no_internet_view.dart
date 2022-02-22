import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/customs/button_regular.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';

class NoInternetConnectionView extends StatefulWidget {
  const NoInternetConnectionView({Key key}) : super(key: key);

  @override
  NoInternetConnectionViewState createState() =>
      NoInternetConnectionViewState();
}

class NoInternetConnectionViewState extends State<NoInternetConnectionView> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Widget commonSizedBox(height) {
    return SizedBox(height: height);
  }

  Widget commonPadding(widget) {
    return Padding(
      child: widget,
      padding: EdgeInsets.only(left: paddingLarge, right: paddingLarge),
    );
  }

  Future<bool> onBackPressed() {
    return new Future(() => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: ResponsiveWidget(
          builder: (context, constraints) {
            return Container(
              color: colorBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: paddingLarge * 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.wifi,
                            //   size: iconButtonSize * 3,
                            // )
                            Image.asset('assets/icons/No Internet Connection.gif',height:iconButtonSize*3,width:iconButtonSize*3)
                          ],
                        ),
                        commonSizedBox(paddingMedium),
                        Text(
                         'oops',
                          style: onBackgroundBold(fontSize: textXXLarge),
                        ),
                        commonSizedBox(paddingSmall),
                        commonPadding(
                          Text(
                            'Please check your internet',
                            style: onBackgroundRegular(fontSize: textMedium),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(
                      vertical: paddingMedium,
                      horizontal: paddingMedium,
                    ),
                    child: Text("fd")
                  )
                ],
              ),
              // ],
            );
          },
        ));
  }
}
