import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/model/html_page.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';

class WebPageView extends StatefulWidget {
  final String title;

  WebPageView(this.title);

  @override
  _WebPageViewState createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> implements ApiCallBacks {
  ApiPresenter apiPresenter;
  HtmlPage htmlPage;
  var  page;
  bool isLoading = true;

  _WebPageViewState() {
    apiPresenter = ApiPresenter(this);
  }

  @override
  void initState() {
    var id;
    if (widget.title == AppStrings.privacyPolicy) {
      id = "609181e1c1e0cd39707bdec2";
    } else if (widget.title == AppStrings.teamsNcondition) {
      id = "609181f0c1e0cd39707bdec3";
    } else if (widget.title == AppStrings.faq) {
      id = "609181d8c1e0cd39707bdec1";
    }
    apiPresenter.getHtmlPage(context, id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ResponsiveWidget(builder: (context, constraints) {

      if (isLoading) {
        return Center(child: CircularProgressIndicator());
      }

      return Container(
        color: colorBackground,
        child:Column(
          children: <Widget>[
            appBar(),
            Expanded(
              child: ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Html(data: page == null ? "" :'${page['description']}'),
                  ),
                ],
              ),
            ),

          ],
        )
      );
    });
  }

  appBar() {
    return SubPageAppBar(title: widget.title);
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {}

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    debugPrint("=====");
    debugPrint(object.toString());
  /*  htmlPage = (HtmlPage.fromJson(object));
    debugPrint(htmlPage.data.description);
    debugPrint("=====sss");*/
    page=object;
    isLoading = false;
    debugPrint("ssssss");
    setState(() {});
  }
}
