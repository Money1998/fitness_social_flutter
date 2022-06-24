import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
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

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView>
    implements ApiCallBacks {
  ApiPresenter apiPresenter;

  _EditProfileViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<TextFieldCustomState> fullNameState =
      GlobalKey<TextFieldCustomState>();
  TextEditingController fullNameController = TextEditingController();

  final GlobalKey<TextFieldCustomState> bioState =
      GlobalKey<TextFieldCustomState>();
  TextEditingController bioController = TextEditingController();

  bool isLoading = false;
  var selectedGenderIndex = -1;
  var personTypeSelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    var id = await SessionManager.getStringData('userId');
    apiPresenter.getUserData(context, id);
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
              SubPageAppBar(
                title: 'Edit Profile',
              ),
              Expanded(
                child: KeyboardAvoider(
                  autoScroll: true,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          left: commonPadding * 2.5,
                          right: commonPadding * 2.5,
                          top: 0,
                          bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFieldCustom(
                            key: fullNameState,
                            controller: fullNameController,
                            hintText: 'Full name',
                            validateTypes: ValidateTypes.empty,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          Utilities.commonSizedBox(paddingMedium),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              genderFied(
                                  index: 1,
                                  gender: 'Male',
                                  icon: AssetsImage.maleIc),
                              SizedBox(width: 14.0),
                              genderFied(
                                  index: 2,
                                  gender: 'Female',
                                  icon: AssetsImage.femaleIc),
                              SizedBox(width: 14.0),
                              genderFied(
                                index: 3,
                                gender: 'Other',
                                icon: AssetsImage.otheIc,
                              ),
                            ],
                          ),
                          Utilities.commonSizedBox(paddingMedium),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              personTypeField(
                                  type: 'Owl',
                                  index: 1,
                                  icon: AssetsImage.owlIc),
                              SizedBox(width: 10.0),
                              personTypeField(
                                  type: 'Morning',
                                  index: 2,
                                  icon: AssetsImage.digitalClock),
                            ],
                          ),
                          Utilities.commonSizedBox(paddingMedium),
                          TextFieldCustom(
                            key: bioState,
                            controller: bioController,
                            hintText: 'Enter your bio',
                            validateTypes: ValidateTypes.empty,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          Utilities.commonSizedBox(paddingMedium * 2.8),
                          isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          colorBackground)))
                              : CommonButton(
                                  buttonText: 'Enter',
                                  onPressed: () async {
                                    var isValid = true;
                                    var id = await SessionManager.getStringData(
                                        'userId');
                                    if (fullNameState.currentState
                                        .checkValidation(false)) {
                                      isValid = false;
                                    }
                                    if (bioState.currentState
                                        .checkValidation(false)) {
                                      isValid = false;
                                    }

                                    if (isValid == true) {
                                      if (selectedGenderIndex == -1) {
                                        Utilities.showError(scaffoldKey,
                                            'Please select your gender');
                                      } else if (personTypeSelectedIndex ==
                                          -1) {
                                        Utilities.showError(scaffoldKey,
                                            'Please select your type');
                                      } else {
                                        var gender = selectedGenderIndex == 1
                                            ? 'Male'
                                            : selectedGenderIndex == 2
                                                ? 'Female'
                                                : 'Other';
                                        var personType =
                                            personTypeSelectedIndex == 1
                                                ? 'Owl'
                                                : 'Morning';
                                        apiPresenter.doUpdateProfile(
                                          fullNameController.text,
                                          gender,
                                          bioController.text,
                                          personType,
                                          id,
                                        );
                                      }
//                                _signUpClick();
                                    }
                                  },
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

  personTypeField({type, index, icon}) {
    return InkWell(
      onTap: () {
        setState(() {
          personTypeSelectedIndex = index;
        });
      },
      child: personTypeSelectedIndex == index
          ? CommonButton(
              backgroundColor: lightFonts,
              isleadIcon: true,
              leadIcon: icon,
              isRightArrow: false,
              width: MediaQuery.of(context).size.width / 2 - 38,
              buttonText: type,
            )
          : CommonButton(
              isleadIcon: true,
              leadIcon: icon,
              isRightArrow: false,
              width: MediaQuery.of(context).size.width / 2 - 38,
              buttonText: type,
            ),
    );
  }

  genderFied({
    index,
    gender,
    icon,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedGenderIndex = index;
        });
      },
      child: selectedGenderIndex == index
          ? CommonButton(
              backgroundColor: lightFonts,
              isleadIcon: true,
              leadIcon: icon,
              isRightArrow: false,
              width: MediaQuery.of(context).size.width / 3 - 32,
              buttonText: gender,
            )
          : CommonButton(
              isleadIcon: true,
              leadIcon: icon,
              isRightArrow: false,
              width: MediaQuery.of(context).size.width / 3 - 32,
              buttonText: gender,
            ),
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
      fullNameController.text = object['full_name'] ?? '';
      bioController.text = object['bio'] ?? '';
      selectedGenderIndex = object['gender'] == 'Male'
          ? 1
          : object['gender'] == 'Female'
              ? 2
              : 3;
      personTypeSelectedIndex = object['person_type'] == 'Morning' ? 2 : 1;
    });
  }
}
