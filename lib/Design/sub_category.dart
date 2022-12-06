import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bites/Design/common_widget.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';

class SubCategoryPlate extends StatefulWidget {
  final String? title;
  final String? rating;

  //final String status;
  final String? img;
  final String? other;
  final String? delivery;

  final Color? customColor;

  const SubCategoryPlate({
    Key? key,
    this.title,
    this.rating,
    // @required this.status,
    this.img,
    this.other,
    this.delivery,
    this.customColor,
  }) : super(key: key);

  @override
  _SubCategoryPlateState createState() => _SubCategoryPlateState();
}

class _SubCategoryPlateState extends State<SubCategoryPlate> {
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
    return Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 13 * SizeConfig.heightMultiplier!,
                width: 13 * SizeConfig.heightMultiplier!,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black12,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(widget.img!))),
                /*child: Image.network(
                  widget.img,
                  height: 17 * SizeConfig.imageSizeMultiplier,
                ),*/
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  height: _height,
                  width: _width,
                  child:
                      /*Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),*/
                      setCommonText(widget.title!, Colors.black, 14.0,
                          FontWeight.w500, 1),
                ))
          ],
        ));
  }
}
