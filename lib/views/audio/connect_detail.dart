import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectDetail extends StatefulWidget {
  final String id, name, desc, logo, background;

  ConnectDetail(this.id, this.name, this.desc, this.logo, this.background);

  @override
  _ConnectDetailState createState() => _ConnectDetailState();
}

class _ConnectDetailState extends State<ConnectDetail>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Widget> myTabs = [
    Tab(text: 'Audio'),
    Tab(text: 'Video'),
    Tab(text: 'Photos'),
  ];

  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ID " + widget.id);
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
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                  "${RequestCode.apiEndPoint}${widget.background}"))
                          /*CachedNetworkImage(
                            imageUrl:
                                RequestCode.apiEndPoint + widget.background,
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
                              icon: Image.network(
                                  RequestCode.apiEndPoint + widget.logo),
                              onPressed: () => {},
                            )),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Subscribe",
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          colorTheme)),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/images/like.svg",
                                  color: colorTheme,
                                ),
                                SizedBox(
                                  height: 5,
                                ), // icon
                                Text("Like"), // text
                              ],
                            ),
                            Column(
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                controller: _tabController,
                                labelColor: colorTheme,
                                tabs: myTabs,
                                indicatorColor: colorTheme,
                              ),
                              Column(
                                children: [
                                  _tabController.index == 0
                                      ? Center(child: Text('Audio'))
                                      : Container(),
                                  _tabController.index == 1
                                      ? Center(child: Text('Video'))
                                      : Container(),
                                  _tabController.index == 2
                                      ? Center(child: Text('Photos'))
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
      title: widget.name,
      actionIcons: [Padding(padding: EdgeInsets.only(right: 10))],
    );
  }
}

void launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
