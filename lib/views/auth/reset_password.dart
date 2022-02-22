import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/customs/pin_code_fields.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/textfield_custom.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/utils/validate_types.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';

class ResetPasswordView extends StatefulWidget {
  ResetPasswordView({this.forgotId});
  final String forgotId;

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;

  final GlobalKey<TextFieldCustomState> currentPasswordState =
  GlobalKey<TextFieldCustomState>();
  TextEditingController currentPasswordController = TextEditingController();

  final GlobalKey<TextFieldCustomState> otpState =
  GlobalKey<TextFieldCustomState>();
  TextEditingController otpController = TextEditingController();

  final GlobalKey<TextFieldCustomState> newPasswordState =
  GlobalKey<TextFieldCustomState>();
  TextEditingController newPasswordController = TextEditingController();


  Widget build(BuildContext context) {
    return ResponsiveWidget(
        scaffoldKey: scaffoldKey,
        builder: (context, constraints) {
          return Container(
              decoration: BoxDecoration(gradient: lightgradientBG),
              // margin: EdgeInsets.only(top:paddingSmall*2),
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
                              top: paddingLarge * 1.5,
                              bottom: paddingLarge * 1.5),
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Utilities.commonSizedBox(paddingLarge * 2.5),
                              Text("Reset password",style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontNamelight,
                                fontSize: textLarge,
                              ),),
                              Utilities.commonSizedBox(paddingLarge * 2),
                              TextFieldCustom(
                                key: otpState,
                                controller: otpController,
                                hintText: 'Enter your 4 digits Otp',
                                validateTypes: ValidateTypes.empty,
                                maxLength:4,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 16.0,),
                              TextFieldCustom(
                                key: currentPasswordState,
                                controller: currentPasswordController,
                                hintText: AppStrings.currentPasswrod,
                                validateTypes: ValidateTypes.password,
                                textInputType: TextInputType.text,
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 16.0,),
                              TextFieldCustom(
                                key: newPasswordState,
                                controller: newPasswordController,
                                hintText: AppStrings.newPassword,
                                validateTypes: ValidateTypes.password,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                              ),
                              Utilities.commonSizedBox(paddingMedium * 2),
                              CommonButton(
                                buttonText: AppStrings.changePassword,
                                onPressed: () async{
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
                                    print(newPasswordController.text);
//                                    apiPresenter.doChangePassword(currentPasswordController.text, newPasswordController.text, id);
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
              ),);

        });
  }
}
