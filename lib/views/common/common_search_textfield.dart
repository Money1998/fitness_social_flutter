// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:montage/constants/app_strings.dart';
// import 'package:montage/constants/svg_images.dart';
// import 'package:montage/utils/colors.dart';
// import 'package:montage/utils/dimens.dart';
// import 'package:montage/utils/text_styles.dart';


// class CommonSearchTextField extends StatelessWidget {
//   final Widget title;
//   final TextEditingController controller;
//   final Function(String) onChanged;
//   final Widget suffixIcon;
//   final String hintTxt;



//   CommonSearchTextField(
//       {this.title,
//       this.controller,
//       this.onChanged,
//       this.suffixIcon,
//       this.hintTxt,
//       Key key})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 38,
//       child: TextField(
//         controller: controller,
//         onChanged: onChanged,
//         decoration: new InputDecoration(
//             focusedBorder: OutlineInputBorder(
//                borderRadius: const BorderRadius.all(
//                 const Radius.circular(18.0),
//               ),
//               borderSide: BorderSide(
//                 color: colorBorder,
//                width: 1.3
//               ),
//             ),
//             disabledBorder: new OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: colorBorder,
//                 width: 1.3
//               ),
//               borderRadius: const BorderRadius.all(
//                 const Radius.circular(18.0),
//               ),
//             ),
//             enabledBorder: new OutlineInputBorder(
//               borderSide: BorderSide(
//                width: 1.3,
//                 color: colorBorder,
//               ),
//               borderRadius: const BorderRadius.all(
//                 const Radius.circular(18.0),
//               ),
//             ),
//             border: new OutlineInputBorder(
//               borderSide: BorderSide(
//                width: 1.3,
//                 color: colorBorder,
//               ),
//               borderRadius: const BorderRadius.all(
//                 const Radius.circular(18.0),
//               ),
//             ),
//             filled: true,
//             contentPadding: EdgeInsets.only(
//               left: paddingMedium+4,
             
//             ),
//             suffixIconConstraints: BoxConstraints(minHeight:smallIconSize,minWidth:smallIconSize*2.8),
//             suffixIcon: suffixIcon == null
//                 ? SvgPicture.asset(SvgImages.searchicon,height:smallIconSize-4,width:smallIconSize-4,color: Color(0xffc6c6c6),)
//                 : suffixIcon,
//             hintStyle: TextStyle(
//     fontSize: textSmall+2,
//    fontFamily: FontNameMedium,
//   color: Color(0xffc6c6c6),
//   ),
//             hintText:
//                 hintTxt == null ? AppStrings.searchSenctuaryElements : hintTxt,
//             fillColor: Colors.white70),
//       ),
//     );
//   }
// }
