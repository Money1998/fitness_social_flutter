import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/views/auth/chnage_password.dart';
import 'package:montage/views/auth/login_view.dart';
import 'package:montage/views/myprofile/edit_profile.dart';
import 'package:montage/views/myprofile/favourite.dart';
import 'package:montage/views/myprofile/feedback.dart';
import 'package:montage/views/myprofile/webpage.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> implements ApiCallBacks {
  ApiPresenter apiPresenter;
  final fb = FacebookLogin();

  _SettingViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  var commonDivider = Divider(
    thickness: 1.2,
    color: dividerColor,
  );
  bool _switchValue = false;
  bool _switchValue1 = false;
  bool _switchValue2 = false;
  bool allowNotification = false;
  bool isLoading = false;
  var userId;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    userId = await SessionManager.getStringData('userId');
    apiPresenter.getUserData(context, userId);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        scaffoldKey: scaffoldKey,
        builder: (context, constraints) {
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Container(
              color: colorBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  appBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: commonPadding,
                        right: commonPadding,
                        top: paddingSmall + 4,
                      ),
                      child: Column(
                        children: [
                          settingItem(AppStrings.unlockPremium, null, null),
                          commonDivider,
                          settingItem(AppStrings.editProfile, SvgImages.nextIc,
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileView()),
                            );
                          }),
                          commonDivider,
                          settingItem(AppStrings.favourite, SvgImages.nextIc,
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavouriteView()),
                            );
                          }),
                          commonDivider,
                          settingItem(
                              AppStrings.notification, SvgImages.nextIc, null),
                          commonDivider,
                          settingItem(
                              AppStrings.changePassword, SvgImages.nextIc, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()),
                            );
                          }),
                          commonDivider,
                          settingItem(AppStrings.connectWithApple, null, null),
                          commonDivider,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: paddingVerySmall,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Allow Notifications",
                                  style: onBackgroundMedium(
                                    fontSize: textSmall + 2,
                                  ),
                                ),
                                Container(
                                    height: 20,
                                    width: 50,
                                    child: Transform.scale(
                                      scale: 0.8,
                                      child: CupertinoSwitch(
                                        value: allowNotification,
                                        activeColor: Color(0xff63AE9C),
                                        onChanged: (bool value) async {
//
                                          var id = await SessionManager
                                              .getStringData('userId');
                                          setState(() {
                                            allowNotification = value;
                                          });
                                          apiPresenter.doAllowNotification(
                                              allowNotification, id);
                                        },
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          commonDivider,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: paddingVerySmall,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppStrings.showPhysical,
                                  style: onBackgroundMedium(
                                    fontSize: textSmall + 2,
                                  ),
                                ),
                                Container(
                                    height: 20,
                                    width: 50,
                                    child: Transform.scale(
                                      scale: 0.8,
                                      child: CupertinoSwitch(
                                        value: _switchValue,
                                        activeColor: Color(0xff63AE9C),
                                        onChanged: (bool value) {
                                          setState(() {
                                            print(value);
                                            _switchValue = value;
                                          });
                                        },
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          commonDivider,
                          settingItemWithToggle(
                            AppStrings.backgroundMusic,
                            _switchValue2,
                          ),
                          commonDivider,
                          settingItemWithToggle(
                            AppStrings.shareProfile,
                            _switchValue1,
                          ),
                          commonDivider,
                          settingItem(AppStrings.faq, null, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WebPageView(AppStrings.faq)),
                            );
                          }),
                          commonDivider,
                          settingItem(AppStrings.sendFeedback, null, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeedBackView()),
                            );
                          }),
                          commonDivider,
                          settingItem(AppStrings.privacyPolicy, null, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WebPageView(AppStrings.privacyPolicy)),
                            );
                          }),
                          commonDivider,
                          settingItem(AppStrings.teamsNcondition, null, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WebPageView(AppStrings.teamsNcondition)),
                            );
                          }),
                          commonDivider,
                          settingItem(AppStrings.logOut, null, () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Are you sure you want to log out?",
                                      style: TextStyle(
                                          fontFamily: FontNameRegular,
                                          fontSize: 16),
                                    ),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          fb.logOut();
                                          SessionManager.setBooleanData(
                                              IS_ROUTINE, false);
                                          SessionManager.removeString(IS_LOGIN);
                                          SessionManager.removeString(
                                              'user_profile');

                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginView(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        child: Text("Yes"),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                      ),
                                    ],
                                  );
                                });
                          }),
                          commonDivider,
                          SizedBox(
                            height: paddingMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  settingItem(text, icon, onTab) {
    return InkWell(
        onTap: onTab,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: paddingVerySmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: onBackgroundMedium(
                  fontSize: textSmall + 2,
                ),
              ),
              icon == null
                  ? Container()
                  : SvgPicture.asset(
                      icon,
                      height: smallIconSize,
                      width: smallIconSize,
                    )
            ],
          ),
        ));
  }

  settingItemWithToggle(text, toggleValue) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: paddingVerySmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: onBackgroundMedium(
              fontSize: textSmall + 2,
            ),
          ),
          Container(
              height: 20,
              width: 50,
              child: Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: toggleValue,
                  activeColor: Color(0xff63AE9C),
                  onChanged: (bool value) {
                    setState(() {
                      print(value);
                      toggleValue = value;
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }

  appBar() {
    return SubPageAppBar(
      title: AppStrings.settings,
      actionIcons: [],
    );
  }

  @override
  void onConnectionError(String error, String requestCode) {
    setState(() {
      isLoading = false;
      // Utilities.showError(scaffoldKey, error);
    });
  }

  @override
  void onError(String errorMsg, String requestCode) {
    setState(() {
      isLoading = false;
      // Utilities.showError(scaffoldKey, errorMsg);
    });
  }

  @override
  void onSuccess(object, String strMsg, String requestCode) {
//    print();
    print("GET USER BY ID");
    print(requestCode);
    setState(() {
      isLoading = false;
      if (requestCode == RequestCode.GET_USER_BY_ID + userId) {
        allowNotification = object['is_notification'];
        // Utilities.showSuccess(scaffoldKey, strMsg);
      }
    });
  }
}
