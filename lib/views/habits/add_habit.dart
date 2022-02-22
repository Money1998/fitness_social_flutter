import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/textfield_custom.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:toast/toast.dart';

import 'habit_pojo.dart';

class AddHabitView extends StatefulWidget {
  @override
  _AddHabitViewState createState() => _AddHabitViewState();
}

class _AddHabitViewState extends State<AddHabitView> implements ApiCallBacks {
  ApiPresenter apiPresenter;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<TextFieldCustomState> titleState =
      GlobalKey<TextFieldCustomState>();

  final GlobalKey<TextFieldCustomState> descriptionState =
      GlobalKey<TextFieldCustomState>();

  TextEditingController action1Controller = TextEditingController();
  TextEditingController action2Controller = TextEditingController();
  TextEditingController action3Controller = TextEditingController();
  TextEditingController action4Controller = TextEditingController();

  final GlobalKey<TextFieldCustomState> action1 =
      GlobalKey<TextFieldCustomState>();

  final GlobalKey<TextFieldCustomState> action2 =
      GlobalKey<TextFieldCustomState>();

  final GlobalKey<TextFieldCustomState> action3 =
      GlobalKey<TextFieldCustomState>();

  final GlobalKey<TextFieldCustomState> action4 =
      GlobalKey<TextFieldCustomState>();

