// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:montage/constants/app_strings.dart';
// import 'package:montage/constants/assets_images.dart';
// import 'package:montage/constants/routing_constant.dart';
// import 'package:montage/constants/svg_images.dart';
// import 'package:montage/utils/colors.dart';
// import 'package:montage/utils/dimens.dart';
// import 'package:montage/utils/text_styles.dart';

// enum SidebarDrawerPages {
//   RouteHomeView,
//   RouteOcceanbuddyTabs,
//   RouteSEIconsView,
//   RouteOffersView,
//   RouteProductsView,
//   RouteMoanaPacificaView,
//   RouteNewsView,
//   RouteSettingsView,
//   LearningSharingView,
// }

// class SidebarDrawer extends StatelessWidget {
//   const SidebarDrawer({
//     Key key,
//     @required this.currentPage,
//   }) : super(key: key);

//   final SidebarDrawerPages currentPage;
//   // var commonSizedBox = SizedBox(height: paddingSmall,);
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       elevation: 20,
//       child: Material(
//         color: colorBackground,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     child: Center(
//                         child: Image.asset(
//                       AssetsImage.moana_logo,
//                       height: 120,
//                       width: 120,
//                     )),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   drawersRow(
//                     SvgImages.home,
//                     SvgImages.homeInctive,
//                     AppStrings.home,
//                     true,
//                     RouteHomeView,
//                     context,
//                     SidebarDrawerPages.RouteHomeView,
//                   ),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                   drawersRow(
//                     SvgImages.occeanBuddyActive,
//                     SvgImages.ocanBuddyInactive,
//                     'Ocean Buddy',
//                     false,
//                     RouteOcceanbuddyTabs,
//                     context,
//                     SidebarDrawerPages.RouteOcceanbuddyTabs,
//                   ),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                   drawersRow(
//                     SvgImages.santuaryElementActive,
//                     SvgImages.sanctuaryElement,
//                     'Sancutary Elements',
//                     false,
//                     RouteSEIconsView,
//                     context,
//                     SidebarDrawerPages.RouteSEIconsView,
//                   ),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                   drawersRow(
//                     SvgImages.moanaPasifikaActive,
//                     SvgImages.moanaPacifikaDisalbe,
//                     'Moana Pasifika',
//                     false,
//                     RouteMoanaPacificaView,
//                     context,
//                     SidebarDrawerPages.RouteMoanaPacificaView,
//                   ),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                   drawersRow(
//                     SvgImages.offerActive,
//                     SvgImages.offersInactive,
//                     'Offers',
//                     false,
//                     RouteOffersView,
//                     context,
//                     SidebarDrawerPages.RouteOffersView,
//                   ),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                   drawersRow(
//                     SvgImages.shopActive,
//                     SvgImages.shopInactive,
//                     'Shop',
//                     false,
//                     RouteProductsView,
//                     context,
//                     SidebarDrawerPages.RouteProductsView,
//                   ),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                   drawersRow(
//                     SvgImages.newsActive,
//                     SvgImages.news,
//                     AppStrings.news,
//                     false,
//                     RouteNewsTabView,
//                     context,
//                     SidebarDrawerPages.RouteNewsView,
//                   ),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                   drawersRow(
//                       SvgImages.settingActive,
//                       SvgImages.settings,
//                       AppStrings.settings,
//                       false,
//                       RouteSettingsView,
//                       context,
//                       SidebarDrawerPages.RouteSettingsView),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                   drawersRow(
//                       SvgImages.learnShareActive,
//                       SvgImages.learningAndSharing,
//                       'Learning and Sharing',
//                       false,
//                       null,
//                       context,
//                       SidebarDrawerPages.LearningSharingView),
//                   SizedBox(
//                     height: paddingSmall,
//                   ),
//                 ],
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget drawersRow(activeicon, inactiveIcon, menuTitle, bool active, navigatTo,
//       context, page) {
//     return InkWell(
//       onTap: () {
//         if (page == currentPage) {
//           Navigator.of(context).pop();
//           return;
//         }
//         Navigator.pushNamedAndRemoveUntil(context, navigatTo, (route) => false);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color:
//               currentPage == page ? colorPrimaryLightBorder : colorBackground,
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(8),
//             bottomRight: Radius.circular(8),
//           ),
//         ),
//         margin: EdgeInsets.only(
//           right: paddingSmall * 3,
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: paddingSmall * 2,
//             bottom: paddingSmall * 2,
//             left: paddingMedium,
//           ),
//           child: Row(
//             children: [
//               Container(
//                 height: iconSize - 5,
//                 width: iconSize - 5,
//                 child: SvgPicture.asset(
//                   currentPage == page ? activeicon : inactiveIcon,
//                   height: iconSize - 4,
//                   width: iconSize - 4,
//                 ),
//               ),
//               SizedBox(
//                 width: paddingSmall + 4,
//               ),
//               Text(
//                 menuTitle,
//                 style: onBackgroundMedium(fontSize: textSmall + 4),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
