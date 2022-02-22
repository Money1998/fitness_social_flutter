import 'package:flutter/material.dart';
import 'package:montage/constants/app_strings.dart';
import 'package:montage/constants/assets_images.dart';
import 'package:montage/constants/router.dart';
import 'package:montage/customs/responsive_widget.dart';
import 'package:montage/utils/colors.dart';
import 'package:montage/utils/dimens.dart';
import 'package:montage/utils/text_styles.dart';
import 'package:montage/utils/utilites.dart';
import 'package:montage/views/common/common_sqaure_btn.dart';
import 'package:montage/customs/global_var.dart' as globals;
class GuidlineView04 extends StatefulWidget {
  @override
  _GuidlineView04State createState() => _GuidlineView04State();
}

class _GuidlineView04State extends State<GuidlineView04> {
  var selectedIndex = -1;
   final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<RadioModel> buttonData = new List<RadioModel>();
  commonSizedBox(height) {
    return SizedBox(
      height: height,
    );
  }

  padding(horizontal, Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: widget,
    );
  }

  @override
  void initState() {
    buttonData.add(new RadioModel(
        false, AppStrings.morning, 'Morning', AssetsImage.digitalClock));
    buttonData
        .add(new RadioModel(false, AppStrings.owl, 'Owl', AssetsImage.owlIc));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      scaffoldKey: scaffoldKey,
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(gradient: lightgradientBG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    commonSizedBox(paddingLarge*4),
                    // titleTxt(),
                  
                    subTitleText(),
                    commonSizedBox(paddingLarge*5),
                   
                    Column(
                      children: buttons(),
                    ),
                    commonSizedBox(paddingMedium + 4),
                  ],
                ),
              ),
              bottomButton(),
              commonSizedBox(paddingLarge * 2)
            ],
          ),
        );
      },
    );
  }

  buttons() {
    return List.generate(
      2,
      (index) {
        return InkWell(
          splashColor: colorPrimary,
          onTap: () {
            setState(() {
              buttonData.forEach((element) => element.isSelected = false);
              buttonData[index].isSelected = true;
              selectedIndex = index;
            });
          },
          child: Padding(
              padding: EdgeInsets.only(
                  right: paddingSmall, bottom: paddingSmall + 4),
              child: Button(buttonData[index])),
        );
      },
    );
  }

  titleTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: commonPadding * 3),
      child: Text(
        AppStrings.guidline04Titl,
        style: primaryLight(
          fontSize: textXLarge,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  subTitleText() {
    return padding(
      paddingLarge * 3,
      Text(
        'Are you morning person or a night owl?',
        style: primaryLight(fontSize: textLarge),
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  bottomButton() {
    return Column(
      children: [
        CommonButton(
          isleadIcon: false,
          leadIcon: AssetsImage.owlIc,
          isRightArrow: true,
          width: MediaQuery.of(context).size.width / 1.4,
          buttonText: AppStrings.next,
          onPressed: (){
            if(selectedIndex== -1){
              Utilities.showError(scaffoldKey, 'Please select option',);
            }else{
              globals.userType = buttonData[selectedIndex].buttonText;
               Navigator.pushNamed(context, RouteGuildlinePage05);
            }
           
          },
        ),
      ],
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;
  final String leadIcon;

  RadioModel(this.isSelected, this.buttonText, this.text, this.leadIcon);
}

class Button extends StatelessWidget {
  final RadioModel _item;
  Button(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(0.0),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _item.isSelected
              ? CommonButton(
                  backgroundColor: lightFonts,
                  isleadIcon: true,
                  leadIcon: _item.leadIcon,
                  isRightArrow: false,
                  width: MediaQuery.of(context).size.width / 1.4,
                  buttonText: _item.buttonText,
                )
              : CommonButton(
                  isleadIcon: true,
                  leadIcon: _item.leadIcon,
                  isRightArrow: false,
                  width: MediaQuery.of(context).size.width / 1.4,
                  buttonText: _item.buttonText,
                ),
        ],
      ),
    );
  }
}
