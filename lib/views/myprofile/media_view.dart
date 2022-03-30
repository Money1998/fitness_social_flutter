import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:montage/api/ApiInterface.dart';
import 'package:montage/api/RequestCode.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/custom_page_route.dart';
import 'package:montage/customs/custom_subpage_appBar.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/db/db_helper.dart';
import 'package:montage/db/post_model.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/views/audio/audio_list.dart';

class MediaView extends StatefulWidget {
  @override
  _MediaViewState createState() => _MediaViewState();
}

class _MediaViewState extends State<MediaView> implements ApiCallBacks {
  Future<List<Post>> posts;
  DBHelper dbHelper;

  @override
  void initState() {
    dbHelper = DBHelper();
    posts = dbHelper.getPosts();
    debugPrint("post " + posts.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, constraints) {
      return SafeArea(
          child: Container(
        color: colorBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            appBar(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: paddingSmall * 2, right: paddingSmall * 2),
                child: FutureBuilder(
                  future: posts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return generateList(snapshot.data);
                    }
                    if (snapshot.data == null || snapshot.data.length == 0) {
                      return Center(
                        child: Text(
                          "No item found",
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ));
    });
  }

  ListView generateList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(CustomPageRoute(child: AudioList(posts[index].id)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: CachedNetworkImageProvider(
                        RequestCode.apiEndPoint + posts[index].image),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    // color: Color.fromRGBO(255, 255, 255, 0.6),
                    colorBlendMode: BlendMode.modulate,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posts[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: primarySemiBold(
                            fontSize: textMedium + 1,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Text(
                          posts[index].status + " Tracks",
                          style: primarySemiBold(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  appBar() {
    return SubPageAppBar(title: AppStrings.lastViewed);
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
    // TODO: implement onSuccess
  }
}
