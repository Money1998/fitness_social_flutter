import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/custom_page_route.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/auth/login_view.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';
import 'package:montage/views/home/tab_view.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:montage/customs/global_var.dart' as globals;

import 'guidline_view.dart';

class GuidlineView03 extends StatefulWidget {
  @override
  _GuidlineView03State createState() => _GuidlineView03State();
}

class _GuidlineView03State extends State<GuidlineView03>
    implements ApiCallBacks {
  ApiPresenter apiPresenter;
  final fb = FacebookLogin();

  _GuidlineView03State() {
    apiPresenter = new ApiPresenter(this);
  }

  commonSizedBox(height) {
    return SizedBox(
      height: height,
    );
  }

  padding(horizontal, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: widget,
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  onClickFacebookLogin() async {
    print("Login View FB Login");
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        final email = await fb.getUserEmail();
        if (email != null) print('And your email is $email');
        apiPresenter.doSocialLogin('Facebook', profile.userId, profile.name,
            email ?? "", imageUrl ?? "", context);
        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
    Utilities.loading(context, status: false);
  }

  onClickAppleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      print(credential.userIdentifier);
      print(credential.email);
      var name = '';
      var email = '';
      try {
        email = credential.email;
      } catch (error) {}
      try {
        if (credential.givenName == null) {
          name = globals.userName;
        } else {
          name = credential.givenName;
        }
      } catch (error) {}

      print(credential.familyName);
      apiPresenter.doSocialLogin(
          'Apple', credential.userIdentifier, name, email, '', context);
    } catch (error) {
      print(error);
      Utilities.loading(context, status: false);
    }
  }

  Future<void> onClickGoogleLogin() async {
    try {
      final user = await GoogleSignInApi.login();
      if (user != null) {
        print("user details => $user");
        Utilities.loading(context);
        print("Login ID : ${user.id}");
        print("Login DisplayName : ${user.displayName}");
        print("Login Email : ${user.email}");
        print("Login PhotoUrl : ${user.photoUrl}");
        apiPresenter.doSocialLogin('Google', user.id, user.displayName,
            user.email, user.photoUrl, context);
      }
    } catch (error) {
      print("error + ${error.message}");
      Utilities.loading(context, status: false);
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      scaffoldKey: scaffoldKey,
      builder: (context, constraints) {
        var width = MediaQuery.of(context).size.width;
        return Container(
          decoration: BoxDecoration(gradient: lightgradientBG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: KeyboardAvoider(
                  autoScroll: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      titleTxt(),
                      commonSizedBox(paddingLarge * 2.5),
                      commonSizedBox(
                        paddingMedium * 2,
                      ),
                      CommonButton(
                        width: width / 1.4,
                        buttonText: AppStrings.signupWithEmail,
                        buttonFontStyle: primaryMedium(
                            fontSize: MediaQuery.of(context).size.width < 385
                                ? 09
                                : textSmall),
                        onPressed: () async {
                          bool _result =
                              await SessionManager.getBooleanData(IS_ROUTINE);
                          if (_result) {
                            Utilities.loading(context);
                            onClickGoogleLogin();
                            Utilities.loading(context, status: false);
                          } else {
                            Navigator.of(context)
                                .push(CustomPageRoute(child: GuidlineView()));
                          }
                        },
                      ),
                      commonSizedBox(paddingMedium + 6),
                      Visibility(
                        visible: true,
                        child: CommonButton(
                            onPressed: () async {
                              bool _result =
                                  await SessionManager.getBooleanData(
                                      IS_ROUTINE);
                              if (_result) {
                                Utilities.loading(context);
                                onClickFacebookLogin();
                              } else {
                                Navigator.of(context).push(
                                    CustomPageRoute(child: GuidlineView()));
                              }
                            },
                            width: MediaQuery.of(context).size.width / 1.4,
                            buttonText: AppStrings.continueWithFB,
                            buttonFontStyle: primaryMedium(
                                fontSize:
                                    MediaQuery.of(context).size.width < 385
                                        ? 09
                                        : textSmall)),
                      ),
                      commonSizedBox(paddingMedium + 6),
                      Platform.isIOS?CommonButton(
                          onPressed: () async {
                            bool _result =
                                await SessionManager.getBooleanData(IS_ROUTINE);
                            if (_result) {
                              Utilities.loading(context);
                              onClickAppleLogin();
                            } else {
                              Navigator.of(context)
                                  .push(CustomPageRoute(child: GuidlineView()));
                            }
                          },
                          width: MediaQuery.of(context).size.width / 1.4,
                          buttonText: AppStrings.continueWithApple,
                          buttonFontStyle: primaryMedium(
                              fontSize: MediaQuery.of(context).size.width < 385
                                  ? 09
                                  : textSmall)):Container(),
                      Platform.isIOS?commonSizedBox(paddingMedium * 4):commonSizedBox(paddingMedium),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteLoginView);
                        },
                        child: richTxt(),
                      ),
                      commonSizedBox(paddingSmall + 4),
                      commonSizedBox(paddingSmall + 4),
                      termText(),
                    ],
                  ),
                ),
              ),
              bottomLogo()
            ],
          ),
        );
      },
    );
  }

  termText() {
    return padding(
      commonPadding * 2,
      Text(
        AppStrings.termsText,
        style: TextStyle(
          color: Colors.blue[200],
          decorationColor: Colors.blue[200],
          decoration: TextDecoration.underline,
          fontFamily: FontNamelight,
          fontSize: MediaQuery.of(context).size.width < 385 ? 09 : textSmall,
        ),
      ),
    );
  }

  richTxt() {
    return RichText(
      text: new TextSpan(
        text: 'Have an account? ',
        style: primaryLight(),
        children: <TextSpan>[
          new TextSpan(
            text: 'Log in',
            style: TextStyle(
                fontSize: textSmall,
                fontFamily: FontNameRegular,
                color: Colors.blue[200]),
          )
        ],
      ),
    );
  }

  titleTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: commonPadding * 3),
      child: Text(
        "${globals.userName},your Montage journey is about to start",
        style: primaryLight(
          fontSize: textMedium,
        ),
        textAlign: TextAlign.center,
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

  @override
  void onConnectionError(String error, String requestCode) {
    Utilities.showError(scaffoldKey, error);
  }

  @override
  void onError(String errorMsg, String requestCode) {
    Utilities.showError(scaffoldKey, errorMsg);
  }

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    if (requestCode == RequestCode.SOCIAL_LOGIN) {
      Utilities.loading(context, status: false);
      SessionManager.setBooleanData(IS_LOGIN, true);
      debugPrint("" + object['_id']);
      SessionManager.setStringData(WebFields.USER_ID, object['_id']);
      SessionManager.setStringData('user_profile', jsonEncode(object));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => TabView(),
        ),
        (route) => false,
      );
    }
  }
}
