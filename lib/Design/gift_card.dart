import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/common_widget.dart';
import 'package:healthy_bites/Responsive/size_config.dart';

class CustomGiftCardPage extends StatefulWidget {
  final String? point;

  const CustomGiftCardPage({Key? key, this.point}) : super(key: key);

  @override
  _CustomGiftCardPageState createState() => new _CustomGiftCardPageState();
}

class _CustomGiftCardPageState extends State<CustomGiftCardPage> {
  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(1),
      body: Container(
        padding: MediaQuery.of(context).padding,
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier!,
            ),
            Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  height: _deviceHeight / 3.5,
                  width: _deviceWidth / 1.3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(0, 0))
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: Color_me.main,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/Healthy-Bites-white-transparent.png",
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      ClipPath(
                        clipper: CardClipPathFront(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: ClipPath(
                          clipper: CardClipPathBack(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                "????????? ????????????",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Expanded(
                              child: setCommonText(widget.point!, Colors.grey,
                                  18.0, FontWeight.w600, 1),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            opacityContanier(context, 25, 0.5),
            opacityContanier(context, 45, 0.3),
            opacityContanier(context, 65, 0.1),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier!,
            ),
            Text(
              "Gift cards for each \n and every one",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 3 * SizeConfig.heightMultiplier!,
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Your customers can effortlessly use any \n major brand's gift card as",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 10,
              child: Text(
                "Browse Gift Cards",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget opacityContanier(
      BuildContext context, double padding, double opacity) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: opacity,
      child: new Container(
        width: _deviceWidth / 1.3 - padding,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class CardClipPathFront extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(0.0, size.height * 0.75);

    var firstControlPoint = Offset(size.width / 5, size.height - 30);
    var firstEndPoint = Offset(size.width / 2, size.height - 50.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 5 - 20), size.height - 75);
    var secondEndPoint = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CardClipPathBack extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(0.0, size.height * 0.70);

    var firstControlPoint = Offset(size.width / 6, size.height - 40);
    var firstEndPoint = Offset(size.width / 2 + 30, size.height * 0.6);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width * 0.5 - 60), size.height - 85);
    var secondEndPoint = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
