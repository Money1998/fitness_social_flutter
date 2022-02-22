import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/habits/detail_habit.dart';
import 'package:montage/views/habits/edit_habit.dart';

class HabitsView extends StatefulWidget {
  @override
  _HabitsViewState createState() => _HabitsViewState();
}

class _HabitsViewState extends State<HabitsView> implements ApiCallBacks {
  ApiPresenter apiPresenter;

  var selectedIndex = -1;

  var habitList = [];

  _HabitsViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  @override
  void initState() {
    apiPresenter.habitListByUserId(context);
    super.initState();
  }

  var selectedList = [];

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, constraints) {
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor("#F8E5FF"),
                HexColor("#F8E5FF"),
                HexColor("#F8E5FF"),
                HexColor("#A35CC4"),
                HexColor("#400B65"),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    color: colorBackground,
                    padding: EdgeInsets.only(
                      top: paddingSmall + 4,
                      bottom: paddingSmall + 4,
                      left: commonPadding,
                      right: commonPadding,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    SvgImages.subPageBackArrowIc,
                                    height: iconSize - 4,
                                    width: iconSize - 4,
                                  ),
                                ),
                                SizedBox(
                                  width: paddingSmall * 2,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(paddingSmall),
                        margin: EdgeInsets.only(
                          left: commonPadding,
                          right: commonPadding,
                          bottom: paddingLarge * 4,
                        ),
                        decoration: BoxDecoration(
                            color: colorBackground,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [BoxShadow(color: Colors.black45)]),
                        child: habitList.length == 0
                            ? Center(
                                child: InkWell(
                                  child: Text("No Habit Found"),
                                  onTap: () {
                                    Navigator.pushNamed(
                                            context, RouteEditHabitView)
                                        .then((value) => {
                                              apiPresenter
                                                  .habitListByUserId(context)
                                            });
                                  },
                                ),
                              )
                            : ListView.builder(
                                itemCount: habitList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          richText(habitList[index]['goal']),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditHabitView(
                                                              habitList[index]
                                                                  ['_id'],
                                                              habitList[index]
                                                                  ['title'],
                                                              habitList[index]
                                                                  ['desc'])))
                                                  .then((value) => {
                                                        apiPresenter
                                                            .habitListByUserId(
                                                                context),
                                                        habitList.clear()
                                                      });
                                            },
                                            child: SvgPicture.asset(
                                              SvgImages.editIc,
                                              height: smallIconSize * 1.5,
                                              width: smallIconSize * 1.5,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Utilities.loading(context,
                                                  status: true);
                                              apiPresenter.deleteHabit(context,
                                                  habitList[index]['_id']);
                                            },
                                            child: SvgPicture.asset(
                                              SvgImages.deleteIc,
                                              height: smallIconSize * 1.5,
                                              width: smallIconSize * 1.5,
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: dividerColor,
                                        thickness: 0.7,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        child: ListTile(
                                          title:
                                              Text(habitList[index]["title"]),
                                          subtitle:
                                              Text(habitList[index]["desc"]),
                                        ),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailHabitView(
                                                          habitList[index]
                                                              ['_id'],
                                                          habitList[index]
                                                              ['title'],
                                                          habitList[index]
                                                              ['desc'])))
                                              .then((value) => {
                                                    apiPresenter
                                                        .habitListByUserId(
                                                            context),
                                                    habitList.clear()
                                                  });
                                        },
                                      )
                                    ],
                                  );
                                },
                              )),
                  ]),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: InkWell(
                      child: Center(
                          child: Text(
                        "Add Habit",
                        style: TextStyle(color: Colors.white),
                      )),
                      onTap: () {
                        Navigator.pushNamed(context, RouteEditHabitView).then(
                            (value) => {
                                  apiPresenter.habitListByUserId(context),
                                  habitList.clear()
                                });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  richText(String goal) {
    return RichText(
      text: new TextSpan(
        text: 'GOAL: ',
        style: commontextStyle(
          color: lightThemeFonts,
          fontSize: textSmall,
          fontFamily: FontNameRegular,
        ),
        children: <TextSpan>[
          new TextSpan(
              text: goal,
              style: themeFontSemiBold(
                fontSize: textSmall,
              ))
        ],
      ),
    );
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {}

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    if (requestCode == RequestCode.HABIT_LIST_BY_USERID ||
        requestCode.contains(RequestCode.HABIT_LIST_BY_USERID)) {
      habitList.addAll(object);
      debugPrint(habitList.toString());
      setState(() {});
    } else {
      Utilities.loading(context, status: false);

      apiPresenter.habitListByUserId(context);
      habitList.clear();
    }
  }
}
