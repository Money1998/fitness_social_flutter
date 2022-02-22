import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/textfield_custom.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';

class EditGoalView extends StatefulWidget {
  @override
  _EditGoalViewState createState() => _EditGoalViewState();
}

class _EditGoalViewState extends State<EditGoalView> {
  TextEditingController stepController = TextEditingController();
  TextEditingController waterController = TextEditingController();

  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, constraints) {
      return 
      SafeArea(
      child:Container(
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
                    Utilities.commonSizedBox(paddingSmall * 2),
                    Text(
                      AppStrings.numberofStep,
                      style: onBackgroundRegular(fontSize: textSmall + 2),
                    ),
                    Utilities.commonSizedBox(paddingSmall),
                    TextFieldCustom(
                      controller: stepController,
                      hintText: 'Number of steps',
                      inputBorderColor: colorTheme,
                      inputBoxTextStyle:
                          onBackgroundRegular(fontSize: textSmall + 2),
                      textInputType: TextInputType.number,
                      errorTextStyle: errorTextRegular(),
                      inputFormat: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
                    Utilities.commonSizedBox(paddingSmall + 4),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Water intakes (based by activity):",
                            style: onBackgroundRegular(fontSize: textSmall + 2),
                          ),
                        ),
                        SizedBox(
                          width: paddingSmall,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3.2,
                          child: TextFieldCustom(
                            controller: waterController,
                            hintText: 'Water intakes',
                            inputBorderColor: colorTheme,
                            inputBoxTextStyle:
                                onBackgroundRegular(fontSize: textSmall + 2),
                            errorTextStyle: errorTextRegular(),
                          ),
                        ),
                      ],
                    ),
                    Utilities.commonSizedBox(paddingMedium * 2),
                    InkWell(
                      onTap: () {
                        setState(() {
                          checked = !checked;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline,
                              size: smallIconSize * 2,
                              color: checked == true
                                  ? colorTheme
                                  : colorOnBackgroundLight),
                          SizedBox(
                            width: paddingSmall,
                          ),
                          Text(
                            AppStrings.unalbePushNotification,
                            style: onBackgroundMedium(
                              fontSize: textSmall + 2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Utilities.commonSizedBox(paddingLarge * 2),
                    Divider(
                      color: dividerColor,
                      thickness: 1.5,
                    ),
                    Utilities.commonSizedBox(paddingMedium * 2),
                    deleteButton()
                    
                  ],
                ),
              ),
            )),
          ],
        ),
      ),);
    });
  }

  appBar() {
    return SubPageAppBar(
      title: AppStrings.editGoal,
      actionIcons: [
        Row(
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
                  Text(
                    'DELETE GOAL',
                    style: themeFontRegular(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
