import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/module/api_presenter.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/views/audio/audio_list.dart';

class FavouriteView extends StatefulWidget {
  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> implements ApiCallBacks {
  ApiPresenter apiPresenter;

  _FavouriteViewState() {
    apiPresenter = ApiPresenter(this);
  }

  var favoritesList = [];

  bool isLoading = true;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    apiPresenter.getFavoritesListing(context, "100", "0");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, constraints) {
      if (isLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return SafeArea(
          child: Container(
        color: colorBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            appBar(),
            Expanded(
              child: favoritesList.length == 0
                  ? Center(
                      child: Text(
                      "No favorites item found",
                      style: TextStyle(color: Colors.black),
                    ))
                  : StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: favoritesList.length,
                      padding: EdgeInsets.only(
                        left: commonPadding,
                        right: commonPadding,
                        bottom: paddingSmall,
                        top: paddingSmall,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AudioList(favoritesList[index]['_id'])));
                          },
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                image: CachedNetworkImageProvider(
                                    RequestCode.apiEndPoint +
                                        favoritesList[index]['image']
                                ),
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                // color: Color.fromRGBO(255, 255, 255, 0.6),
                                colorBlendMode: BlendMode.modulate,
                              )
                              /*CachedNetworkImage(
                                  imageUrl: RequestCode.apiEndPoint +
                                      favoritesList[index]['image'],
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
                                  )*/,
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
                                  favoritesList[index]['title'],
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
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(
                        2,
                        index.isEven ? 2.5 : 4,
                      ),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 10.0,
                    ),
            ),
          ],
        ),
      ));
    });
  }

  appBar() {
    return SubPageAppBar(title: AppStrings.favorites);
  }

  @override
  void onConnectionError(String error, String requestCode) {}

  @override
  void onError(String errorMsg, String requestCode) {}

  @override
  void onSuccess(object, String strMsg, String requestCode) {
    debugPrint("=====");
    debugPrint(object.toString());
    favoritesList.addAll(object);

    isLoading = false;
    setState(() {});
  }
}
