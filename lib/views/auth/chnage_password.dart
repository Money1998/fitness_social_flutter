import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/textfield_custom.dart';
import 'package:montage/model/track_detail.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/utils/validate_types.dart';
import 'package:montage/views/auth/login_view.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> implements ApiCallBacks  {
  ApiPresenter apiPresenter;
  _ChangePasswordState() {
    apiPresenter = new ApiPresenter(this);
  }
  Users user;
  final GlobalKey<TextFieldCustomState> currentPasswordState =
  GlobalKey<TextFieldCustomState>();
  TextEditingController currentPasswordController = TextEditingController();

  final GlobalKey<TextFieldCustomState> newPasswordState =
  GlobalKey<TextFieldCustomState>();
  TextEditingController newPasswordController = TextEditingController();

  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
       scaffoldKey:scaffoldKey ,
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
                          top: paddingLarge * 1.5,
                          bottom: paddingLarge * 1.5),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Utilities.commonSizedBox(paddingLarge * 2.5),
                          Text("Change password",style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontNamelight,
                            fontSize: textLarge,
                          ),),
                          Utilities.commonSizedBox(paddingLarge * 2),

                          TextFieldCustom(
                            key: currentPasswordState,
                            controller: currentPasswordController,
                            hintText: AppStrings.currentPasswrod,
                            validateTypes: ValidateTypes.password,
                            textInputType: TextInputType.text,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 10.0,),
                          TextFieldCustom(
                            key: newPasswordState,
                            controller: newPasswordController,
                            hintText: AppStrings.newPassword,
                            validateTypes: ValidateTypes.password,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                          ),
                          Utilities.commonSizedBox(paddingSmall * 2),
                     isLoading ? Center(child: CircularProgressIndicator(),) : CommonButton(
                            buttonText: AppStrings.changePassword,
                            onPressed: () async{
                              setState(() {
                                isLoading = true;
                              });
                              var isValid = true;
                              if (currentPasswordState.currentState
                                  .checkValidation(false)) {
                                isValid = false;
                              }
                              if(newPasswordState.currentState.checkValidation(false)){
                                isValid = false;
                              }

                              if (isValid == true) {
                                var id  = await SessionManager.getStringData('userId');

                                apiPresenter.doChangePassword(currentPasswordController.text, newPasswordController.text, id);
                              }
                            },
                          ),
                          Utilities.commonSizedBox(paddingMedium * 2),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Back ",
                              style: TextStyle(
                                color: lightFonts,
                                fontFamily: FontNamelight,
                                fontSize: textMedium,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
      SessionManager.setBooleanData(IS_ROUTINE, false);
      SessionManager.removeString(IS_LOGIN);
      SessionManager.removeString(
          'user_profile');
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginView()),
              (Route<dynamic> route) => route is LoginView);
      Utilities.showSuccess(scaffoldKey, strMsg);
    });
  }
}
