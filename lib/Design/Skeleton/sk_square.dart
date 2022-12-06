import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkSquare extends StatefulWidget {
  @override
  _SkSquareState createState() => _SkSquareState();
}

class _SkSquareState extends State<SkSquare> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SkeletonWidget(),
            ),
            Expanded(
              child: SkeletonWidget(),
            ),
            Expanded(
              child: SkeletonWidget(),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SkeletonWidget(),
            ),
            Expanded(
              child: SkeletonWidget(),
            ),
            Expanded(
              child: SkeletonWidget(),
            ),
          ],
        ),
      ],
    );
  }

  Widget SkeletonWidget() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SkeletonAnimation(
          child: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 13 * SizeConfig.heightMultiplier!,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 13 * SizeConfig.heightMultiplier!,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier!,
            ),
            Container(
              height: 1 * SizeConfig.heightMultiplier!,
              width: _width,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            )
          ],
        ),
      )),
    );
  }
}
