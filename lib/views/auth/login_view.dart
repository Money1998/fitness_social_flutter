import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/custom_page_route.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/textfield_custom.dart';
import 'package:montage/model/user_model.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/utils/validate_types.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';
import 'package:montage/views/home/tab_view.dart';
import 'package:montage/customs/global_var.dart' as globals;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:toast/toast.dart';
import 'dart:io' show Platform;

import 'guidline_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements ApiCallBacks {
  ApiPresenter apiPresenter;
  final fb = FacebookLogin();

  _LoginViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<TextFieldCustomState> emailState =
      GlobalKey<TextFieldCustomState>();
  final GlobalKey<TextFieldCustomState> passwordState =
      GlobalKey<TextFieldCustomState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  padding(horizontal, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: widget,
    );
  }

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
    return ResponsiveWidget(
      scaffoldKey: scaffoldKey,
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(gradient: lightgradientBG),
          child: Column(
            children: [
              Expanded(
                child: KeyboardAvoider(
                  autoScroll: true,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          left: commonPadding * 2.5,
                          right: commonPadding * 2.5,
                          top: paddingLarge * 3,
                          bottom: paddingLarge * 1.5),
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Utilities.commonSizedBox(paddingLarge * 2.5),
                          title(),
                          Utilities.commonSizedBox(paddingLarge * 2),
                          TextFieldCustom(
                            key: emailState,
                            controller: emailController,
                            hintText: AppStrings.email,
                            validateTypes: ValidateTypes.email,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          Utilities.commonSizedBox(paddingSmall),
                          TextFieldCustom(
                            key: passwordState,
                            controller: passwordController,
                            hintText: AppStrings.passowrd,
                            validateTypes: ValidateTypes.password,
                            obscureText: true,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          Utilities.commonSizedBox(paddingVerySmall),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteForgotPasswordView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(AppStrings.forgotPass,
                                    style: primaryLight())
                              ],
                            ),
                          ),
                          Utilities.commonSizedBox(paddingLarge * 2),
                          isLoading == true
                              ? Utilities.loader()
                              : CommonButton(
                                  buttonText: AppStrings.enter,
                                  onPressed: () {
                                    var isValid = true;
                                    if (emailState.currentState
                                        .checkValidation(false)) {
                                      isValid = false;
                                    }
                                    if (passwordState.currentState
                                        .checkValidation(false)) {
                                      isValid = false;
                                    }
                                    if (isValid == true) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      apiPresenter.doLogin(emailController.text,
                                          passwordController.text, context);
                                    }
                                  },
                                ),
                          Utilities.commonSizedBox(paddingLarge * 2),
                          loginWithText(),
                          Utilities.commonSizedBox(paddingMedium * 2),
                          socialLogin(),
                          Utilities.commonSizedBox(paddingLarge * 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottomLogo(),
              Utilities.commonSizedBox(
                paddingSmall + 4,
              ),
            ],
          ),
        );
      },
    );
  }

  socialLogin() {
    return padding(
      commonPadding * 3,
      Platform.isIOS
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Visibility(
                  visible: true,
                  child: InkWell(
                    onTap: () async {
                      //Signup Blank issue
                      bool _result =
                          await SessionManager.getBooleanData(IS_ROUTINE);
                      if (_result) {
                        Utilities.loading(context);
                        await onClickFacebookLogin();
                      } else {
                        Navigator.of(context)
                            .push(CustomPageRoute(child: GuidlineView()));
                      }
                    },
                    child: socialIcon(
                      SvgImages.fb,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    bool _result =
                        await SessionManager.getBooleanData(IS_ROUTINE);
                    if (_result) {
                      Utilities.loading(context);
                      await onClickGoogleLogin();
                      Utilities.loading(context, status: false);
                    } else {
                      Navigator.of(context)
                          .push(CustomPageRoute(child: GuidlineView()));
                    }
                  },
                  child: socialIcon(
                    SvgImages.googleIc,
                  ),
                ),
                // socialIcon(
                //   SvgImages.iosIc,
                // ),
                InkWell(
                  child: Image.asset(
                    AssetsImage.appleIc,
                    height: iconSize * 1.5,
                    width: iconSize * 1.5,
                  ),
                  onTap: () async {
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
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Visibility(
                  visible: true,
                  child: InkWell(
                    onTap: () async {
                      //Signup Blank issue
                      bool _result =
                          await SessionManager.getBooleanData(IS_ROUTINE);
                      if (_result) {
                        Utilities.loading(context);
                        await onClickFacebookLogin();
                      } else {
                        Navigator.of(context)
                            .push(CustomPageRoute(child: GuidlineView()));
                      }
                    },
                    child: socialIcon(
                      SvgImages.fb,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    //Signup Blank issue
                    bool _result =
                        await SessionManager.getBooleanData(IS_ROUTINE);
                    if (_result) {
                      await onClickGoogleLogin();
                      Utilities.loading(context, status: false);
                    } else {
                      Navigator.of(context)
                          .push(CustomPageRoute(child: GuidlineView()));
                    }
                  },
                  child: socialIcon(
                    SvgImages.googleIc,
                  ),
                ),
              ],
            ),
    );
  }

  socialIcon(icon) {
    return SvgPicture.asset(
      icon,
      height: iconSize * 1.5,
      width: iconSize * 1.5,
    );
  }

  loginWithText() {
    return padding(
      commonPadding * 2,
      Text(
        AppStrings.orLoginWith,
        style: TextStyle(
          color: lightFonts,
          fontFamily: FontNamelight,
          fontSize: textSmall + 2,
        ),
      ),
    );
  }

  title() {
    return Text(
      AppStrings.login,
      style: primaryLight(fontSize: textMedium + 2),
    );
  }

  bottomLogo() {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Text(
            "Don\'t have an account?",
            style: TextStyle(
              color: lightFonts,
              fontFamily: FontNameRegular,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            //Signup Blank issue
            bool _result = await SessionManager.getBooleanData(IS_ROUTINE);
            if (_result) {
              Navigator.pushReplacementNamed(context, RouteSignupView);
            } else {
              Navigator.of(context)
                  .push(CustomPageRoute(child: GuidlineView()));
            }
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: textSmall,
              fontFamily: FontNameRegular,
              color: Colors.blue[200],
            ),
          ),
        ),
        Utilities.commonSizedBox(paddingSmall * 2),
        CircleAvatar(
          radius: 28.0,
          backgroundColor: colorBackground,
          child: Image.asset(
            AssetsImage.logo,
            height: smallIconSize * 2.5,
            width: smallIconSize * 2.5,
          ),
        ),
      ],
    );
  }

  @override
  void onConnectionError(String error, String requestCode) {
    setState(() {
      isLoading = false;
      Utilities.loading(context, status: false);
      Utilities.showError(scaffoldKey, error);
    });
  }

  @override
  void onError(String errorMsg, String requestCode) {
    setState(() {
      isLoading = false;
      Utilities.loading(context, status: false);
      Utilities.showError(scaffoldKey, errorMsg);
    });
  }

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    setState(() {
      isLoading = false;
      if (requestCode == RequestCode.LOGIN) {
        // // User user = (User.fromJson(object['userDetail']));
        // AppUser user = AppUser.f
        print(object['_id']);
        print("USER OBJECT");
        // _apiPresenter.saveLoginResult(user);
        SessionManager.setBooleanData(IS_LOGIN, true);
        SessionManager.setStringData('user_profile', jsonEncode(object));
        SessionManager.setStringData(WebFields.USER_ID, object['_id']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TabView(),
          ),
          (route) => false,
        );
      } else if (requestCode == RequestCode.SOCIAL_LOGIN) {
        print(object);
        print("DATA LKJFDKL");
        Utilities.loading(context, status: false);
        AppUser user = (AppUser.fromJson(object));
        apiPresenter.saveLoginResult(user);
        SessionManager.setBooleanData(IS_LOGIN, true);
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
    });
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount> login() => _googleSignIn.signIn();
}
