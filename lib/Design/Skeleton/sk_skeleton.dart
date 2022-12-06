import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkCategory extends StatefulWidget {
  @override
  _SkCategoryState createState() => _SkCategoryState();
}

class _SkCategoryState extends State<SkCategory> {
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
              width: MediaQuery.of(context).size.width,
              height: 13 * SizeConfig.heightMultiplier!,
              decoration: BoxDecoration(
                  color: Colors.grey[300], shape: BoxShape.circle),
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
