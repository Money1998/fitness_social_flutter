import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebUrl.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/views/common/common_horizontal_view.dart';
import 'package:share_plus/share_plus.dart';

class ConnectView extends StatefulWidget {
  @override
  _ConnectViewState createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> implements ApiCallBacks {
  ApiPresenter apiPresenter;

  int connect = 0;

  _ConnectViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  var groupList = [];

  var channelList = [];
  bool isLoading = true;

  @override
  void initState() {
    clickPageTypeCount("CONNECT");
    apiPresenter.getChannelList(context);

    groupList.addAll([
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU9KacXegyVuN81QYN57W8fbJuuQGMpQ_Tug&usqp=CAU'
      },
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU9KacXegyVuN81QYN57W8fbJuuQGMpQ_Tug&usqp=CAU'
      },
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU9KacXegyVuN81QYN57W8fbJuuQGMpQ_Tug&usqp=CAU'
      },
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU9KacXegyVuN81QYN57W8fbJuuQGMpQ_Tug&usqp=CAU'
      },
      {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQU9KacXegyVuN81QYN57W8fbJuuQGMpQ_Tug&usqp=CAU'
      },
    ]);
    super.initState();
  }

  Future<dynamic> clickPageTypeCount(String title) async {
    var userID = await SessionManager.getStringData('userId');
    try {
      Map<String, dynamic> requestParam = {
        "user_id": userID,
        "page_type": title
      };
      var param = jsonEncode(requestParam);
      String url = WebUrl.QUESTION_URL + RequestCode.CLICK_PAGE_COUNT;
      print(url);
      print("requestParam => $requestParam");
      Response response = await http
          .post(Uri.parse(url),
              headers: {
                "Content-Type": "application/json",
              },
              body: param)
          .timeout(Duration(seconds: 30));

      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        setState(() {
          print("set Count = > $responseBody");
        });
      } else {
        print("da");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, constraints) {
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor("#F8E5FF"),
                HexColor("#A35CC4"),
                HexColor("#400B65"),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: paddingLarge * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CommonHorizontalListView(
                        horizontalList: groupList,
                        title: 'GROUPS',
                      ),
                      SizedBox(height: paddingMedium),
                      if (isLoading) Center(child: CircularProgressIndicator()),
                      // else
                      //   ChannelHorizontalListView(
                      //     channelList: channelList,
                      //     title: 'CHANNELS',
                      //     showSeeAll: false,
                      //     height: 80,
                      //     width: 110,
                      //     borderRadius: 14,
                      //   ),
                      Card(
                          color: Colors.deepPurple.withOpacity(0.3),
                          child: Column(
                            children: [
                              profileView(),
                              likeCommentShareCard(),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  profileView() {
    return Padding(
      padding: const EdgeInsets.only(
        left: commonPadding,
        right: commonPadding,
        top: paddingLarge * 2,
        bottom: paddingLarge * 2,
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Container(
                height: 55,
                width: 55,
                child: Image(
                  image: CachedNetworkImageProvider(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhX99a1vf8jUicueQrH7wWIEe7fwv95FB_Hw&usqp=CAU"),
                ),
              )),
          SizedBox(width: paddingSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: new TextSpan(
                  text: 'Jane Smith',
                  style: commontextStyle(
                    color: colorBackground,
                    fontSize: textSmall + 2,
                    fontFamily: FontNameSemiBold,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: ' in ',
                        style: commontextStyle(
                          color: Colors.white38,
                          fontSize: textSmall,
                          fontFamily: FontNameRegular,
                        )),
                    TextSpan(
                      text: 'Basic Meditation',
                      style: commontextStyle(
                        color: colorBackground,
                        fontSize: textSmall + 2,
                        fontFamily: FontNameSemiBold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: paddingSmall),
              Text(
                '14:05, 15 Apr 2021',
                style: commontextStyle(
                  color: Colors.grey[350],
                  fontSize: textSmall,
                  fontFamily: FontNameRegular,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  likeCommentShareCard() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: commonPadding, right: commonPadding),
            child: Text(
              'Meditation isn\'t about becoming a different person,a new person,or even a better person.',
              style: commontextStyle(
                color: colorBackground,
                fontSize: textSmall + 2,
                fontFamily: FontNameSemiBold,
              ),
            ),
          ),
          SizedBox(height: paddingMedium * 2),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: CachedNetworkImageProvider(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiiK5xCERNAADefKPThkLWR--tCObqIoGdJw&usqp=CAU"),
                  fit: BoxFit.fitWidth,
                )),
          ),
          SizedBox(height: paddingMedium * 2),
          Card(
            color: Colors.deepPurple.withOpacity(0.7),
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Row(children: [
                SizedBox(
                  child: Row(children: [
                    Icon(Icons.thumb_up, color: Colors.white),
                    SizedBox(width: paddingMedium - 05),
                    Text("Support", style: TextStyle(color: Colors.white)),
                  ]),
                ),
                SizedBox(
                  child: Row(children: [
                    Icon(Icons.mode_comment_outlined, color: Colors.white),
                    SizedBox(width: paddingMedium - 05),
                    Text("Comment", style: TextStyle(color: Colors.white)),
                  ]),
                ),
                InkWell(
                  onTap: () => Share.share(
                      'check out my website https://montagefit.com/',
                      subject: 'Look what I made!'),
                  child: SizedBox(
                    child: Row(children: [
                      Icon(Icons.share, color: Colors.white),
                      SizedBox(width: paddingMedium - 05),
                      Text("Share", style: TextStyle(color: Colors.white)),
                    ]),
                  ),
                ),
              ],mainAxisAlignment: MainAxisAlignment.spaceAround),
            ),
          )
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
    debugPrint("----");
    if (requestCode.indexOf(RequestCode.CHANNEL_LIST) != -1) {
      channelList.addAll(object);
    }
    isLoading = false;

    setState(() {});
  }
}