  bool checked = false;
  var optionList = [];

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  _AddHabitViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  @override
  void initState() {
    optionList.addAll(
      [
        {
          'name': '',
          'status': "Pending",
        },
        {
          'name': '',
          'status': "Pending",
        },
        {
          'name': '',
          'status': "Pending",
        },
        {
          'name': '',
          'status': "Pending",
        }
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        scaffoldKey: scaffoldKey,
        builder: (context, constraints) {
          return SafeArea(
            child: Container(
              color: colorBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  appBar(),
                  Expanded(
                      child: KeyboardAvoider(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: commonPadding,
                        right: commonPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Utilities.commonSizedBox(paddingMedium),
                          Text(
                            'Title',
                            style: onBackgroundRegular(fontSize: textSmall + 2),
                          ),
                          Utilities.commonSizedBox(paddingSmall),
                          TextFieldCustom(
                              key: titleState,
                              controller: titleController,
                              hintText: '',
                              inputBorderColor: colorTheme,
                              inputBoxTextStyle:
                                  onBackgroundRegular(fontSize: textSmall + 2),
                              textInputType: TextInputType.text,
                              errorTextStyle: errorTextRegular()),
                          Utilities.commonSizedBox(paddingMedium),
                          Text(
                            'Description',
                            style: onBackgroundRegular(fontSize: textSmall + 2),
                          ),
                          Utilities.commonSizedBox(paddingSmall),
                          TextFieldCustom(
                              key: descriptionState,
                              controller: descriptionController,
                              hintText: '',
                              inputBorderColor: colorTheme,
                              inputBoxTextStyle:
                                  onBackgroundRegular(fontSize: textSmall + 2),
                              textInputType: TextInputType.text,
                              errorTextStyle: errorTextRegular()),
                          Utilities.commonSizedBox(paddingMedium),

                          Utilities.commonSizedBox(paddingMedium),
                          Text(
                            'Action',
                            style: onBackgroundRegular(fontSize: textSmall + 2),
                          ),
                          Utilities.commonSizedBox(paddingSmall),
                          TextFieldCustom(
                              key: action1,
                              controller: action1Controller,
                              hintText: '',
                              inputBorderColor: colorTheme,
                              inputBoxTextStyle:
                                  onBackgroundRegular(fontSize: textSmall + 2),
                              textInputType: TextInputType.text,
                              errorTextStyle: errorTextRegular()),
                          Utilities.commonSizedBox(paddingMedium),
                          Utilities.commonSizedBox(paddingMedium),
                          Text(
                            'Action',
                            style: onBackgroundRegular(fontSize: textSmall + 2),
                          ),
                          Utilities.commonSizedBox(paddingSmall),
                          TextFieldCustom(
                              key: action2,
                              controller: action2Controller,
                              hintText: '',
                              inputBorderColor: colorTheme,
                              inputBoxTextStyle:
                                  onBackgroundRegular(fontSize: textSmall + 2),
                              textInputType: TextInputType.text,
                              errorTextStyle: errorTextRegular()),
                          Utilities.commonSizedBox(paddingMedium),
                          Utilities.commonSizedBox(paddingMedium),
                          Text(
                            'Action',
                            style: onBackgroundRegular(fontSize: textSmall + 2),
                          ),
                          Utilities.commonSizedBox(paddingSmall),
                          TextFieldCustom(
                              key: action3,
                              controller: action3Controller,
                              hintText: '',
                              inputBorderColor: colorTheme,
                              inputBoxTextStyle:
                                  onBackgroundRegular(fontSize: textSmall + 2),
                              textInputType: TextInputType.text,
                              errorTextStyle: errorTextRegular()),
                          Utilities.commonSizedBox(paddingMedium),
                          Utilities.commonSizedBox(paddingMedium),
                          Text(
                            'Action',
                            style: onBackgroundRegular(fontSize: textSmall + 2),
                          ),
                          Utilities.commonSizedBox(paddingSmall),
                          TextFieldCustom(
                              key: action4,
                              controller: action4Controller,
                              hintText: '',
                              inputBorderColor: colorTheme,
                              inputBoxTextStyle:
                                  onBackgroundRegular(fontSize: textSmall + 2),
                              textInputType: TextInputType.text,
                              errorTextStyle: errorTextRegular()),
                          Utilities.commonSizedBox(paddingMedium),

                          Utilities.commonSizedBox(paddingMedium * 2),
                          Divider(
                            color: dividerColor,
                            thickness: 1.5,
                          ),
                          Utilities.commonSizedBox(paddingMedium * 2),
                          // deleteButton()
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          );
        });
  }

  appBar() {
    return SubPageAppBar(
      title: 'Add Habit',
      actionIcons: [
        InkWell(
          child: Row(
            children: [
              Text(
                "SAVE",
                style: themeFontRegular(),
              ),
              SizedBox(
                width: paddingVerySmall / 2,
              ),
              Icon(
                Icons.check,
                color: colorTheme,
                size: smallIconSize,
              )
            ],
          ),
          onTap: () async {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            debugPrint(titleController.text.toString());
            debugPrint(descriptionController.text.toString());

            var isValid = true;
            if (titleState.currentState.checkValidation(false)) {
              isValid = false;
            }
            if (descriptionState.currentState.checkValidation(false)) {
              isValid = false;
            }

            if (action1.currentState.checkValidation(false)) {
              isValid = false;
            }

            if (action2.currentState.checkValidation(false)) {
              isValid = false;
            }
            if (action3.currentState.checkValidation(false)) {
              isValid = false;
            }

            if (action4.currentState.checkValidation(false)) {
              isValid = false;
            }

            if (isValid == true) {
              List<Goals> goal = List();

              goal.add(
                  Goals(action1Controller.text.toString().trim(), "Pending"));
              goal.add(
                  Goals(action2Controller.text.toString().trim(), "Pending"));
              goal.add(
                  Goals(action3Controller.text.toString().trim(), "Pending"));
              goal.add(
                  Goals(action4Controller.text.toString().trim(), "Pending"));

              Utilities.loading(context, status: true);

              var userId =
                  await SessionManager.getStringData(WebFields.USER_ID);

              var habit = Habit(userId, titleController.text.toString(),
                  descriptionController.text.toString());

              apiPresenter.addHabit(habit, goal);
            }
          },
        )
      ],
    );
  }

  deleteButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: colorTheme, width: 0.6),
        ),
        padding: EdgeInsets.only(
          top: paddingMedium - 2,
          bottom: paddingMedium - 2,
          left: paddingLarge,
          right: paddingLarge,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              SvgImages.deleteIc,
              height: iconSize,
              width: iconSize,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Text(
                      'Add action',
                      style: themeFontRegular(),
                    ),
                    onTap: () {
                      optionList.add(["ff", "ff"]);
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {
    Utilities.loading(context, status: false);
    Utilities.showError(scaffoldKey, errorMsg);
  }

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    if (requestCode == RequestCode.HABIT ||
        requestCode.contains(RequestCode.HABIT)) {
      Toast.show('Added successfully ', context);
      Utilities.loading(context, status: false);
      Timer(Duration(seconds: 1), () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
      });
    }
  }
}
