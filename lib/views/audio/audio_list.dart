import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/db/db_helper.dart';
import 'package:montage/db/post_model.dart';
import 'package:montage/model/track_detail.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';
import 'package:montage/views/video/video_player.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import 'audio_player.dart';

class AudioList extends StatefulWidget {
  final String id;

  AudioList(this.id);

  @override
  _AudioListState createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> implements ApiCallBacks {
  TrackDetail _trackDetail;
  ApiPresenter apiPresenter;
  DBHelper dbHelper;

  _AudioListState() {
    apiPresenter = new ApiPresenter(this);
  }

  bool isLoading = true;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    apiPresenter.getPlayListById(context, widget.id);
    dbHelper = DBHelper();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ID " + widget.id);
    return ResponsiveWidget(
        scaffoldKey: scaffoldKey,
        builder: (context, constraints) {
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Container(
              color: colorBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  appBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.001,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: paddingLarge * 20,
                                      left: commonPadding * 2,
                                      right: commonPadding * 2,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: lightgradientBG,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (_trackDetail
                                                .playlists[0]
                                                .mediaType !=
                                                null &&
                                                _trackDetail
                                                    .playlists[0]
                                                    .mediaType
                                                    .isNotEmpty) {
                                              debugPrint("Media Type : " +
                                                  _trackDetail
                                                      .playlists[0]
                                                      .mediaType);

                                              if (_trackDetail
                                                  .playlists[0]
                                                  .mediaType ==
                                                  "Audio") {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AudioPlayerList(
                                                                _trackDetail)));
                                              } else if (_trackDetail
                                                  .playlists[0]
                                                  .mediaType ==
                                                  "Link") {
                                                debugPrint(_trackDetail
                                                    .playlists[0]
                                                    .link);

                                                launchURL(_trackDetail
                                                    .playlists[0]
                                                    .link);
                                              } else {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VideoPlayerList(_trackDetail
                                                                .playlists[
                                                            0]
                                                                .video)));
                                              }
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                _trackDetail.playlists.length
                                                        .toString() +
                                                    " Tracks " +
                                                    convertTime(totalTime()),
                                                style: primaryMedium(
                                                    fontSize: textMedium),
                                              ),
                                              SizedBox(
                                                width: paddingSmall,
                                              ),
                                              CircleAvatar(
                                                radius: 18,
                                                backgroundColor: colorTheme,
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  size: smallIconSize * 1.5,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: paddingMedium * 2,
                                        ),
                                        Html(
                                            data:
                                                "${_trackDetail.description}"),
                                        SizedBox(
                                          height: paddingLarge,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: paddingMedium,
                                            bottom: paddingMedium,
                                          ),
                                          decoration: BoxDecoration(
                                            color: colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: List.generate(
                                              _trackDetail.playlists.length,
                                              (index) => InkWell(
                                                onTap: () {
                                                  if (_trackDetail
                                                              .playlists[index]
                                                              .mediaType !=
                                                          null &&
                                                      _trackDetail
                                                          .playlists[index]
                                                          .mediaType
                                                          .isNotEmpty) {
                                                    debugPrint("Media Type : " +
                                                        _trackDetail
                                                            .playlists[index]
                                                            .mediaType);

                                                    if (_trackDetail
                                                            .playlists[index]
                                                            .mediaType ==
                                                        "Audio") {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AudioPlayerList(
                                                                      _trackDetail)));
                                                    } else if (_trackDetail
                                                            .playlists[index]
                                                            .mediaType ==
                                                        "Link") {
                                                      debugPrint(_trackDetail
                                                          .playlists[index]
                                                          .link);

                                                      launchURL(_trackDetail
                                                          .playlists[index]
                                                          .link);
                                                    } else {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VideoPlayerList(_trackDetail
                                                                      .playlists[
                                                                          index]
                                                                      .video)));
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  color:
                                                      index == 0 || index == 1
                                                          ? colorBackgroundgrey
                                                          : colorBackground,
                                                  padding: EdgeInsets.only(
                                                    top: paddingSmall * 2,
                                                    bottom: paddingSmall * 2,
                                                    left: paddingSmall + 4,
                                                    right: paddingSmall + 4,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                          flex: 6,
                                                          child: Wrap(
                                                            children: [
                                                              Text(
                                                                (index + 1)
                                                                        .toString() +
                                                                    '  ' +
                                                                    _trackDetail
                                                                        .playlists[
                                                                            index]
                                                                        .title,
                                                                maxLines: 15,
                                                                style:
                                                                    onBackgroundLightRegular(
                                                                  fontSize:
                                                                      textSmall +
                                                                          2,
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                      Flexible(
                                                        flex: 4,
                                                        child: Text(
                                                          _trackDetail
                                                                      .playlists[
                                                                          index]
                                                                      .mediaType ==
                                                                  "Audio"
                                                              ? convertTime(int
                                                                  .parse(_trackDetail
                                                                      .playlists[
                                                                          index]
                                                                      .time))
                                                              : _trackDetail
                                                                          .playlists[
                                                                              index]
                                                                          .mediaType ==
                                                                      "Video"
                                                                  ? "Video"
                                                                  : "Youtube",
                                                          style:
                                                              onBackgroundRegular(
                                                            fontSize:
                                                                textSmall + 2,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: paddingLarge * 2,
                                        ),
                                        InkWell(
                                          child: CommonButton(
                                            buttonText:
                                                AppStrings.addToMyMontage,
                                          ),
                                          onTap: () async {
                                            var userId = await SessionManager
                                                .getStringData(
                                                    WebFields.USER_ID);
                                            Utilities.loading(context,
                                                status: true);
                                            if (_trackDetail.favorites.length ==
                                                0) {
                                              apiPresenter.favorites(
                                                  userId, _trackDetail.id);
                                            } else {
                                              apiPresenter.unFavorites(
                                                  _trackDetail.favorites[0].id);
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: paddingLarge * 1.5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                        top: paddingLarge * 2,
                                        left: commonPadding * 2,
                                        right: commonPadding * 2,
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                            child: Image(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  RequestCode.apiEndPoint +
                                                      _trackDetail.image),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ))),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: paddingLarge * 1.5,
                                      bottom: 0,
                                      right: paddingLarge * 1.5,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(paddingSmall + 4),
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xff511F74).withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _trackDetail.title,
                                            style: primaryMedium(
                                              fontSize: textMedium,
                                            ),
                                          ),
                                          SizedBox(
                                            height: paddingVerySmall / 1.5,
                                          ),
                                          Text(
                                            _trackDetail.playlists.length
                                                    .toString() +
                                                " Tracks",
                                            style: primaryRegular(
                                              fontSize: textSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  appBar() {
    return SubPageAppBar(
      title: '',
      actionIcons: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: SvgPicture.asset(
              SvgImages.heartIc,
              height: iconSize / 1.2,
              width: iconSize / 1.2,
              color: _trackDetail.favorites.length == 0
                  ? colorProfileBorder
                  : colorTheme,
            ),
            onPressed: () async {
              var userId =
                  await SessionManager.getStringData(WebFields.USER_ID);
              Utilities.loading(context, status: true);
              if (_trackDetail.favorites.length == 0) {
                apiPresenter.favorites(userId, _trackDetail.id);
              } else {
                apiPresenter.unFavorites(_trackDetail.favorites[0].id);
              }
            },
          ),
        )
      ],
    );
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {
    Utilities.loading(context, status: false);
  }

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    debugPrint("=====");
    debugPrint(object.toString());
    if (requestCode == RequestCode.FAVORITES ||
        requestCode.contains(RequestCode.FAVORITES)) {
      Utilities.loading(context, status: false);

      Utilities.showSuccess(scaffoldKey, "Montage Updated");

      Timer(Duration(seconds: 1), () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
      });
    } else {
      _trackDetail = (TrackDetail.fromJson(object));
      debugPrint("Favorites");
      debugPrint(_trackDetail.favorites.toString());
      debugPrint(_trackDetail.favorites.length.toString());
      operation();
      isLoading = false;
    }

    setState(() {});
  }

  Future operation() async {
    var count;
    if (_trackDetail.favorites.length == 0) {
      count = "0";
    } else {
      count = _trackDetail.favorites.length.toString();
    }
    debugPrint(count);

    Post post = Post(
        _trackDetail.id,
        _trackDetail.title,
        _trackDetail.id,
        _trackDetail.description,
        count,
        _trackDetail.image,
        _trackDetail.userId,
        _trackDetail.id);

    debugPrint("insert");
    dbHelper.add(post);

    if (dbHelper.getPostByIdQuery(_trackDetail.id) != null) {
      debugPrint("update");
      dbHelper.update(post);
    } else {
      debugPrint("insert");
      dbHelper.add(post);
    }
  }

  int totalTime() {
    return _trackDetail.playlists
        .fold(0, (sum, item) => sum + int.parse(item.time));
  }

  String convertTime(int timeInMilliseconds) {
    Duration timeDuration = Duration(milliseconds: timeInMilliseconds);
    int centiseconds = timeDuration.inMilliseconds ~/ 10;
    int seconds = timeDuration.inSeconds;
    int minutes = timeDuration.inMinutes;
    int hours = timeDuration.inHours;

    if (hours > 0) {
      return sprintf(
          '%i:%02i:%02i.%02i', [hours, minutes, seconds, centiseconds]);
    } else if (minutes > 0) {
      return sprintf('%i:%02i.%02i', [minutes, seconds, centiseconds]);
    } else {
      return sprintf('%i.%02i', [seconds, centiseconds]);
    }
  }

  void launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  updateItem(Post value) {
    var count;
    if (_trackDetail.favorites.length == 0) {
      count = "0";
    } else {
      count = _trackDetail.favorites.length.toString();
    }

    debugPrint(DateTime.now().microsecondsSinceEpoch.toString());

    Post post = Post(
        _trackDetail.id,
        _trackDetail.title,
        _trackDetail.id,
        _trackDetail.description,
        count,
        _trackDetail.image,
        _trackDetail.userId,
        DateTime.now().microsecondsSinceEpoch.toString());
    dbHelper.update(post);
  }
}
