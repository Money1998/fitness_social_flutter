import 'dart:io';

import 'package:flutter/material.dart';
import 'package:montage/utils/colors.dart';

class Utilities {
  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  static commonSizedBox(height) {
    return SizedBox(
      height: height,
    );
  }

  static loader() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(colorBackground),
      ),
    );
  }

  static showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.red,
                size: 30,
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(msg,
                      style: TextStyle(color: Colors.black, fontSize: 14))),
            ],
          ),
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
    ));
  }

  static showError(GlobalKey<ScaffoldState> scaffoldKey, String msg) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.red,
                size: 30,
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(
                msg,
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
            ],
          ),
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
    ));
  }

  static showSuccess(GlobalKey<ScaffoldState> scaffoldKey, String msg) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(
                msg,
                style: TextStyle(color: Colors.black, fontSize: 14),
              )),
            ],
          ),
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
    ));
  }

  static String getDeviceType(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return "Ios";
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      return "Android";
    }
  }

  // static Future<String> getDeviceToken(BuildContext context) async {
  //   final DeviceInfoPlugin deviceInfoPlugin=new DeviceInfoPlugin();
  //   if(Theme.of(context).platform==TargetPlatform.android){
  //     return await deviceInfoPlugin.androidInfo.then((deviceInfo)=>deviceInfo.androidId.toString());
  //   }else if(Theme.of(context).platform==TargetPlatform.iOS){
  //     return await deviceInfoPlugin.iosInfo.then((ss)=>ss.identifierForVendor.toString());
  //   }else{
  //     return "";
  //   }
  // }

  static Future<bool> isConnectedNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static loading(BuildContext context, {status = true}) {
    if (status) {
      AlertDialog alert = AlertDialog(
        backgroundColor: Colors.transparent,
        content: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color> (Color(0xff8B00FF)),)],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      Navigator.pop(context);
    }
  }

  static String durationFormat(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inMinutes)}:$twoDigitSeconds";
  }

}
