import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/model/track_detail.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/comment/comment_view.dart';
import 'package:montage/views/video/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

import 'audio_player.dart';

class ConnectDetailCopy extends StatefulWidget {
  final String id, name, desc, logo, background;

  ConnectDetailCopy(this.id, this.name, this.desc, this.logo, this.background);

  @override
  _ConnectDetailState createState() => _ConnectDetailState();
}

class _ConnectDetailState extends State<ConnectDetailCopy>
    with SingleTickerProviderStateMixin
    implements ApiCallBacks {
  ApiPresenter apiPresenter;

  var channelItemList = [];
  var audiItemList = [];
  var linkItemList = [];
  var videoItemList = [];

  var like = "0";

  _ConnectDetailState() {
    apiPresenter = new ApiPresenter(this);
  }

  bool isLoading = true;

  final List<Widget> myTabs = [
    Tab(text: 'Audio'),
    Tab(text: 'Video'),
    Tab(text: 'Photos'),
  ];

  TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    apiPresenter.getChannelItemList(context, widget.id);
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (tabController.indexIsChanging) {
      setState(() {
        selectedIndex = tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ID " + widget.id);
    debugPrint("Like status " + like);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: colorTheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 30, color: colorPrimary),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 0,
          title: Text(widget.name)),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image(
              image: CachedNetworkImageProvider(
                  "${RequestCode.apiEndPoint}${widget.background}"),
              fit: BoxFit.fill,
            )
            /*CachedNetworkImage(
              imageUrl: RequestCode.apiEndPoint + widget.background,
              fit: BoxFit.fill,
            )*/
            ,
          ),
          ListTile(
              title: Text(
                widget.name,
                style: TextStyle(fontSize: 20.0),
              ),
              subtitle: Html(
                data: "${widget.desc}",
              ),
              leading: IconButton(
                icon: Image.network(RequestCode.apiEndPoint + widget.logo),
                onPressed: () => {},
              )),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Subscribe",
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(colorTheme)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/like.svg",
                      color: like == "1" ? colorProfileBorder : colorTheme,
                    ),
                    SizedBox(
                      height: 5,
                    ), // icon
                    Text("Like"), // text
                  ],
                ),
                onTap: () async {
                  Utilities.loading(context, status: true);
                  var userId =
                      await SessionManager.getStringData(WebFields.USER_ID);
                  if (like == "1") {
                    like = "0";
                  } else {
                    like = "1";
                  }
                  apiPresenter.like(userId, widget.id, like);
                },
              ),
              InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/comment.svg",
                    ),
                    SizedBox(
                      height: 5,
                    ), // icon
                    Text("Comment"), // text
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CommentView(widget.id)));
                },
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          TabBar(
            labelColor: colorTheme,
            tabs: myTabs,
            indicatorColor: colorTheme,
            controller: tabController,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
                tabController.animateTo(index);
              });
            },
          ),
          IndexedStack(
            children: <Widget>[
              Visibility(
                child: Container(
                  height: 500,
                  child: getAudiList(),
                ),
                maintainState: true,
                visible: selectedIndex == 0,
              ),
              Visibility(
                child: Container(
                  height: 500,
                  child: getVideoList(),
                ),
                maintainState: true,
                visible: selectedIndex == 1,
              ),
              Visibility(
                child: Container(
                  height: 500,
                  child: getPhotoList(),
                ),
                maintainState: true,
                visible: selectedIndex == 2,
              ),
            ],
            index: selectedIndex,
          ),
        ],
      ),
    );
  }

  Widget getPhotoList() {
    return linkItemList.isNotEmpty
        ? ListView.builder(
            itemCount: linkItemList.length,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(linkItemList[index]["title"]),
                leading: Text((index + 1).toString()),
                trailing: Text(linkItemList[index]["media_type"]),
                onTap: () {
                  launchURL(linkItemList[index]["link"]);
                },
              );
            },
          )
        : Center(
            child: Text("No photo found"),
          );
  }

  Widget getVideoList() {
    return videoItemList.isNotEmpty
        ? ListView.builder(
            itemCount: videoItemList.length,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(videoItemList[index]["title"]),
                leading: Text((index + 1).toString()),
                trailing: Text(videoItemList[index]["media_type"]),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          VideoPlayerList(videoItemList[index]["video"])));
                },
              );
            },
          )
        : Center(
            child: Text("No video found"),
          );
  }

  Widget getAudiList() {
    return audiItemList.isNotEmpty
        ? ListView.builder(
            itemCount: audiItemList.length,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(audiItemList[index]["title"]),
                leading: Text((index + 1).toString()),
                trailing: Text(audiItemList[index]["media_type"]),
                onTap: () {
                  List<Playlists> playlists = [];
                  playlists.add(Playlists(
                      title: audiItemList[index]["title"],
                      description: audiItemList[index]["description"],
                      audio: audiItemList[index]["audio"],
                      image: audiItemList[index]["image"]));
                  TrackDetail _trackDetail = TrackDetail(
                      title: audiItemList[index]["title"],
                      playlists: playlists);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AudioPlayerList(_trackDetail)));
                },
              );
            },
          )
        : Center(
            child: Text("No audio found"),
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
    if (requestCode == RequestCode.CHANNEL_LIKE ||
        requestCode.contains(RequestCode.CHANNEL_LIKE)) {
      Utilities.loading(context, status: false);
      debugPrint("----");
      debugPrint("Like");
      like = object["status"].toString();

      setState(() {});
    } else {
      debugPrint("----");
      debugPrint("channelItem List");
      debugPrint(object.toString());
      debugPrint(strMsg);
      debugPrint(requestCode);
      channelItemList.addAll(object);
      isLoading = false;

      for (int i = 0; i < channelItemList.length; i++) {
        if (channelItemList[i]["media_type"] == "Audio") {
          audiItemList.add(channelItemList[i]);
        } else if (channelItemList[i]["media_type"] == "Link") {
          linkItemList.add(channelItemList[i]);
        } else {
          videoItemList.add(channelItemList[i]);
        }
      }
      debugPrint("$audiItemList");
      debugPrint("$linkItemList");
      debugPrint("$videoItemList");

      setState(() {});
    }
  }
}

void launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
