import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/textfield_custom.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/utils/validate_types.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';
import 'package:montage/customs/global_var.dart' as globals;
import 'package:montage/views/home/tab_view.dart';
import 'package:http/http.dart' as http;

// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'dart:io' show Platform;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> implements ApiCallBacks {
  ApiPresenter _apiPresenter;

  // final facebookLogin = FacebookLogin();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;

  _SignupViewState() {
    _apiPresenter = new ApiPresenter(this);
  }

  final GlobalKey<TextFieldCustomState> emailState =
      GlobalKey<TextFieldCustomState>();
  final GlobalKey<TextFieldCustomState> confirmEmailState =
      GlobalKey<TextFieldCustomState>();
  final GlobalKey<TextFieldCustomState> passwordState =
      GlobalKey<TextFieldCustomState>();
  final GlobalKey<TextFieldCustomState> confirmPasswordState =
      GlobalKey<TextFieldCustomState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  padding(horizontal, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: widget,
    );
  }

  _signUpClick() {
    if (passwordState.currentState.getText() !=
        confirmPasswordState.currentState.getText()) {
      confirmPasswordState.currentState.setError("Password must be matched");
    } else if (emailState.currentState.getText() !=
        confirmEmailState.currentState.getText()) {
      confirmEmailState.currentState
          .setError("Email & Confirm email must be matched");
    } else {
      setState(() {
        isLoading = true;
      });
      _apiPresenter.doSignup(globals.userName, emailController.text,
          passwordController.text, context);
    }
  }

  onClickFacebookLogin() async {
    print("Signup View FB Login");
    /*facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    if (await facebookLogin.isLoggedIn) {
      facebookLogin.logOut();
    }
    final FacebookLoginResult result =
        await facebookLogin.logIn(["email", "public_profile"]);
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
        print(profile['name'] + profile['id']);
        print('Facebook Login');
        var email = '';
        var profileUrl = '';
        try {
          email = profile['email'];
        } catch (error) {}
        try {
          profileUrl = profile['picture']['data']['url'];
        } catch (error) {}
        _apiPresenter.doSocialLogin('Facebook', profile['id'], profile['name'],
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


        _apiPresenter.doSocialLogin(
            'Facebook',
            userCredential.user.uid,
            userCredential.user.displayName,
            userCredential.user.email ?? "",
            userCredential.user.photoURL ?? "",
            context);
      });
    }).onError((error, stackTrace) {
      print("error + ${error.message}");
    });
  }

  onClickGoogleLogin() async {
    try {
      final GoogleSignInAccount googleAccountUser =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleAccountUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential.user);
      _apiPresenter.doSocialLogin(
          'Google',
          userCredential.user.uid,
          userCredential.user.displayName,
          userCredential.user.email,
          userCredential.user.photoURL,
          context);
    } catch (error) {
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
      _apiPresenter.doSocialLogin(
          'Apple', credential.userIdentifier, name, email, '', context);
    } catch (error) {
      print(error);
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
                            key: confirmEmailState,
                            controller: confirmEmailController,
                            hintText: AppStrings.confirmEmail,
                            validateTypes: ValidateTypes.email,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          Utilities.commonSizedBox(paddingMedium * 2),
                          TextFieldCustom(
                            key: passwordState,
                            controller: passwordController,
                            hintText: AppStrings.passowrd,
                            validateTypes: ValidateTypes.password,
                            obscureText: true,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          Utilities.commonSizedBox(paddingSmall),
                          TextFieldCustom(
                            key: confirmPasswordState,
                            controller: confirmPasswordController,
                            hintText: AppStrings.confirmPassword,
                            validateTypes: ValidateTypes.password,
                            obscureText: true,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          ),
                          Utilities.commonSizedBox(paddingMedium * 2.5),
                          isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          colorBackground)))
                              : CommonButton(
                                  buttonText: AppStrings.enter,
                                  onPressed: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    var isValid = true;
                                    if (emailState.currentState
                                        .checkValidation(false)) {
                                      isValid = false;
                                    }
                                    if (confirmEmailState.currentState
                                        .checkValidation(false)) {
                                      isValid = false;
                                    }
                                    if (passwordState.currentState
                                        .checkValidation(false)) {
                                      isValid = false;
                                    }
                                    if (confirmPasswordState.currentState
                                        .checkValidation(false)) {
                                      isValid = false;
                                    }
                                    if (isValid == true) {
                                      _signUpClick();
                                    }
                                  },
                                ),
                          Utilities.commonSizedBox(paddingMedium * 2),
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
              bottomLogo()
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
              children: [
                InkWell(
                  onTap: () {
                    Utilities.loading(context);
                    onClickFacebookLogin();
                  },
                  child: socialIcon(
                    SvgImages.fb,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Utilities.loading(context);
                    onClickGoogleLogin();
                  },
                  child: socialIcon(
                    SvgImages.googleIc,
                  ),
                ),
                InkWell(
                  child: Image.asset(
                    AssetsImage.appleIc,
                    height: iconSize * 1.5,
                    width: iconSize * 1.5,
                  ),
                  onTap: () async {
                    Utilities.loading(context);
                    onClickAppleLogin();
                  },
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Utilities.loading(context);
                    onClickFacebookLogin();
                  },
                  child: socialIcon(
                    SvgImages.fb,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Utilities.loading(context);
                    onClickGoogleLogin();
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
      AppStrings.signup,
      style: primaryLight(fontSize: textMedium + 2),
    );
  }

  bottomLogo() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteLoginView);
          },
          child: Text(
            "Already have an account?",
            style: TextStyle(
              color: lightFonts,
              fontFamily: FontNameRegular,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, RouteLoginView);
          },
          child: Text(
            'Login',
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
        SizedBox(
          height: paddingSmall * 2,
        ),
      ],
    );
  }

  @override
  void onConnectionError(String error, String requestCode) {
    setState(() {
      isLoading = false;
    });
    Utilities.showError(scaffoldKey, error);
  }

  @override
  void onError(String errorMsg, String requestCode) {
    setState(() {
      isLoading = false;
    });
    Utilities.showError(scaffoldKey, errorMsg);
  }

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    setState(() {
      isLoading = false;
      if (requestCode == RequestCode.SIGN_UP) {
        SessionManager.setBooleanData(IS_LOGIN, true);
        SessionManager.setStringData('user_profile', jsonEncode(object));
        SessionManager.setStringData(WebFields.USER_ID, object['_id']);
        /*Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TabView(),
          ),
          (route) => false,
        );*/
        Navigator.pushNamed(context, RouteWelcomeView);

      } else if (requestCode == RequestCode.SOCIAL_LOGIN) {
        Utilities.loading(context, status: false);
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
      }
    });
  }
}