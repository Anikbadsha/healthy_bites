import 'package:flutter/material.dart';
import 'package:healthy_bites/Auth/login.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/gift_card.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/main.dart';
import 'package:provider/provider.dart';

class NavPoints extends StatefulWidget {
  @override
  _NavPointsState createState() => _NavPointsState();
}

class _NavPointsState extends State<NavPoints> {
  @override
  void initState() {
    if (prefs!.containsKey('uid')) {
      var fetch_point = Provider.of<GetData>(context, listen: false);
      fetch_point.get_point();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Points"),
        backgroundColor: Color_me.main,
      ),
      body: Consumer<GetData>(
        builder: (content, data, child) {
          return prefs!.containsKey('uid')
              ? Container(
                  child: data.point != null
                      ? CustomGiftCardPage(
                          point: data.point['data']['point'].toString(),
                        )
                      : Container())
              : LogIn();
        },
      ),
    );
  }
}
