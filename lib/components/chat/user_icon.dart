import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatUserIcon extends StatelessWidget {
  final int userId;

  final String url;

  // showeing user icon //
  ChatUserIcon({
    this.userId,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image(
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQEZrATmgHOi5ls0YCCQBTkocia_atSw0X-Q&usqp=CAU"))
      /*CachedNetworkImage(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQEZrATmgHOi5ls0YCCQBTkocia_atSw0X-Q&usqp=CAU',
        height: 50,
        width: 50,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
      )*/
      ,
    );
  }
}
