import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';

class CustomBottomDialog extends StatelessWidget {

  final void Function(String) onOptionPressed;
  final String title;
  final List<String> options;


  CustomBottomDialog({this.onOptionPressed, this.title, this.options});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              children: [
                Container(
                  margin: EdgeInsets.only(left:paddingLarge+2,right: paddingLarge+2,bottom: paddingLarge+4),
                  decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius: BorderRadius.circular(paddingSmall)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(paddingMedium+2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // To make the card compact
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff0f0f0),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.close,color: colorOnBackground,size: iconSize/2,),
                                  padding: EdgeInsets.all(
                                      paddingSmall/2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: paddingMedium+4),
                          child: Text(
                            title,
                            style: onBackgroundBold(fontSize: textMedium+2),
                          ),
                        ),
                        for (var item in options)
                          optionButton(context,item,onOptionPressed)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget optionButton(BuildContext context,String option,void Function(String) onOptionPressed){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingLarge+6),
      child: Column(
       children: [
         Container(height: 0.5,color: colorBorder,),
         Material(
           child: InkWell(
             onTap: (){
               onOptionPressed(option);
             },
             child: Container(
               width: MediaQuery.of(context).size.width,
               padding: const EdgeInsets.symmetric(vertical: paddingMedium+4),
               child: Center(child: Text(option,style: onBackgroundMedium(fontSize: textSmall+2),)),
             ),
           ),
         )
       ],
      ),
    );
  }
}
