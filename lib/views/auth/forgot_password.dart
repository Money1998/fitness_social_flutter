import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/textfield_custom.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/utils/validate_types.dart';
import 'package:montage/views/auth/reset_password.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';

class ForgoipasswordView extends StatefulWidget {
  @override
  _ForgoipasswordViewState createState() => _ForgoipasswordViewState();
}

class _ForgoipasswordViewState extends State<ForgoipasswordView> implements ApiCallBacks {

  ApiPresenter apiPresenter;
  _ForgoipasswordViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  final GlobalKey<TextFieldCustomState> emailState =
      GlobalKey<TextFieldCustomState>();

  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  padding(horizontal, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: widget,
    );
  }
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
       scaffoldKey: scaffoldKey,
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(gradient: lightgradientBG),
          // margin: EdgeInsets.only(top:paddingSmall*2),

          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.max,
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
                            subTitle(),
                          Utilities.commonSizedBox(paddingLarge * 2),
                          TextFieldCustom(
                            key: emailState,
                            controller: emailController,
                            hintText: AppStrings.email,
                            validateTypes: ValidateTypes.email,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          Utilities.commonSizedBox(paddingSmall * 2),
                        isLoading ? Center(child: CircularProgressIndicator(),): CommonButton(
                            buttonText: AppStrings.changePassword,
                            onPressed: () {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              var isValid = true;
                              if (emailState.currentState
                                  .checkValidation(false)) {
                                isValid = false;
                              }
                              if (isValid == true) {
                                setState(() {
                                  isLoading = true;
                                });
                                apiPresenter.doForgotpassword(emailController.text);
                              }
                            },
                          ),
                          Utilities.commonSizedBox(paddingMedium * 2),
                          Text(
                            "Back to",
                            style: TextStyle(
                              color: lightFonts,
                              fontFamily: FontNamelight,
                              fontSize: textSmall + 2,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, RouteLoginView);
                            },
                          child:Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: textSmall,
                              fontFamily: FontNameRegular,
                              color: Colors.blue[200],
                            ),
                          ),),
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
      commonPadding * 2,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          socialIcon(
            SvgImages.fb,
          ),
          socialIcon(
            SvgImages.googleIc,
          ),
          socialIcon(
            SvgImages.iosIc,
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
      'Forgot Password',
      style: primaryLight(fontSize: textMedium + 2),
    );
  }

  subTitle(){
    return Text(
      AppStrings.forgotPasswordSubtitle,
      style:primaryRegular(),
      textAlign:TextAlign.center,
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
      ],
    );
  }

  @override
  void onConnectionError(String error, String requestCode) {
    setState(() {
      isLoading = false;
      Utilities.showError(scaffoldKey, error);
    });
  }

  @override
  void onError(String errorMsg, String requestCode) {
    setState(() {
      isLoading = false;
      Utilities.showError(scaffoldKey, errorMsg);
    });
  }

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    setState(() {
      isLoading = false;
      Utilities.showSuccess(scaffoldKey, strMsg);
      Navigator.pushReplacementNamed(context, RouteLoginView);
    });
  }
}
