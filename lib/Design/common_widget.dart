import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

var direction = TextDirection.ltr;

//This is the common function which works whole application, which set Text with different font and color.
setCommonText(String title, dynamic color, dynamic fontSize, dynamic fontweight,
    dynamic noOfLine) {
  return AutoSizeText(
    title,
    textDirection: direction,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontweight,
    ),
    maxLines: noOfLine,
    overflow: TextOverflow.ellipsis,
    wrapWords: true,
  );
}

showSnackbar(String value, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 15),
      content: Row(
        children: [
          SizedBox(
            child: CircularProgressIndicator(),
            height: 25.0,
            width: 25.0,
          ),
          SizedBox(width: 15),
          new Expanded(
              child:
                  setCommonText(value, Colors.white, 17.0, FontWeight.w500, 2))
        ],
      )));
}

setHeight(double height) {
  return SizedBox(
    height: height,
  );
}

setWidth(double width) {
  return SizedBox(
    width: width,
  );
}

//This widget will display after payment success.

//This is the common textfield widgets which use whole app.

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(),
    );
  }
}

//This is for restaurant close
