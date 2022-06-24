import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';

class CommonHorizontalListView extends StatefulWidget {
  @override
  CommonHorizontalListView({
    Key key,
    @required this.horizontalList,
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

  List horizontalList;
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

class _CommonHorizontalListViewState extends State<CommonHorizontalListView> {
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
          widget.horizontalList == null || widget.horizontalList.length == 0
              ? Center(child: Text("DATA NOT FOUND"))
              : Expanded(
                  child: ListView.builder(
                      itemCount: widget.horizontalList.length,
                      padding: EdgeInsets.only(
                          left: commonPadding,
                          right: commonPadding,
                          top: paddingSmall),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctxt, int index) => InkWell(
                          onTap: () {
                            debugPrint(index.toString());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: widget.horizontalList.length - index == 1
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
                                      child: widget.title != AppStrings.feedback
                                          ? Image(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  widget.horizontalList[index]
                                                      ['image']),
                                            )
                                          : Image.file(
                                              File(
                                                  widget.horizontalList[index]),
                                              fit: BoxFit.cover,
                                            ),
                                    )
                                    /*CachedNetworkImage(
                                      imageUrl: widget.horizontalList[index]
                                          ['image'],
                                      fit: BoxFit.cover,
                                      height: widget.height == null
                                          ? 120
                                          : widget.height,
                                      width: widget.width == null
                                          ? 100
                                          : widget.width,
                                    )*/
                                    ,
                                  ),
                                  widget.title != AppStrings.feedback
                                      ? Container(
                                          padding: EdgeInsets.all(paddingSmall),
                                          decoration: BoxDecoration(
                                            color: Color(0xff511F74)
                                                .withOpacity(0.5),
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
                                            "TRAIN YOUR BRAIN THIS NEW YEARS",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: primaryMedium(
                                                fontSize: textVerySmall),
                                          ),
                                        )
                                      : InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ),
                                          onTap: () {
                                            removeImage(
                                                widget.horizontalList[index]);
                                          },
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

  Future removeImage(index) async {
    widget.horizontalList.remove(index);
    setState(() {
    });
  }
}
