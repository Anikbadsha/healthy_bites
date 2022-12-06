import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bites/Design/common_widget.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';

class GroceryCard extends StatefulWidget {
  final String? title;

  //final String status;
  final Widget? img;
  final String? weight;
  final String? delivery;
  final String? discount;
  final Widget? child;

  /*final Color customColor;*/

  const GroceryCard({
    Key? key,
    @required this.title,
    // @required this.status,
    @required this.img,
    @required this.weight,
    @required this.delivery,
    @required this.child,
    @required this.discount,
    /*this.customColor,*/
  }) : super(key: key);

  @override
  _GroceryCardState createState() => _GroceryCardState();
}

class _GroceryCardState extends State<GroceryCard> {
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
        Padding(
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 9 * SizeConfig.heightMultiplier!,
                        width: 9 * SizeConfig.heightMultiplier!,
                        child: widget.img,
                      )),
                  Expanded(
                      flex: 4,
                      child: Container(
                          child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: setCommonText(
                                              widget.title!,
                                              Colors.black,
                                              16.0,
                                              FontWeight.w300,
                                              1),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: _width,
                                          alignment: Alignment.centerRight,
                                          child: setCommonText(
                                              widget.weight!,
                                              Colors.black,
                                              16.0,
                                              FontWeight.w300,
                                              1),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      children: [
                                        setCommonText(
                                            "৳ " + widget.delivery!,
                                            Colors.green,
                                            16.0,
                                            FontWeight.w600,
                                            1),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            widget.discount!,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 1.6 *
                                                  SizeConfig.textMultiplier!,
                                              fontWeight: FontWeight.w600,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: _width,
                                          alignment: Alignment.centerRight,
                                          child: widget.child,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )))
                ],
              ),
            )),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
