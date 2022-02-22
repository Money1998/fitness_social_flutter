// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:montage/utils/colors.dart';
// import 'package:montage/utils/dimens.dart';
// import 'package:montage/utils/text_styles.dart';

// import 'button_regular.dart';

// class CustomMessageDialog extends StatelessWidget {
//   final void Function(String) onOptionPressed;
//   final String title;
//   final RichText message;
//   final String button1Text;
//   final String button2Text;
//   final bool isCloseVisible;
//   final bool showBottom;
//   final String image;
//   final double margin;
//   final double imageSize;
//   CustomMessageDialog({this.onOptionPressed, this.title, this.message,
//       this.button1Text, this.button2Text,this.isCloseVisible = true,this.showBottom = false,this.image,this.margin,this.imageSize});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: dialogContent(context),
//     );
//   }

//   Widget dialogContent(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
     
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//         child: Container(
//           color: Colors.black.withOpacity(0.3),
//           child: Align(
//             alignment:showBottom == true?Alignment.bottomCenter:Alignment.center,
//             child: Wrap(
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(margin == null ?paddingLarge:margin),
//                   decoration: BoxDecoration(
//                       color: colorBackground,
//                       borderRadius: BorderRadius.circular(paddingSmall)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left:paddingMedium+4,right:paddingMedium+4,top:paddingSmall,bottom:paddingSmall),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       // To make the card compact
//                       children: <Widget>[
//                         isCloseVisible ?
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Material(
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: colorBackgroundgrey,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Icon(
//                                     Icons.close,
//                                     color: colorOnBackground,
//                                     size: iconSize / 2,
//                                   ),
//                                   padding: EdgeInsets.all(paddingSmall / 2),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ):Container(),
                        
//                         SizedBox(
//                           height: isCloseVisible ?paddingMedium-4:paddingSmall*2.5,
//                         ),
//                         image != null ?
//                         SvgPicture.asset(
//                           image,
//                           height:imageSize == null? iconButtonSize:imageSize,
//                           width: imageSize == null ?iconButtonSize:imageSize,
//                         ):Container(),
//                         SizedBox(
//                           height:image != null? paddingLarge:0,
//                         ),
//                         Text(
//                           title,
//                           style: onBackgroundBold(fontSize: textMedium-2),
//                         ),
//                         SizedBox(
//                           height: paddingMedium,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: paddingLarge*2.9),
//                           child: message,
//                         ),
//                         SizedBox(
//                           height: paddingMedium*2,
//                         ),
//                         Center(
//                           child: ButtonRegular(
//                             onPressed: () {
//                               onOptionPressed("1");
//                             },
//                             buttonText: button1Text,
//                             fontSize: textSmall+4,
//                             padding: paddingLarge*1.5,
//                           ),
//                         ),
//                         SizedBox(
//                           height:  button2Text.isNotEmpty ?paddingVerySmall:paddingVerySmall*2,
//                         ),
//                         button2Text.isNotEmpty
//                             ? Material(
//                                 child: InkWell(
//                                   onTap: () {
//                                     onOptionPressed("2");
//                                   },
//                                   child: Container(
//                                     width: MediaQuery.of(context).size.width-10,
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: paddingMedium),
//                                     child: Center(
//                                         child: Text(
//                                       button2Text,
//                                       style: onBackgroundMedium(fontSize:textSmall+2),
//                                     )),
//                                   ),
//                                 ),
//                               )
//                             : Container(),
                            
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
