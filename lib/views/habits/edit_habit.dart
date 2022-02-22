import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
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

class EditHabitView extends StatefulWidget {
  final String id, title, desc;

  EditHabitView(this.id, this.title, this.desc);

  @override
  _EditHabitViewState createState() => _EditHabitViewState();
}

class _EditHabitViewState extends State<EditHabitView> implements ApiCallBacks {
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

  _EditHabitViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.desc;
    apiPresenter.habitListByHabitId(context, widget.id);

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
      title: 'Edit Habit',
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
              List<GoalUpdate> goal = List();

              goal.add(GoalUpdate(action1Controller.text.toString().trim(),
                  optionList[0]["status"], optionList[0]["_id"]));
              goal.add(GoalUpdate(action2Controller.text.toString().trim(),
                  optionList[1]["status"], optionList[1]["_id"]));
              goal.add(GoalUpdate(action3Controller.text.toString().trim(),
                  optionList[2]["status"], optionList[2]["_id"]));
              goal.add(GoalUpdate(action4Controller.text.toString().trim(),
                  optionList[3]["status"], optionList[3]["_id"]));

              Utilities.loading(context, status: true);

              var userId =
                  await SessionManager.getStringData(WebFields.USER_ID);

              var habit = Habit(userId, titleController.text.toString(),
                  descriptionController.text.toString());

              apiPresenter.editHabit(habit, goal, widget.id);
            }
          },
        )
      ],
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
    if (requestCode == RequestCode.HABIT_LIST_BY_HABIT_ID ||
        requestCode.contains(RequestCode.HABIT_LIST_BY_HABIT_ID)) {
      optionList.addAll(object);
      debugPrint(optionList.toString());

      if (optionList.length > 0) {
        action1Controller.text = optionList[0]["name"];
        action2Controller.text = optionList[1]["name"];
        action3Controller.text = optionList[2]["name"];
        action4Controller.text = optionList[3]["name"];
      }
      setState(() {});
    } else if (requestCode == RequestCode.HABIT ||
        requestCode.contains(RequestCode.HABIT)) {
      Utilities.loading(context, status: false);

      Toast.show('Update successfully ', context);

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
