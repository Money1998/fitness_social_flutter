import 'dart:math';

import 'package:flutter/material.dart';
import 'package:montage/utils/colors.dart';

class WaveSlider extends StatefulWidget {
  final double initialBarPosition;
  final double barWidth;
  final int maxBarHight;
  final double width;
  WaveSlider({
    Key key,
    this.initialBarPosition = 0.0,
    this.barWidth = 5.0,
    this.maxBarHight = 30,
    this.width = 60.0,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => WaveSliderState();
}

class WaveSliderState extends State<WaveSlider> {
  List<int> bars = [];
  double barPosition;
  double barWidth;
  int maxBarHight;
  double width;

  int numberOfBars;

  void randomNumberGenerator() {
    Random r = Random();
    for (var i = 0; i < numberOfBars; i++) {
      bars.add(r.nextInt(maxBarHight - 10) + 10);
    }
  }
  updatePostion(position, max){
    var totalWidth = width + (barWidth * numberOfBars);
    var main = (max * 100) / totalWidth;
    barPosition =  ((position * totalWidth) / main) / 5;
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    barPosition = widget.initialBarPosition;
    barWidth = widget.barWidth;
    maxBarHight = widget.maxBarHight.toInt();
    width = widget.width;
    if (bars.isNotEmpty) bars = [];
    numberOfBars = width ~/ barWidth;
    randomNumberGenerator();
  }

  @override
  Widget build(BuildContext context) {
    int barItem = 0;
    return Center(
      child: Column(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: bars.map((int height) {
                Color color = barItem + 1 < barPosition / barWidth
                    ? HexColor('#8AF3FA')
                    : HexColor("#D8D8D8");
                barItem++;
                return Row(
                  children: <Widget>[
                    Container(
                      width: 1,
                      height: height.toDouble(),
                      color: Colors.transparent,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(1.0),
                          topRight: const Radius.circular(1.0),
                        ),
                      ),
                      height: height.toDouble(),
                      width: barWidth,
                    ),
                    Container(
                      width: 1,
                      height: height.toDouble(),
                      color: Colors.transparent,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
