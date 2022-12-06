import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';

class ParentCategory extends StatefulWidget {
  final String? title;
  final String? rating;

  //final String status;
  final String? img;
  final String? other;
  final String? delivery;

  final Color? customColor;

  const ParentCategory({
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
  _ParentCategoryState createState() => _ParentCategoryState();
}

class _ParentCategoryState extends State<ParentCategory> {
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
    return Stack(
      children: [
        Container(
            height: large!
                ? 23 * SizeConfig.heightMultiplier!
                : (medium!
                    ? 23 * SizeConfig.heightMultiplier!
                    : 27 * SizeConfig.heightMultiplier!),
            child: Padding(
                padding: large!
                    ? EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20)
                    : (medium!
                        ? EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 20)
                        : EdgeInsets.only(left: 10, right: 10, bottom: 10)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: 17 * SizeConfig.heightMultiplier!,
                        width: 13 * SizeConfig.heightMultiplier!,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 13 * SizeConfig.heightMultiplier!,
                          width: 13 * SizeConfig.heightMultiplier!,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            //shape: BoxShape.circle,
                            border: Border.all(color: Color_me.main),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 13 * SizeConfig.heightMultiplier!,
                            width: 13 * SizeConfig.heightMultiplier!,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.img!))),
                            /*child: Image.network(
          widget.img,
          height: 17 * SizeConfig.imageSizeMultiplier,
        ),*/
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: _height,
                          width: _width,
                          child: Text(
                            widget.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ))
                  ],
                ))),
        Positioned.fill(
            child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.center,
            height: 35,
            width: 35,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Container(
              alignment: Alignment.center,
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color_me.main,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ))
      ],
    );
  }
}
