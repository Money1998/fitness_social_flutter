import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/api/WebFields.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/session_manager.dart';
import 'package:montage/utils/utilites.dart';
import 'package:toast/toast.dart';

class FeedBackView extends StatefulWidget {
  @override
  _FeedBackViewState createState() => _FeedBackViewState();
}

class _FeedBackViewState extends State<FeedBackView> implements ApiCallBacks {
  ApiPresenter apiPresenter;

  _FeedBackViewState() {
    apiPresenter = ApiPresenter(this);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController()..text = "";
  final emailController = TextEditingController()..text = "";
  final descController = TextEditingController()..text = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, constraints) {
      return Container(
        color: colorBackground,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                appBar(),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter email";
                    }
                    if (!validateEmail(value)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: descController,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 10,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      debugPrint("success");
                      var userId =
                          await SessionManager.getStringData(WebFields.USER_ID);
                      Utilities.loading(context, status: true);
                      apiPresenter.feedBack(userId, titleController.text,
                          emailController.text, descController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: colorTheme),
                  child: Text("SUBMIT"),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  appBar() {
    return SubPageAppBar(title: AppStrings.feedback);
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {}

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    debugPrint("=====");
    debugPrint(object.toString());
    if (requestCode == RequestCode.FEEDBACK ||
        requestCode.contains(RequestCode.FEEDBACK)) {
      Toast.show('Feedback sent successfully ', context);
      Utilities.loading(context, status: false);
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }
}
