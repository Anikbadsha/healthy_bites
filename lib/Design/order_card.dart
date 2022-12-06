import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Responsive/size_config.dart';

class OrderCard extends StatefulWidget {
  final String? title;
  final String? price;
  //final String status;
  final String? image;
  final Widget? child;
  final String? count;
  final Widget? inc;
  final Widget? dec;
  //final Color customColor;

  const OrderCard({
    Key? key,
    @required this.title,
    @required this.price,
    // @required this.status,
    @required this.image,
    @required this.child,
    @required this.count,
    @required this.inc,
    @required this.dec,
    //this.customColor,
  }) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Image.network(widget.image!),
                )),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      widget.title!,
                      style: TextStyle(
                          color: Color_me.main,
                          fontFamily: "Poppins",
                          fontSize: 1.7 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "৳${widget.price}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 1.5 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.dec!,
                          SizedBox(
                            width: 1 * SizeConfig.widthMultiplier!,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 4 * SizeConfig.heightMultiplier!,
                              width: 12 * SizeConfig.widthMultiplier!,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  widget.count!,
                                  style: TextStyle(
                                      fontSize:
                                          2.5 * SizeConfig.textMultiplier!,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1 * SizeConfig.widthMultiplier!,
                          ),
                          widget.inc!,
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topRight,
                  child: widget.child,
                ))
          ],
        ),
      ),
    );
  }
}
