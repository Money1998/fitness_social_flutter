import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';
import 'package:http/http.dart' as http;
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

  // final facebookLogin = FacebookLogin();

  onClickFacebookLogin() async {
    /*facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    if (await facebookLogin.isLoggedIn) {
      facebookLogin.logOut();
    }
    final FacebookLoginResult result =
        await facebookLogin.logIn(["email", "public_profile"]);
    print(result);
    switch (result.status) {
      case FacebookLoginStatus.error:
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.loggedIn:
        Utilities.loading(context);
        var graphResponse = await http.get(
            "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${result.accessToken.token}");
        var profile = json.decode(graphResponse.body);
        print(profile);
        var email = '';
        var profileUrl = '';
        try {
          email = profile['email'];
        } catch (error) {}
        try {
          profileUrl = profile['picture']['data']['url'];
        } catch (error) {}
        apiPresenter.doSocialLogin('Facebook', profile['id'], profile['name'],
            email, profileUrl, context);
    }*/

    FacebookAuth.instance
        .login(loginBehavior: LoginBehavior.dialogOnly)
        .then((token) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(token.accessToken.token);
      FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((userCredential) {
        print("Login Details : ${userCredential.user.uid}");
        print("Login Details : ${userCredential.user.displayName}");
        print("Login Details : ${userCredential.user.email}");
        print("Login Details : ${userCredential.user.photoURL}");

        apiPresenter.doSocialLogin(
            'Facebook',
            userCredential.user.uid,
            userCredential.user.displayName,
            userCredential.user.email ?? "",
            userCredential.user.photoURL ?? "",
            context);
      });
    }).onError((error, stackTrace) {
      print("error + ${error.message}");
      Utilities.loading(context, status: false);
    });
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

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      scaffoldKey: scaffoldKey,
      builder: (context, constraints) {
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
                        width: MediaQuery.of(context).size.width / 1.4,
                        buttonText: AppStrings.signupWithEmail,
                        onPressed: () {
                          Navigator.pushNamed(context, RouteSignupView);
                        },
                      ),
                      commonSizedBox(paddingMedium + 6),
                      CommonButton(
                        onPressed: () async {
                          bool _result =
                              await SessionManager.getBooleanData(IS_ROUTINE);
                          if (_result) {
                            Utilities.loading(context);
                            onClickFacebookLogin();
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GuidlineView()));
                          }
                        },
                        width: MediaQuery.of(context).size.width / 1.4,
                        buttonText: AppStrings.continueWithFB,
                      ),
                      commonSizedBox(paddingMedium * 2),
                      CommonButton(
                        onPressed: () async {
                          bool _result =
                              await SessionManager.getBooleanData(IS_ROUTINE);
                          if (_result) {
                            Utilities.loading(context);
                            onClickAppleLogin();
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GuidlineView()));
                          }
                        },
                        width: MediaQuery.of(context).size.width / 1.4,
                        buttonText: AppStrings.continueWithApple,
                      ),
                      commonSizedBox(paddingMedium * 2),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteLoginView);
                        },
                        child: richTxt(),
                      ),
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
          color: lightFonts,
          fontFamily: FontNamelight,
          fontSize: textSmall,
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
        AppStrings.guidline03Titl,
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
