import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/utils/colors.dart';

class CommonProfile extends StatelessWidget {
  final String userIcon;
  final double height;
  final double width;
  final double borderRaiuds;

  CommonProfile({
    @required this.userIcon,
    this.height,
    this.width,
    this.borderRaiuds,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(
          borderRaiuds == null ? 10.0 : borderRaiuds,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: colorTheme,
              width: 1.5,
            ),
          ),
          height: height == null ? 50 : height,
          width: width == null ? 50 : width,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: userIcon == ''
                  ? SvgPicture.asset(
                      SvgImages.searchIc,
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: CachedNetworkImageProvider(userIcon),
                      fit: BoxFit.cover,
                    )
              /*CachedNetworkImage(
                      imageUrl: userIcon,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ))*/
              ),
        ));
  }
}

// class CommonSanctuaryIcons extends StatelessWidget {
//   final String sanctuaryIcon;
//   final double height;
//   final double width;
//   // final double borderRaiuds;

//   CommonSanctuaryIcons({
//     @required this.sanctuaryIcon,
//     this.height,
//     this.width,
//     // this.borderRaiuds,
//   });

//   @override
//   Widget build(BuildContext context) {

//     return CachedNetworkImage(
//                     height:height == null ?60:height ,
//                     width: width == null  ?100:width,
//             imageUrl:sanctuaryIcon,
//             placeholder: (context, url) =>
//               Image.asset('',fit: BoxFit.cover,height: height == null ?200:height,width: width== null ?100:width,)
//           );
//   }
// }
