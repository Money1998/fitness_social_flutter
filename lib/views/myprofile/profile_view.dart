import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebUrl.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/custom_page_route.dart';
import 'package:montage/constants/endpoints.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/db/db_helper.dart';
import 'package:montage/db/post_model.dart';
import 'package:montage/model/user_model.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/audio/audio_list.dart';
import 'package:montage/views/common/common_horizontal_view.dart';
import 'package:montage/views/common/common_profile_img.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfileView extends StatefulWidget {
  ProfileView({this.from});

  final String from;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> implements ApiCallBacks {
  //double value = 0;
  var chillList = [];
  List<QuestionsModel> questionList = [];
  List<QuestionsOption> optionList = [];
  String DateLoad = "";
  DateTime now = new DateTime.now();
  int currentPos = 0;
  var selectedIndex = -1;
  var montageList = [];
  List<dynamic> countList = [];
  List<String> countFilterDropdown = [];
  bool isLoading = true;
  bool isQuestionAns = false;
  bool isSelected = true;
  String userId = "";
  String questionId = "";
  String questionTitle = "";
  String days = "";
  String countDays = "";
  int chillCount = 0;
  int connectCount = 0;
  int chargeCount = 0;
  double _width = 200;
  double _height = 200;
  Future<List<Post>> posts;
  List<dynamic> strings = ['one', 'two', 'three', 'four', 'five'];
  dynamic snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiPresenter apiPresenter;
  DBHelper dbHelper;

  var habitList = [];

  bool loading = true;

  _ProfileViewState() {
    apiPresenter = ApiPresenter(this);
  }

  Map<String, dynamic> userName = {
    'full_name': '',
    'profile': '',
    'is_shared_profile': false,
    'is_notification': false,
    'email': '',
    'type': '',
    'person_type': '',
    'gender': ''
  };
  AppUser user;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // getDayStreakCount();
    getDayQuestion(RequestCode.GET_QUESTION_BY_DAY);
    getTotalPageView(RequestCode.GET_TOTAL_PAGE_VIEW);

    // print(user.firstName);

    dbHelper = DBHelper();

    getUserData();

    posts = dbHelper.getPosts();

    debugPrint("post " + posts.toString());

    chillList.addAll({
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1LzoX3PQ1fecqYYgSqW8SsRTkeTyU0MNGHQ&usqp=CAU',
      },
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM7FQdrWjBtZYBQN0y1X-q2ZrMjE4PS3T56A&usqp=CAU',
      },
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsqFWVteGBArCaXuXsXZnXX3RB-Y-Q74djuA&usqp=CAU',
      },
      {
        'image':
            'https://i.pinimg.com/originals/7b/f8/e0/7bf8e0dafd67f6828ba7d049c8d3bb4d.png',
      },
    });

    apiPresenter.getFavoritesListing(context, "6", "0");

    super.initState();
  }

  getUserData() async {
    var profleData = await SessionManager.getStringData('user_profile');
    userName = jsonDecode(profleData);
    print(userName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: setView(),
    );
  }

  Widget getButtons(String Option, bool isSelected) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: () async {
            DateTime currentDate = new DateTime.now();
            DateTime date = new DateTime(
                currentDate.year, currentDate.month, currentDate.day);
            String currentDateLoad = date.toString();
            if (currentDateLoad != DateLoad) {
              setFeelResponse(
                  Option, '${Option}Your Option Submit Successfully!');
              await SessionManager.setStringData(QUESTION_OPTION, Option);
            }
          },
          child: Row(
            children: [
              Text(Option,
                  style:
                      isSelected == true ? onPrimaryBold() : themeFontBold()),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          style: ButtonStyle(
              backgroundColor: isSelected == true
                  ? MaterialStateProperty.all<Color>(
                      Color(0xff7817C8).withOpacity(0.6))
                  : MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: colorTheme))))),
    );
  }

  buttons() {
    return List.generate(
      optionList.length,
      (index) {
        return InkWell(
          splashColor: colorPrimary,
          onTap: () {},
          child: getButtons(optionList[index].answer.toString(),
              optionList[index].isSelected),
        );
      },
    );
  }

  Widget setQuestionView() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return optionList.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(
                top: paddingSmall * 2,
                left: commonPadding * 1.5,
                right: commonPadding * 1.5,
              ),
              padding: EdgeInsets.only(
                  left: paddingSmall * 2,
                  right: paddingSmall * 2,
                  top: paddingSmall * 2,
                  bottom: paddingSmall * 2),
              decoration: BoxDecoration(
                color: colorBackground,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${questionTitle}",
                            style: themeFontSemiBold(fontSize: textSmall + 2),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.7,
                    color: dividerColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: buttons(),
                          ),
                        ]),
                  )
                ],
              ),
            )
          : Container();
    }
  }

  Widget setView() {
    _width = isQuestionAns ? 0.0 : MediaQuery.of(context).size.width;
    _height = isQuestionAns ? 0.0 : 310;
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
          color: colorBackgroundLight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileView(),
                //setCardDemo(),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInCirc,
                  width: _width,
                  height: _height,
                  child: setQuestionView(),
                ),
                topView(),
                stepCard(),
                mediaCard(),
                topText(),
                montageView(),
                Utilities.commonSizedBox(paddingMedium * 2),
                //habitView(),
                Utilities.commonSizedBox(paddingMedium * 4)
              ],
            ),
          ));
    }
  }

  bottomView() {
    return Container(
      color: colorBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Utilities.commonSizedBox(paddingMedium * 1.2),
          CommonHorizontalListView(
            horizontalList: chillList,
            title: AppStrings.chillCap,
          ),
          Utilities.commonSizedBox(paddingMedium * 2),
          CommonHorizontalListView(
            horizontalList: chillList,
            title: AppStrings.connectCap,
          ),
          Utilities.commonSizedBox(paddingMedium * 2),
          CommonHorizontalListView(
            horizontalList: chillList,
            title: AppStrings.chargeCap,
          ),
          Utilities.commonSizedBox(paddingMedium * 2),
        ],
      ),
    );
  }

  appBar() {
    return SubPageAppBar(
      title: AppStrings.myProfile,
      actionIcons: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteSettingView);
          },
          child: SvgPicture.asset(
            SvgImages.settingIc,
            height: iconSize,
            width: iconSize,
          ),
        ),
      ],
    );
  }

  habitView() {
    return Container(
      padding: EdgeInsets.all(paddingSmall * 2),
      margin: EdgeInsets.only(
        left: commonPadding * 1.5,
        right: commonPadding * 1.5,
        bottom: paddingLarge * 4,
      ),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [BoxShadow(color: Colors.black45)]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    SvgImages.heartIc,
                    height: smallIconSize,
                    width: smallIconSize,
                    color: colorTheme,
                  ),
                  SizedBox(
                    width: paddingMedium,
                  ),
                  Text(
                    AppStrings.habits,
                    style: themeFontMedium(),
                  ),
                ],
              ),
              Text(
                AppStrings.showAll,
                style: commontextStyle(
                  color: lightThemeFonts,
                  fontSize: textSmall,
                  fontFamily: FontNameRegular,
                ),
              ),
            ],
          ),
          Utilities.commonSizedBox(paddingSmall * 4),
          Column(
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            children: List.generate(
              habitList.length,
              (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: paddingSmall + 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: selectedIndex == index
                                  ? colorTheme
                                  : colorProfileBorder,
                              size: iconSize,
                            ),
                            SizedBox(
                              width: paddingSmall * 2,
                            ),
                            Text(
                              habitList[index]['title'],
                              style: onBackgroundLightRegular(
                                fontSize: textSmall + 2,
                              ),
                            ),
                          ],
                        ),
                        richText(habitList[index]['goal'])
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Utilities.commonSizedBox(paddingMedium),
          CommonButton(
            buttonText: "SHOW ALL",
            onPressed: () {
              Navigator.pushNamed(context, RouteHabitsView).then((value) => {
                    habitList.clear(),
                    montageList.clear(),
                    apiPresenter.getFavoritesListing(context, "6", "0")
                  });
            },
            width: MediaQuery.of(context).size.width,
            backgroundColor: Colors.transparent,
            isRightArrow: false,
            borderColor: colorTheme,
            buttonFontStyle: themeFontMedium(),
          ),
        ],
      ),
    );
  }

  richText(goal) {
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

  montageView() {
    return Container(
      margin: EdgeInsets.only(
        top: paddingSmall * 2,
        left: commonPadding * 1.5,
        right: commonPadding * 1.5,
      ),
      padding: EdgeInsets.only(
          left: paddingSmall * 2,
          right: paddingSmall * 2,
          top: paddingSmall * 2,
          bottom: paddingSmall * 2),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    SvgImages.heartIc,
                    height: smallIconSize,
                    width: smallIconSize,
                    color: colorTheme,
                  ),
                  SizedBox(
                    width: paddingMedium,
                  ),
                  Text(
                    AppStrings.myMontage,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteFavoriteView);
                },
                child: Text(
                  AppStrings.showAll,
                  style: commontextStyle(
                    color: lightThemeFonts,
                    fontSize: textSmall,
                    fontFamily: FontNameRegular,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: paddingSmall + 2,
          ),
          montageList.length == 0
              ? Center(
                  child: Text(
                  AppStrings.noMontageItemFound,
                  style: TextStyle(color: Colors.black),
                ))
              : Container(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: montageList.take(6).toList().length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.only(
                      // left: commonPadding,
                      // right: commonPadding,
                      top: paddingSmall,
                      bottom: paddingSmall,
                    ),
                    itemBuilder: (BuildContext context, int index) => ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CustomPageRoute(
                              child: AudioList(montageList[index]['_id'])));
                        },
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image(
                              image: CachedNetworkImageProvider(
                                  RequestCode.apiEndPoint +
                                      montageList[index]['image']),
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              // color: Color.fromRGBO(255, 255, 255, 0.6),
                              colorBlendMode: BlendMode.modulate,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(paddingSmall + 4),
                              decoration: BoxDecoration(
                                color: Color(0xff511F74).withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                montageList[index]['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: primaryMedium(
                                  fontSize: textVerySmall,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(
                      2,
                      index.isEven ? 3 : 2.5,
                    ),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 10.0,
                  ),
                ),
          SizedBox(
            height: paddingLarge * 3.2,
          ),
          CommonButton(
            buttonText: "SHOW ALL",
            onPressed: () {
              Navigator.pushNamed(context, RouteFavoriteView);
            },
            width: MediaQuery.of(context).size.width,
            backgroundColor: Colors.transparent,
            isRightArrow: false,
            borderColor: colorTheme,
            buttonFontStyle: themeFontMedium(),
          ),
        ],
      ),
    );
  }

  profileView() {
    return Container(
      color: colorBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: paddingLarge * 1.5,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: commonPadding * 1.5,
              right: commonPadding * 1.5,
            ),
            child: Row(
              children: [
                CommonProfile(
                  userIcon: getImage(),
                ),
                SizedBox(
                  width: paddingSmall * 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utilities.commonSizedBox(paddingSmall),
                    Row(
                      children: [
                        Text(
                          userName['full_name'],
                          style: themeFontRegular(fontSize: textMedium),
                        ),
                        SizedBox(
                          width: paddingSmall,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgImages.femaleIc,
                              height: smallIconSize,
                              width: smallIconSize,
                            ),
                            SizedBox(width: paddingVerySmall),
                            Text(
                              userName['gender'],
                              style: themeFontRegular(),
                            )
                          ],
                        ),
                        SizedBox(
                          width: paddingSmall,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              SvgImages.owaIc ?? '',
                              height: smallIconSize,
                              width: smallIconSize,
                            ),
                            SizedBox(width: paddingVerySmall),
                            Text(
                              userName['person_type'],
                              style: themeFontRegular(),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: paddingSmall * 2,
          ),
        ],
      ),
    );
  }

  String getImage() {
    debugPrint("username " + userName.toString());
    try {
      if (userName != null) {
        return 'https://www.ensembleschools.com/rochester/wp-content/uploads/sites/8/2020/10/default-user-avatar.jpg';
      } else {
        if (userName['profile'] == null || userName['profile'].isEmpty()) {
          return 'https://www.ensembleschools.com/rochester/wp-content/uploads/sites/8/2020/10/default-user-avatar.jpg';
        } else {
          return userName['profile'];
        }
      }
    } catch (error) {
      return 'https://www.ensembleschools.com/rochester/wp-content/uploads/sites/8/2020/10/default-user-avatar.jpg';
    }
  }

  dropDownUI() {
    return Theme(
      data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(colorTheme),
      )),
      child: DropdownButton<String>(
        menuMaxHeight: 150,
        elevation: 10,
        style: themeFontSemiBold(fontSize: textSmall + 2),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        items: countFilterDropdown.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
        underline: Container(
          height: 2,
          color: colorTheme,
        ),
        onChanged: (newValue) {
          setState(() {
            countDays = newValue;
            setValueDropdown(countDays);
          });
        },
        hint: Text(
          countDays,
          style: themeFontSemiBold(fontSize: textSmall + 2),
        ),
        dropdownColor: lightAppbar,
      ),
    );
  }

  topView() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        margin: EdgeInsets.only(
          top: paddingSmall * 2,
          left: commonPadding * 1.5,
          right: commonPadding * 1.5,
        ),
        padding: EdgeInsets.only(
            left: paddingSmall * 2,
            right: paddingSmall * 2,
            top: paddingSmall * 0,
            bottom: paddingSmall * 2),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                    ),
                    dropDownUI(),
                    Container(
                      width: 20,
                    ),
                    Text(
                      "STREAK",
                      style: themeFontRegular(),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  SvgImages.shareIc,
                  height: smallIconSize,
                  width: smallIconSize,
                ),
              ],
            ),
            Divider(
              thickness: 0.7,
              color: dividerColor,
            ),
            Utilities.commonSizedBox(paddingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                progressBar(
                  AppStrings.chillCap,
                  '${chillCount}',
                  [
                    Color(0xff8B00FF),
                    Color(0xff662D91),
                  ],
                ),
                progressBar(
                  AppStrings.connectCap,
                  '${connectCount}',
                  [
                    Color(0xff8B00FF),
                    Color(0xff662D91),
                  ],
                ),
                progressBar(
                  AppStrings.chargeCap,
                  '${chargeCount}',
                  [
                    Color(0xff8B00FF),
                    Color(0xff662D91),
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }
  }

  mediaCard() {
    return Container(
      margin: EdgeInsets.only(
        top: paddingSmall * 2,
        left: commonPadding * 1.5,
        right: commonPadding * 1.5,
      ),
      padding: EdgeInsets.only(
          // left: paddingSmall + 2,
          // right: paddingSmall + 2,
          top: paddingSmall * 2,
          bottom: paddingSmall * 2),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingSmall * 2),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.lastViewed,
                  style: themeFontMedium(fontSize: textSmall),
                )
              ],
            ),
          ),
          Utilities.commonSizedBox(
            paddingVerySmall,
          ),
          Utilities.commonSizedBox(paddingSmall),
          Padding(
            padding: EdgeInsets.only(
                left: paddingSmall * 2, right: paddingSmall * 2),
            child: FutureBuilder(
              future: posts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data.take(3).toList());
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Center(
                    child: Text(
                      "No item found",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
          SizedBox(
            height: paddingSmall * 2,
          ),
          CommonButton(
            buttonText: "SHOW ALL",
            onPressed: () {
              Navigator.pushNamed(context, RouteMediaView);
            },
            width: MediaQuery.of(context).size.width,
            backgroundColor: Colors.transparent,
            isRightArrow: false,
            borderColor: colorTheme,
            buttonFontStyle: themeFontMedium(),
          ),
        ],
      ),
    );
  }

  stepCard() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteEditGoalView);
      },
      child: Container(
        margin: EdgeInsets.only(
          top: paddingSmall * 2,
          left: commonPadding * 1.5,
          right: commonPadding * 1.5,
        ),
        padding: EdgeInsets.only(
            left: paddingSmall * 2,
            right: paddingSmall * 2,
            top: paddingSmall * 2,
            bottom: paddingSmall * 2),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // SvgPicture.asset(SvgImages.legIc,
                    Image.asset(
                      AssetsImage.legIc,
                      height: iconSize + 2,
                      width: iconSize + 2,
                    ),
                    SizedBox(
                      width: paddingSmall,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "5 999",
                          style: themeFontSemiBold(fontSize: textMedium),
                        ),
                        Text(
                          AppStrings.totalStep,
                          style: themeFontRegular(),
                        )
                      ],
                    ),
                  ],
                ),
                commonProgressBar(
                  [
                    Color(0xff8B00FF),
                    Color(0xff662D91),
                  ],
                  '59%',
                )
              ],
            ),
            Utilities.commonSizedBox(
              paddingVerySmall,
            ),
            Divider(
              thickness: 0.7,
              color: dividerColor,
            ),
            Utilities.commonSizedBox(paddingSmall),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                stepCardRow(
                    SvgImages.upArrowIc, "348", "steps more than yesterday"),
                Utilities.commonSizedBox(paddingSmall),
                stepCardRow(
                  SvgImages.downArrowIc,
                  "3000",
                  "steps less than usual",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  stepCardRow(
    icon,
    stepsCount,
    title,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          height: iconSize / 1.5,
          width: iconSize / 1.5,
        ),
        SizedBox(
          width: paddingSmall,
        ),
        Text(
          stepsCount,
          style: themeFontRegular(
            fontSize: textSmall + 2,
          ),
        ),
        SizedBox(
          width: paddingLarge * 2,
        ),
        Text(
          title,
          style: themeFontRegular(),
        ),
      ],
    );
  }

  topText() {
    return Padding(
      padding: EdgeInsets.only(right: commonPadding * 1.5, top: paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "+696 EXP",
            style: primaryMedium(fontSize: textSmall + 2),
          ),
          Text(
            " by last week",
            style: primaryRegular(),
          )
        ],
      ),
    );
  }

  progressBar(String headerText, String centerText, List<Color> colors) {
    double percent = (double.tryParse(centerText) / 500);
    return Column(
      children: [
        Text(
          headerText,
          style: themeFontRegular(fontSize: textSmall),
        ),
        Utilities.commonSizedBox(paddingSmall),
        CircularPercentIndicator(
          radius: 84.0,
          lineWidth: 6.0,
          animation: true,
          percent: percent,
          center: CircleAvatar(
            radius: 35.8,
            backgroundColor: Color(0xffF1F1F1),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${centerText}pt",
                    style: themeFontRegular(
                      fontSize: textSmall + 2,
                    ),
                  ),
                  SizedBox(
                    width: paddingVerySmall,
                  ),
                  SvgPicture.asset(
                    SvgImages.upArrowIc,
                    height: smallIconSize,
                    width: smallIconSize,
                  )
                ],
              ),
            ),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          rotateLinearGradient: true,
          backgroundColor: Colors.transparent,
          linearGradient: LinearGradient(colors: colors),
        ),
      ],
    );
  }

  commonProgressBar(colors, centerText) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 5.0,
      animation: true,
      percent: 0.7,
      center: CircleAvatar(
        radius: 25.8,
        backgroundColor: Color(0xffF1F1F1),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                centerText,
                style: themeFontRegular(
                  fontSize: textSmall + 2,
                ),
              ),
            ],
          ),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      rotateLinearGradient: true,
      backgroundColor: Colors.transparent,
      linearGradient: LinearGradient(colors: colors),
    );
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {}

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    if (requestCode == RequestCode.FAVORITES_LIST ||
        requestCode.contains(RequestCode.FAVORITES_LIST)) {
      debugPrint("=====");
      debugPrint(object.toString());
      montageList.addAll(object);
      print("montageList => ${montageList.length}");

      apiPresenter.habitListByUserId(context);
    } else {
      isLoading = false;
      habitList.addAll(object);
      debugPrint(habitList.toString());
      setState(() {});
    }
  }

  Future<dynamic> getTotalPageView(String requestCode) async {
    var userID = await SessionManager.getStringData('userId');
    var url = WebUrl.QUESTION_URL + requestCode + userID;
    setState(() {
      isLoading = true;
    });
    debugPrint("getTotalPageView URL => $url");
    Response response =
        await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      debugPrint("getTotalPageView response => ${response.body}");
      dynamic object = await jsonDecode(response.body);
      if (object != null) {
        setState(() {
          countList.add(object['data']);
          print("countList => $countList");
          countDays = countList[0][0]['days'];
          chillCount = countList[0][0]['counts']['Chill'];
          connectCount = countList[0][0]['counts']['CONNECT'];
          chargeCount = countList[0][0]['counts']['CHARGE'];
          getValueDropdown(countList);
          isLoading = false;
        });
      }
    }
  }

  Future<dynamic> getValueDropdown(List<dynamic> countList) async {
    countFilterDropdown.clear();
    for (int i = 0; i < countList[0].length; i++) {
      print("sl => ${countList[0][i]["days"]}");
      countFilterDropdown.add(countList[0][i]["days"]);
      print("countFilterDropdown => $countFilterDropdown");
    }
  }

  Future<dynamic> setValueDropdown(String countDays) async {
    for (int i = 0; i < countList[0].length; i++) {
      print("sl => ${countList[0][i]["days"]}");
      if (countDays == countList[0][i]["days"]) {
        chillCount = countList[0][i]['counts']['Chill'];
        connectCount = countList[0][i]['counts']['CONNECT'];
        chargeCount = countList[0][i]['counts']['CHARGE'];
      }
    }
  }

  Future<dynamic> getDayQuestion(String requestCode) async {
    setState(() {
      optionList.clear();
      isLoading = true;
    });
    DateTime currentDate = new DateTime.now();
    DateTime date =
        new DateTime(currentDate.year, currentDate.month, currentDate.day);
    String currentDateLoad = date.toString();
    DateLoad = await SessionManager.getDateTime(DATE_TIME);
    if (currentDateLoad == DateLoad) {
      isQuestionAns = true;
      questionTitle = await SessionManager.getStringData(QUESTION_TITLE);
      setSelectedOptionList(requestCode);
    } else {
      setOptionList(requestCode);
    }
  }

  setSelectedOptionList(String requestCode) async {
    var url = WebUrl.QUESTION_URL + requestCode;
    var id = await SessionManager.getStringData('userId');
    String selectedOptionValue =
        await SessionManager.getStringData(QUESTION_OPTION);
    debugPrint(url);
    Response response =
        await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      print("response => ${response.body}");
      dynamic object = jsonDecode(response.body);
      List<QuestionsModel> list = [];
      List<QuestionsOption> options = [];
      List<QuestionsOption> newOptionList = [];
      options.add(QuestionsOption(
        answer: object['option']["option1"].toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object['option']["option2"].toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object['option']["option3"].toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object['option']["option4"].toString(),
        isSelected: false,
      ));
      list.add(QuestionsModel(
          id: object["_id"].toString(),
          days: object["days"].toString(),
          option: options,
          title: object["title"].toString()));
      if (list.isNotEmpty) {
        currentPos = 0;
        questionList = list;
        userId = id;
        questionId = questionList[0].id;
        questionTitle = questionList[0].title;
        days = questionList[0].days;
      }
      if (options.isNotEmpty) {
        for (int i = 0; i < options.length; i++) {
          if (selectedOptionValue == options[i].answer) {
            newOptionList.add(QuestionsOption(
              answer: options[i].answer,
              isSelected: true,
            ));
          } else {
            newOptionList.add(QuestionsOption(
              answer: options[i].answer,
              isSelected: false,
            ));
          }
        }
      }
      setState(() {
        optionList = newOptionList;
        isLoading = false;
      });
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  setOptionList(String requestCode) async {
    setState(() {
      optionList.clear();
      isLoading = true;
    });
    var url = WebUrl.QUESTION_URL + requestCode;
    var id = await SessionManager.getStringData('userId');
    debugPrint(url);
    Response response =
        await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      print("response => ${response.body}");
      dynamic object = jsonDecode(response.body);
      List<QuestionsModel> list = [];
      List<QuestionsOption> options = [];
      options.add(QuestionsOption(
        answer: object['option']["option1"].toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object['option']["option2"].toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object['option']["option3"].toString(),
        isSelected: false,
      ));
      options.add(QuestionsOption(
        answer: object['option']["option4"].toString(),
        isSelected: false,
      ));
      list.add(QuestionsModel(
          id: object["_id"].toString(),
          days: object["days"].toString(),
          option: options,
          title: object["title"].toString()));
      if (list.isNotEmpty) {
        isLoading = false;
        currentPos = 0;
        questionList = list;
        optionList = options;
        userId = id;
        questionId = questionList[0].id;
        questionTitle = questionList[0].title;
        days = questionList[0].days;
      }
      setState(() {
        isLoading = false;
      });
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  ListView generateList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(CustomPageRoute(child: AudioList(posts[index].id)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: CachedNetworkImageProvider(
                        RequestCode.apiEndPoint + posts[index].image),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    // color: Color.fromRGBO(255, 255, 255, 0.6),
                    colorBlendMode: BlendMode.modulate,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(paddingSmall + 4),
                    decoration: BoxDecoration(
                      color: Color(0xff511F74).withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posts[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: primarySemiBold(
                            fontSize: textMedium + 1,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Text(
                          posts[index].status + " Tracks",
                          style: primarySemiBold(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ListView countProgressList(List countList) {}

  Future<void> setFeelResponse(String optionValue, String msg) async {
    List<QuestionsOption> newOptionList = [];
    DateLoad = await SessionManager.getDateTime(DATE_TIME);
    if (DateLoad == "") {
      DateTime date = new DateTime(now.year, now.month, now.day);
      SessionManager.setDateTime(DATE_TIME, date.toString());
    } else {
      DateLoad = await SessionManager.getDateTime(DATE_TIME);
      print("DateLoad=> $DateLoad");
    }
    if (optionList != null) {
      for (int i = 0; i < optionList.length; i++) {
        if (optionValue == optionList[i].answer) {
          newOptionList.add(QuestionsOption(
            answer: optionList[i].answer,
            isSelected: true,
          ));
        } else {
          newOptionList.add(QuestionsOption(
            answer: optionList[i].answer,
            isSelected: false,
          ));
        }
      }
    }
    optionList.clear();
    setState(() {
      _height = 0;
      _width = 0;
      isQuestionAns = true;
      optionList.addAll(newOptionList);
      print("newOptionList Fill after=> $optionList");
      postOption(RequestCode.CREATE_QUESTION_OPTION, optionValue, msg);
    });
  }

  Future<dynamic> postOption(
      String requestCode, String option, String msg) async {
    bool isInternet = await Utilities.isConnectedNetwork();
    if (!isInternet) {
      snackBar = SnackBar(
        content: Text("Check your internet connection and try again"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      try {
        Map<String, dynamic> requestParam = {
          "question_id": questionId,
          "question_title": questionTitle,
          "days": days,
          "option": option,
          "user_id": userId
        };
        String url = WebUrl.QUESTION_URL + requestCode;
        print(url);
        print("requestParam => $requestParam");
        Response response = await http
            .post(Uri.parse(url),
                headers: {
                  "Content-Type": "application/json",
                  HttpHeaders.authorizationHeader: 'Bearer ' +
                      await SessionManager.getStringData(ACCESS_TOKEN),
                },
                body: jsonEncode(requestParam))
            .timeout(Duration(seconds: 30));

        final responseBody = jsonDecode(response.body);
        print(responseBody);
        if (response.statusCode == 200) {
          print("DAATATTATA");
          print(responseBody);
          snackBar = SnackBar(
            content: Text(msg),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          print("da");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}

class PageCount {
  String days;
  List<Counts> counts;

  PageCount({this.days, this.counts});
}

class Counts {
  int CHILL;
  int CONNECT;
  int CHARGE;

  Counts({this.CHILL, this.CONNECT, this.CHARGE});
}

class QuestionsModel {
  String id;
  String title;
  String days;
  List<QuestionsOption> option;

  QuestionsModel({this.id, this.title, this.days, this.option});
}

class QuestionsOption {
  String answer;
  bool isSelected;

  QuestionsOption({this.answer, this.isSelected});
}
