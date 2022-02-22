import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/components/chat/user_icon.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';

typedef void OnWidgetSizeChange(Size size);

class Cmessage extends StatefulWidget {
  final int messageId;
  final String message;
  final String time;
  final int index;
  final String user;
  final int userId;

  Cmessage({
    this.messageId,
    this.message,
    this.time,
    this.index,
    this.userId,
    this.user,
  });
  _CmessageState createState() => _CmessageState();
}

class _CmessageState extends State<Cmessage> {
  int userId = 1;
  GlobalKey _keyGes = GlobalKey();
  List list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.isLeft);
    return 
    Padding(
      padding: EdgeInsets.only(top:paddingMedium,),
   child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.userId != userId ? ChatUserIcon() : Container(),
        SizedBox(width:paddingSmall),
        Expanded(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 80,
                ),
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(
                    paddingSmall,
                  ),
                  decoration: BoxDecoration(
                      color: colorBackground,
                      borderRadius: widget.userId != userId
                          ? BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.message,
                          style:commontextStyle(
                            color: Color(0xff685879),
                            fontSize:textSmall+2,
                            fontFamily: FontNameRegular
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height:paddingSmall/1.5),
              Padding(padding: EdgeInsets.only(left:userId == widget.userId?paddingLarge*3.7:paddingSmall/1.5,),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [Text(widget.user,style: primaryLight()), Text(widget.time,style: primaryLight(),),],
              ),)
            ],
          ),
        )
      ],
    ),);
  }
}
