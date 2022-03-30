import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/constants/custom_page_route.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/views/audio/connect_detail.dart';
import 'package:montage/views/audio/connect_detail_copy.dart';

// ignore: must_be_immutable
class ChannelHorizontalListView extends StatefulWidget {
  @override
  ChannelHorizontalListView({
    Key key,
    @required this.channelList,
    this.title,
    this.showSeeAll = false,
    this.mainContainerBGcolor,
    this.listContainerBGcolor,
    this.iconColor,
    this.borderColor,
    this.isShadow = false,
    this.height,
    this.width,
    this.borderRadius,
  }) : super(key: key);

  List channelList;
  String title;
  bool showSeeAll;
  Color mainContainerBGcolor;
  Color listContainerBGcolor;
  Color iconColor;
  Color borderColor;
  bool isShadow;
  double height;
  double width;
  double borderRadius;

  @override
  _CommonHorizontalListViewState createState() =>
      _CommonHorizontalListViewState();
}

class _CommonHorizontalListViewState extends State<ChannelHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: commonPadding,
              right: commonPadding,
              top: paddingSmall + 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title == null ? '' : widget.title,
                    style: commontextStyle(
                      fontFamily: FontNameMedium,
                      fontSize: textSmall + 4,
                      color: colorBackground,
                    )),
                Text(
                  'Discover',
                  style: commontextStyle(
                    color: colorBackground,
                    fontSize: textSmall + 2,
                    fontFamily: FontNameRegular,
                  ),
                ),
              ],
            ),
          ),
          widget.channelList == null || widget.channelList.length == 0
              ? Center(child: Text("DATA NOT FOUND"))
              : Expanded(
                  child: ListView.builder(
                      itemCount: widget.channelList.length,
                      padding: EdgeInsets.only(
                          left: commonPadding,
                          right: commonPadding,
                          top: paddingSmall),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctxt, int index) => InkWell(
                          onTap: () {
                            debugPrint(index.toString());
                            Navigator.of(context).push(CustomPageRoute(child: ConnectDetailCopy(
                                    widget.channelList[index]['_id'],
                                    widget.channelList[index]['name'],
                                    widget.channelList[index]['desc'],
                                    widget.channelList[index]['logo'],
                                    widget.channelList[index]['background'])));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: widget.channelList.length - index == 1
                                    ? 0
                                    : paddingSmall),
                            child: Container(
                              height:
                                  widget.height == null ? 120 : widget.height,
                              width: widget.width == null ? 100 : widget.width,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        widget.borderRadius == null
                                            ? 12
                                            : widget.borderRadius),
                                    child: Container(
                                      height: widget.height == null
                                          ? 120
                                          : widget.height,
                                      width: widget.width == null
                                          ? 100
                                          : widget.width,
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            widget.channelList[index]['logo']
                                        ),
                                      ),
                                    )
                                    /*CachedNetworkImage(
                                      imageUrl: RequestCode.apiEndPoint +
                                          widget.channelList[index]['logo'],
                                      fit: BoxFit.cover,
                                      height: widget.height == null
                                          ? 120
                                          : widget.height,
                                      width: widget.width == null
                                          ? 100
                                          : widget.width,
                                    )*/,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(paddingSmall),
                                    decoration: BoxDecoration(
                                      color: Color(0xff511F74).withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            widget.borderRadius == null
                                                ? 12
                                                : widget.borderRadius),
                                        bottomRight: Radius.circular(
                                          widget.borderRadius == null
                                              ? 12
                                              : widget.borderRadius,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      widget.channelList[index]['name'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: primaryMedium(
                                          fontSize: textVerySmall),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))),
                )
        ],
      ),
    );
  }
}
