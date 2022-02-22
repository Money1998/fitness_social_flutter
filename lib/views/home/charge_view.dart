import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/views/audio/audio_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChargeView extends StatefulWidget {
  @override
  _ChargeViewState createState() => _ChargeViewState();
}

class _ChargeViewState extends State<ChargeView> implements ApiCallBacks {
  ApiPresenter apiPresenter;

  _ChargeViewState() {
    apiPresenter = new ApiPresenter(this);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var chillList = [];
  int charge = 0;
  bool isLoading = true;

  @override
  void initState() {
    setChargeCount();
    apiPresenter.getPostList(context, "CHARGE");
    super.initState();
  }

  Future<void> setChargeCount() async {
    final prefs = await SharedPreferences.getInstance();
    charge = prefs.get('CHARGE');
    if (charge < 0) {
      prefs.setInt('CHARGE', charge);
    } else {
      charge++;
      prefs.setInt('CHARGE', charge);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      scaffoldKey: scaffoldKey,
      builder: (context, constraints) {
        if (isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Container(
          color: colorBackgroundLight,
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: chillList.length,
            padding: EdgeInsets.only(
              left: commonPadding,
              right: commonPadding,
              bottom: paddingLarge * 4,
              top: paddingSmall,
            ),
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AudioList(chillList[index]['_id'])));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    /*CachedNetworkImage(
                        imageUrl:
                            RequestCode.apiEndPoint + chillList[index]['image'],
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        // color: Color.fromRGBO(255, 255, 255, 0.6),
                        colorBlendMode: BlendMode.modulate,
                        placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            )
                        // Image.network(
                        //     ,fit: BoxFit.cover,),
                        )*/

                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image(
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.modulate,
                          image: CachedNetworkImageProvider(
                              RequestCode.apiEndPoint +
                                  chillList[index]['image'])),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(paddingSmall + 4),
                      decoration: BoxDecoration(
                        color: Color(0xff511F74).withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        chillList[index]['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: primaryMedium(
                          fontSize: textVerySmall,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            staggeredTileBuilder: (int index) => new StaggeredTile.count(
              2,
              index.isEven ? 2.5 : 4,
            ),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 10.0,
          ),
        );
      },
    );
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
    debugPrint("----");
    if (requestCode.indexOf(RequestCode.POST) != -1) {
      chillList.addAll(object);
    }

    isLoading = false;
    setState(() {});
  }
}
