import 'package:flutter/material.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';

class CommentView extends StatefulWidget {
  final String id;

  CommentView(this.id);

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> implements ApiCallBacks {
  var chatData = [];
  bool isLoading = true;

  ScrollController _scrollController = new ScrollController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ApiPresenter apiPresenter;

  _CommentViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  @override
  void initState() {
    apiPresenter.commentListing(context, widget.id);
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
              title: AppStrings.comment,
              appBarBGcolor: Colors.transparent,
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: chatData.length,
                      padding: EdgeInsets.only(
                        left: commonPadding,
                        right: commonPadding,
                        top: paddingMedium,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                                title: Text(chatData[index]["comment"])));
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
                    onTap: () async {
                      if (messageController.text == '') {
                        Utilities.showError(
                            scaffoldKey, "Please enter you message");
                      } else {
                        Utilities.loading(context, status: true);
                        var userId = await SessionManager.getStringData(
                            WebFields.USER_ID);
                        apiPresenter.commentPost(
                            userId, widget.id, messageController.text);
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

  @override
  void onConnectionError(String error, String requestCode) {
    // TODO: implement onConnectionError
  }

  @override
  void onError(String errorMsg, String requestCode) {
    // TODO: implement onError
  }

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    if (requestCode == RequestCode.ADD_COMMENT ||
        requestCode.contains(RequestCode.ADD_COMMENT)) {
      Utilities.loading(context, status: false);
      messageController.text="";
      chatData.add(object);
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {});
    } else {
      debugPrint("----");
      debugPrint("Post Comment List");
      debugPrint(object.toString());
      debugPrint(strMsg);
      debugPrint(requestCode);
      chatData.addAll(object);
      debugPrint(chatData.toString());

      isLoading = false;

      setState(() {});
    }


  }
}
