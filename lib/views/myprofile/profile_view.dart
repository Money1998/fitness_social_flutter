import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  ProfileView({this.from});

  final String from;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> implements ApiCallBacks {
  //double value = 0;
  var chillList = [];
  var selectedIndex = -1;
  var favoritesList = [];
  bool isLoading = true;
  int chillCount = 0;
  int connectCount = 0;
  int chargeCount = 0;
  Future<List<Post>> posts;
  dynamic snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiPresenter apiPresenter;
  DBHelper dbHelper;

  var habitList = [];

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
    getDayStreakCount();
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

    apiPresenter.getFavoritesListing(context, "5", "0");

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

  Widget getDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Select Your Mood ?")),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            setFeelResponse(
                                'Bad', 'Your Mood Submit Successfully!');
                          },
                          child: Row(
                            children: [
                              Text("Bad", style: primaryLargeBold()),
                              Icon(
                                Icons.mood_bad,
                                size: 30,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff511F74).withOpacity(0.5),
                            //change background color of button
                            onPrimary: Color(0xff511F74).withOpacity(0.5),
                            //change text color of button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              setFeelResponse(
                                  'Better', 'Your Mood Submit Successfully!');
                            });
                          },
                          child: Row(
                            children: [
                              Text("Better", style: primaryLargeBold()),
                              Icon(
                                Icons.mood_outlined,
                                size: 30,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff511F74).withOpacity(0.5),
                            //change background color of button
                            onPrimary: Color(0xff511F74).withOpacity(0.5),
                            //change text color of button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              setFeelResponse(
                                  'Good', 'Your Mood Submit Successfully!');
                            });
                          },
                          child: Row(
                            children: [
                              Text("Good", style: primaryLargeBold()),
                              Icon(
                                Icons.mood_sharp,
                                size: 30,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff511F74).withOpacity(0.5),
                            //change background color of button
                            onPrimary: Color(0xff511F74).withOpacity(0.5),
                            //change text color of button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      )
                    ]),
              )
            ],
          );
        });
  }

  Widget setView() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
          color: colorBackgroundLight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileView(),
                stepCard(),
                mediaCard(),
                topView(),
                toptext(),
                montageView(),
                Utilities.commonSizedBox(paddingMedium * 2),
                habitView(),
                Utilities.commonSizedBox(paddingMedium * 2)
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
                    favoritesList.clear(),
                    apiPresenter.getFavoritesListing(context, "5", "0")
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
          favoritesList.length == 0
              ? Center(
                  child: Text(
                  AppStrings.noMontageItemFound,
                  style: TextStyle(color: Colors.black),
                ))
              : Container(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: favoritesList.length,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AudioList(favoritesList[index]['_id'])));
                        },
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image(
                              image: CachedNetworkImageProvider(
                                  RequestCode.apiEndPoint +
                                      favoritesList[index]['image']),
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              // color: Color.fromRGBO(255, 255, 255, 0.6),
                              colorBlendMode: BlendMode.modulate,
                            )
                            /* CachedNetworkImage(
                                imageUrl: RequestCode.apiEndPoint +
                                    favoritesList[index]['image'],
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                // color: Color.fromRGBO(255, 255, 255, 0.6),
                                colorBlendMode: BlendMode.modulate,
                                placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    )
                                // Image.network(
                                //     ,fit: BoxFit.cover,),
                                )*/
                            ,
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
                                favoritesList[index]['title'],
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
                      index.isEven ? 3 : 2,
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
                InkWell(
                  onTap: () => getDialog(),
                  child: CommonProfile(
                    userIcon: getImage(),
                  ),
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
                          style: themeFontRegular(fontSize: textMedium + 2),
                        ),
                        // Text(
                        //   "85 lvl",
                        //   style: themeFontRegular(
                        //     fontSize: textSmall + 2,
                        //   ),
                        // ),
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
          // SliderTheme(
          //   data: SliderTheme.of(context).copyWith(
          //     inactiveTrackColor: Color(0xffF1F1F1),
          //     thumbColor: colorTheme,
          //     trackShape: GradientRectSliderTrackShape(),
          //   ),
          //   child: Slider(
          //     value: value,
          //     max: 100,
          //     min: 0,
          //     onChanged: (val) {
          //       setState(() {
          //         value = val;
          //       });
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       left: commonPadding * 1.5, right: commonPadding * 1.5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Bad",
          //         style: themeFontRegular(),
          //       ),
          //       Text(
          //         "Better",
          //         style: themeFontRegular(),
          //       ),
          //       Text(
          //         "Good",
          //         style: themeFontRegular(),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: paddingSmall * 2,
          // ),
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

  topView() {
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
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "45  ",
                    style: themeFontSemiBold(fontSize: textSmall + 2),
                  ),
                  Text(
                    "DAYS STREAK",
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
                '$chillCount pt',
                [
                  Color(0xff3C0662),
                  Color(0xffBA00FF),
                ],
              ),
              progressBar(
                AppStrings.connectCap,
                '$connectCount pt',
                [
                  HexColor("#400B65"),
                  HexColor("#A35CC4"),
                  HexColor("#F8E5FF"),
                ],
              ),
              progressBar(
                AppStrings.chargeCap,
                '$chargeCount pt',
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
                  return generateList(snapshot.data);
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
          )
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

  toptext() {
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
          percent: 0.7,
          center: CircleAvatar(
            radius: 35.8,
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
      favoritesList.addAll(object);

      apiPresenter.habitListByUserId(context);
    } else {
      isLoading = false;

      habitList.addAll(object);
      debugPrint(habitList.toString());

      setState(() {});
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AudioList(posts[index].id)));
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
                  )
                  /*CachedNetworkImage(
                      imageUrl: RequestCode.apiEndPoint + posts[index].image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width,
                      // color: Color.fromRGBO(255, 255, 255, 0.6),
                      colorBlendMode: BlendMode.modulate,
                      placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          )
                      // Image.network(
                      //     ,fit: BoxFit.cover,),
                      )*/
                  ,
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

  Future<void> setFeelResponse(String feelValue, String s) async {
    setState(() {
      Navigator.pop(context);
      snackBar = SnackBar(
        content: Text(s),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> getDayStreakCount() async {
    final prefs = await SharedPreferences.getInstance();

    chillCount = await prefs.get('CHILL') ?? 0;
    connectCount = await prefs.get('CONNECT') ?? 0;
    chargeCount = await prefs.get('CHARGE') ?? 0;

    print("chillCount ===> $chillCount");
    print("connectCount ===> $connectCount");
    print("chargeCount ===> $chargeCount");

    prefs.setInt('CHILL', chillCount);
    prefs.setInt('CONNECT', connectCount);
    prefs.setInt('CHARGE', chargeCount);
  }
}

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  /// Create a slider track that draws two rectangles with rounded outer edges.
  const GradientRectSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    @required RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    @required Animation<double> enableAnimation,
    @required TextDirection textDirection,
    @required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(context != null);
    assert(offset != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(enableAnimation != null);
    assert(textDirection != null);
    assert(thumbCenter != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight <= 0) {
      return;
    }
    LinearGradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xffBA00FF),
          Color(0xff3C0662),
        ]);
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation);
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation);
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
