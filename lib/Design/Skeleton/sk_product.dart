import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkProduct extends StatefulWidget {
  @override
  _SkProductState createState() => _SkProductState();
}

class _SkProductState extends State<SkProduct> {
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
    return Container(
      width: _width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SkeletonWidget(),
            SkeletonWidget(),
            SkeletonWidget(),
            SkeletonWidget(),
            SkeletonWidget(),
            SkeletonWidget(),
            SkeletonWidget(),
            SkeletonWidget(),
            SkeletonWidget(),
          ],
        ),
      ),
    );
  }

  Widget SkeletonWidget() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: SkeletonAnimation(
          child: Container(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 10 * SizeConfig.heightMultiplier!,
                      width: 10 * SizeConfig.heightMultiplier!,
                      color: Colors.black12,
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.black12,
                                    width: _width,
                                    height: 1 * SizeConfig.heightMultiplier!,
                                  ),
                                  SizedBox(
                                    height: 1 * SizeConfig.heightMultiplier!,
                                  ),
                                  Container(
                                    color: Colors.black12,
                                    width: _width,
                                    height: 0.5 * SizeConfig.heightMultiplier!,
                                  ),
                                  SizedBox(
                                    height: 1 * SizeConfig.heightMultiplier!,
                                  ),
                                  Container(
                                    color: Colors.black12,
                                    width: _width,
                                    height: 0.5 * SizeConfig.heightMultiplier!,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 5 * SizeConfig.heightMultiplier!,
                                  width: 5 * SizeConfig.heightMultiplier!,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black12),
                                ))
                          ],
                        )))
              ],
            ),
          ),
        ));
  }
}
