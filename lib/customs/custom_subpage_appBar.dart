import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';

class SubPageAppBar extends StatelessWidget {
  SubPageAppBar({
    @required this.title,
    this.onBackPress,
    this.actionIcons,
    this.appBarBGcolor,
  });
  final String title;
  Function onBackPress;
  final List<Widget> actionIcons;
  final Color appBarBGcolor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor:
            appBarBGcolor == null ? colorBackground : appBarBGcolor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 30, color: colorTheme),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0,
        actions: actionIcons ?? [],
        title: Text(
          title ?? '',
          style: themeFontRegular(fontSize: textMedium),
        ));
    // return Container(
    //   color:appBarBGcolor == null? colorBackground:appBarBGcolor,
    //   padding: EdgeInsets.only(
    //     top: paddingSmall+4,
    //     bottom: paddingSmall + 4,
    //     left: commonPadding,
    //     right: commonPadding,
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         children: [
    //           InkWell(
    //             onTap: (){
    //               Navigator.pop(context);
    //             },
    //           child:SvgPicture.asset(
    //             SvgImages.subPageBackArrowIc,
    //             height: iconSize-4,
    //             width: iconSize-4,
    //           ),),
    //           SizedBox(
    //             width: paddingSmall * 2,
    //           ),
    //           Text(
    //             title??'',
    //             style: themeFontRegular(fontSize: textMedium),
    //           )
    //         ],
    //       ),
    //       Row(children: actionIcons??[],)
    //     ],
    //   ),
    // );
  }
}
