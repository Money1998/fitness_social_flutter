import 'package:flutter/material.dart';
import 'package:montage/components/chat/message.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var chatData = [];
  ScrollController _scrollController = new ScrollController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    chatData.addAll([
      {
        'message':
            'Hello how are you! i hope you are fine and all good Thank you! ',
        'userName': 'John Doe',
        'index': 0,
        'time': '45 m. ago',
        'userId': 2,
      },
      {
        'message':
            'Hello how are you! i hope you are fine and all good Thank you! ',
        'userName': 'John Doe',
        'index': 0,
        'time': '45 m. ago',
        'userId': 2,
      },
      {
        'message':
            'Hello how are you! i hope you are fine and all good Thank you! ',
        'userName': 'You',
        'index': 0,
        'time': 'now',
        'userId': 1,
      },
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: lightgradientBG),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            SubPageAppBar(
              title: AppStrings.chat,
              appBarBGcolor: Colors.transparent,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chatData.length,
                padding: EdgeInsets.only(
                  left: commonPadding,
                  right: commonPadding,
                  top: paddingMedium,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Cmessage(
                    message: chatData[index]['message'],
                    user: chatData[index]['userName'],
                    index: index,
                    time: chatData[index]['time'],
                    userId: chatData[index]['userId'],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: commonPadding,
                right: commonPadding,
                bottom: paddingSmall + 4,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: inputBox(),
                  ),
                  SizedBox(width: paddingSmall),
                  InkWell(
                    onTap: () {
                      if (messageController.text == '') {
                        Utilities.showError(
                            scaffoldKey, "Please enter you message");
                      } else {
                        setState(() {
                             chatData.add({
                          'message': messageController.text,
                          'userName': 'You',
                          'index': 0,
                          'time': 'now',
                          'userId': 1,
                        });
                        });
                       
                      }
                    },
                    child: Icon(
                      Icons.send,
                      size: iconSize * 1.2,
                      color: colorPrimary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  //Input box
  Widget inputBox() {
    return Material(
        elevation: 4.0,
        color: colorPrimary,
        borderRadius: BorderRadius.all(Radius.circular(22)),
        child: Container(
          height: 40,
          child: TextFormField(
            // initialValue: this.initialValue,
            // maxLength: this.maxLength,
            minLines: 1,
            autofocus: false,
            // enabled: this.enabled,
            // maxLines: 4,
            controller: messageController,
            decoration: InputDecoration(
              // prefixIcon: this.prefixIcon,
              // suffixIcon: this.sufixIcon,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(top: 0.0, bottom: 10.0, left: 20, right: 10),

              fillColor: colorPrimary,
              hintText: 'text',
              hintStyle: commontextStyle(
                  color: Color(0xff685879),
                  fontFamily: FontNameRegular,
                  fontSize: textSmall),
            ),
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            // keyboardType: setKeyboardType(this.keyboardType),
            // autovalidate:
            //     this.autovalidate == null ? false : this.autovalidate,
            // obscureText: this.obscureText == null ? false : this.obscureText,
            // onSaved: onSaved,
            // inputFormatters: inputFomat == null ? null : this.inputFomat,
            // textInputAction: this.textInputAction == null
            //     ? TextInputAction.newline
            //     : this.textInputAction,
            // validator: validator,
            // onFieldSubmitted: onFieldSubmitted,
            // focusNode: this.focusNode,
          ),
        ));
  }
}
