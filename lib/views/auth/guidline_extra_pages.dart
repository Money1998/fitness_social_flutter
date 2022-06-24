import 'package:flutter/material.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';
import 'package:montage/customs/global_var.dart' as globals;

class GuidLineExtraPages extends StatefulWidget {
  const GuidLineExtraPages({Key key}) : super(key: key);

  @override
  _GuidLineExtraPagesState createState() => _GuidLineExtraPagesState();
}

class _GuidLineExtraPagesState extends State<GuidLineExtraPages>
    implements ApiCallBacks {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiPresenter _apiPresenter;
  bool isLoading = false;
  List<QuestionsModel> questionList = [];

  // QuestionsModel currentQuestion;
  int currentPos = 0;

  _GuidLineExtraPagesState() {
    _apiPresenter = new ApiPresenter(this);
  }

  commonSizedBox(height) {
    return SizedBox(
      height: height,
    );
  }

  padding(horizontal, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: widget,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    _apiPresenter.getSignUpQuestion(context);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      scaffoldKey: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 221, 254, 0.7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 30, color: colorTheme),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(gradient: lightgradientBG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(colorBackground)))
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // titleTxt(),
                          commonSizedBox(paddingLarge * 2),
                          subTitleText(),
                          commonSizedBox(paddingMedium),
                          commonSizedBox(
                            paddingMedium * 2,
                          ),
                          Column(
                            children: buttons(),
                          ),
                          commonSizedBox(paddingMedium + 4),
                        ],
                      ),
              ),
              bottomButton(),
              commonSizedBox(paddingLarge * 2)
            ],
          ),
        );
      },
    );
  }

  subTitleText() {
    return padding(
      paddingLarge * 3,
      Text(
        questionList[currentPos].question,
        style: primaryLight(fontSize: textLarge),
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  buttons() {
    return List.generate(
      questionList[currentPos].optionsList.length,
      (index) {
        return InkWell(
          splashColor: colorPrimary,
          onTap: () {
            setState(() {
              questionList[currentPos].optionsList[index].isSelected =
                  !questionList[currentPos].optionsList[index].isSelected;
            });
          },
          child: Padding(
              padding: EdgeInsets.only(
                  right: paddingSmall, bottom: paddingSmall + 4),
              child: Button(questionList[currentPos].optionsList[index])),
        );
      },
    );
  }

  bottomButton() {
    return Column(
      children: [
        CommonButton(
          isleadIcon: false,
          isRightArrow: false,
          width: MediaQuery.of(context).size.width / 1.4,
          buttonText: Utilities.capitalize(AppStrings.next),
          onPressed: () {
            for (QuestionsModel model in questionList) {
              print(model.question);
            }
            bool isSelected = false;
            for (QuestionsOption model
                in questionList[currentPos].optionsList) {
              if (model.isSelected) {
                isSelected = true;
                break;
              }
            }

            if (isSelected) {
              if (currentPos == questionList.length - 1) {
                // Navigator.pushNamed(context, RouteGuildlinePage03);
                // Utilities.showError(scaffoldKey, 'Please select your answer');
                List<dynamic> data = [];
                for (int i = 0; i < questionList.length; i++) {
                  String answer = "";
                  for (QuestionsOption model in questionList[i].optionsList) {
                    if (model.isSelected) {
                      answer = model.answer;
                      break;
                    }
                  }
                  data.add({"id": questionList[i].id, "answer": answer});
                }
                globals.questionData = data;

                Navigator.pushNamed(context, RouteGuildlinePage03);
                print("globals.questionData ==> ${globals.questionData}");
              } else {
                List<dynamic> data = [];
                for (int i = 0; i < questionList.length; i++) {
                  String answer = "";
                  for (QuestionsOption model in questionList[i].optionsList) {
                    if (model.isSelected) {
                      answer = model.answer;
                      break;
                    }
                  }
                  data.add({"id": questionList[i].id, "answer": answer});
                }
                globals.questionData = data;
                print("globals.questionData ==> ${globals.questionData}");
                print("object");
                setState(() {
                  currentPos = currentPos + 1;
                });
                print("object : $currentPos");
                print("object : ${questionList[currentPos].question}");
              }
            } else {
              Utilities.showError(scaffoldKey, 'Please select your answer');
            }
          },
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
    });
    print("onSuccess");
    // List<QuestionDataModel> list = questionDataModelFromJson(object);
    List<QuestionsModel> list = [];
    for (int i = 0; i < object.length; i++) {
      List<QuestionsOption> options = [];
      options.add(QuestionsOption(
        answer: object[i]["optionOne"] ?? "N/A".toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object[i]["optionTwo"] ?? "N/A".toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object[i]["optionThree"] ?? "N/A".toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object[i]["optionFour"] ?? "N/A".toString(),
        isSelected: false,
      ));
      list.add(QuestionsModel(
          question: object[i]["question"] ?? "".toString(),
          id: object[i]["_id"] ?? "".toString(),
          optionsList: options,
          userId: object[i]["userId"] ?? "".toString()));
    }

    if (list.isNotEmpty) {
      currentPos = 0;
      questionList = list;
    }
    setState(() {});
  }
}

class QuestionsModel {
  String question;
  String id;
  String userId;
  List<QuestionsOption> optionsList;

  QuestionsModel({this.question, this.id, this.userId, this.optionsList});
}

class QuestionsOption {
  String answer;
  bool isSelected;

  QuestionsOption({this.answer, this.isSelected});
}

class Button extends StatelessWidget {
  final QuestionsOption _item;

  Button(this._item);

  @override
  Widget build(BuildContext context) {
    return _item.isSelected
        ? CommonButton(
            backgroundColor: lightFonts,
            isleadIcon: false,
            isRightArrow: false,
            width: MediaQuery.of(context).size.width / 1.4,
            buttonText: _item.answer,
          )
        : CommonButton(
            isleadIcon: false,
            isRightArrow: false,
            width: MediaQuery.of(context).size.width / 1.4,
            buttonText: _item.answer,
          );
  }
}
