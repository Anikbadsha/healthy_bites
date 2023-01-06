import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/main.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (prefs!.containsKey('user_id')) {
      /*prefs = await SharedPreferences.getInstance();
      prefs.setString('version', data['data']['version'].toString());*/
    } else {
      /*prefs = await SharedPreferences.getInstance();
      prefs.setString('version', data['data']['version'].toString());*/
      Navigator.of(context).pushReplacementNamed(HOME);
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();

    // _checkVersion();

    SharedPreferences.getInstance().then((pr) {
      prefs = pr;
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
  }

  _checkVersion() async {
    final newVersion = NewVersion(
      androidId: "com.asif.angobazar",
    );
    final status = await newVersion.getVersionStatus();

    if (status!.localVersion != status.storeVersion) {
      newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: 'নতুন আপডেট!!!',
          dialogText: 'নতুন সংযোজন পেতে এপ আপডেট করুন।',
          updateButtonText: 'আপডেট',
          allowDismissal: false);
    } else {
      startTime();
    }

    print(status.localVersion);
    print("Store " + status.storeVersion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag,
                color: Color_me.main,
                size: 60,
              ),
              Center(
                child: Text(
                  "Healthy Bites",
                  style: TextStyle(
                      color: Color_me.main,
                      fontWeight: FontWeight.w700,
                      fontSize: 35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
