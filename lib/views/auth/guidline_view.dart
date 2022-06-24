import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/constants/svg_images.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/customs/textfield_custom.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/validate_types.dart';
import 'package:montage/customs/global_var.dart' as globals;
class GuidlineView extends StatefulWidget {
  @override
  _GuidlineViewState createState() => _GuidlineViewState();
}

class _GuidlineViewState extends State<GuidlineView> {
  TextEditingController nameController = TextEditingController();
  final GlobalKey<TextFieldCustomState> nameState =
      GlobalKey<TextFieldCustomState>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(gradient: gradientBG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello!",
                      style: onPrimarySemiBold(
                        fontSize: textLarge * 2,
                      ),
                    ),
                    SizedBox(
                      height: paddingLarge * 2,
                    ),
                    Text(
                      'What\s your name?',
                      style: primaryMedium(fontSize: textSmall + 2),
                    ),
                    SizedBox(
                      height: paddingMedium + 4,
                    ),
                    
                 
                    
                    Padding(
                      padding: const EdgeInsets.only(
                        left: paddingLarge,
                        right: paddingLarge,
                      ),
                      child: TextFieldCustom(
                          key: nameState,
                          controller: nameController,
                          hintText: 'Enter your name',
                          validateTypes: ValidateTypes.empty,
                          textInputType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          isName: true,
                          onNextPressed: (){
                               var isValid = true;
                              if (nameState.currentState
                                  .checkValidation(false)) {
                                isValid = false;
                              }
                              if (isValid) {
                                globals.userName = nameController.text;
                                Navigator.pushNamed(
                                    context, RouteGuildlinePage02);
                              }
                          },
                          ),
                    ),


                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, RouteGuildlinePage02);
                    //   },
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width/1.5,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: colorPrimary,width: 0.6),
                    //     ),
                    //     padding: EdgeInsets.only(
                    //       top: paddingMedium-2,
                    //       bottom: paddingMedium-2,
                    //       left: paddingLarge,
                    //       right: paddingLarge,
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Flexible(
                    //           child:
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text(
                    //                 'DAVID',
                    //                 style:
                    //                     primaryMedium(fontSize: textSmall),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         InkWell(
                    //               onTap: () {},
                    //               child: SvgPicture.asset(
                    //                 SvgImages.rightArrowIc,
                    //                 height: smallIconSize * 1.5,
                    //                 width: smallIconSize * 1.5,
                    //               )
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: paddingSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          SvgImages.swipIc,
                          height: smallIconSize,
                          width: smallIconSize,
                        ),
                        SizedBox(
                          width: paddingSmall,
                        ),
                        Text(
                          AppStrings.anotherRandomName,
                          style: primaryRegular(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 28.0,
                    backgroundColor: colorBackground,
                    child: Image.asset(
                      AssetsImage.logo,
                      height: smallIconSize * 2.5,
                      width: smallIconSize * 2.5,
                    ),
                  ),
                  // SvgPicture.asset(SvgImages.logoSvg,height:iconSize,width:iconSize),
                  // ),
                  SizedBox(
                    height: paddingSmall,
                  ),
                  Text(
                    AppStrings.poweredBy,
                    style: primaryRegular(),
                  ),
                  SizedBox(
                    height: paddingSmall * 2.5,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
