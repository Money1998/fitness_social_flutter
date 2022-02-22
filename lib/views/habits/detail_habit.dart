import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';

class DetailHabitView extends StatefulWidget {
  final String id, title, desc;

  DetailHabitView(this.id, this.title, this.desc);

  @override
  _DetailHabitViewState createState() => _DetailHabitViewState();
}

class _DetailHabitViewState extends State<DetailHabitView>
    implements ApiCallBacks {
  ApiPresenter apiPresenter;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool checked = false;
  var optionList = [];

  _DetailHabitViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  @override
  void initState() {
    apiPresenter.habitListByHabitId(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, constraints) {
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
                        widget.title,
                        style: onBackgroundRegular(fontSize: textSmall + 2),
                      ),
                      Utilities.commonSizedBox(paddingMedium),
                      Text(
                        widget.desc,
                        style: onBackgroundRegular(fontSize: textSmall + 2),
                      ),
                      Utilities.commonSizedBox(paddingSmall),
                      Divider(
                        color: dividerColor,
                        thickness: 1,
                      ),
                      ListView.builder(
                        itemCount: optionList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color:
                                      optionList[index]['status'] == "Complete"
                                          ? colorTheme
                                          : colorProfileBorder,
                                  size: iconSize,
                                ),
                                SizedBox(
                                  width: paddingSmall,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: paddingSmall,
                                  ),
                                  child: Text(
                                    optionList[index]['name'],
                                    style: onBackgroundLightRegular(
                                      fontSize: textSmall + 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Utilities.loading(context, status: true);
                              String status = "";
                              if (optionList[index]['status'] == "Pending") {
                                status = "Complete";
                              } else {
                                status = "Pending";
                              }
                              apiPresenter.updateHabit(
                                  optionList[index]['_id'],
                                  optionList[index]['habit_id'],
                                  optionList[index]['name'],
                                  status);
                            },
                          );
                        },
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
    return SubPageAppBar(title: 'Habit Details');
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {}

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    if (requestCode == RequestCode.HABIT_LIST_BY_HABIT_ID ||
        requestCode.contains(RequestCode.HABIT_LIST_BY_HABIT_ID)) {
      optionList.addAll(object);
      debugPrint(optionList.toString());
      setState(() {});
    } else {
      Utilities.loading(context, status: false);
      apiPresenter.habitListByHabitId(context, widget.id);
      optionList.clear();
    }
  }
}
