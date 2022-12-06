import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/CustomDialog.dart';
import 'package:healthy_bites/Design/myfield.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:healthy_bites/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  bool check = true;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? token1;

  // void firebaseCloudMessaging_Listeners() {
  //   _firebaseMessaging.getToken().then((token) {
  //     print("token is " + token!);
  //     token1 = token;
  //     print("2nd ${token1!}");
  //     setState(() {});
  //   });
  // }

  void _toggle() {
    setState(() {
      check = !check;
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   firebaseCloudMessaging_Listeners();
  // }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: _height,
        width: _width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: _width,
                  height: 20 * SizeConfig.heightMultiplier!,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/slash.png",
                    height: 40 * SizeConfig.imageSizeMultiplier!,
                  ),
                ),
                Container(
                  width: _width,
                  child: MyField(
                    keyboardType: TextInputType.phone,
                    icon: Icons.phone,
                    preText: "+88",
                    label: "Phone Number",
                    textEditingController: phoneController,
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier!,
                ),
                Container(
                  width: _width,
                  child: MyField(
                    sicon: IconButton(
                      icon:
                          Icon(check ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        _toggle();
                      },
                    ),
                    icon: Icons.lock,
                    label: "Password",
                    textEditingController: passwordController,
                    obscureText: check ? true : false,
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier!,
                ),
                Container(
                  width: _width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: _width,
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, FORGET);
                            },
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: _width,
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, SIGNUP);
                            },
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier!,
                ),
                Login_Button()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Login_Button() {
    return GestureDetector(
      onTap: () async {
        try {
          if (_formKey.currentState!.validate()) {
            GO();
          } else {
            Flushbar(
                flushbarPosition: FlushbarPosition.BOTTOM,
                isDismissible: false,
                duration: Duration(seconds: 3),
                messageText: Text(
                  "Please fill all box",
                  style: TextStyle(fontSize: 16.0, color: Colors.green),
                ))
              ..show(context);
          }
        } catch (e) {
          print(e);
        }

        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Color_me.main,
          /*border: Border.all(color: Color_me.grey,width: 2),*/
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        height: MediaQuery.of(context).size.height * 0.05,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void GO() async {
    var p = await request_Login();

    setState(() {});

    Map<String, dynamic> js = p;
    if (js.containsKey('error')) {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: Duration(seconds: 3),
          messageText: Text(
            p['error'],
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          ))
        ..show(context);
    } else {
      Navigator.of(context).pop();
      Store(p, context);
    }
  }

  Future request_Login() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new Customdialog());
    final response =
        await http.post(Uri.parse('$main_url/api/customer/login'), body: {
      'phone': phoneController.text,
      'password': passwordController.text,
      'token': token1,
    });
    print(response.body.toString());
    return json.decode(response.body);
  }

  Store(var mat, BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('uid', mat['data']['user_id'].toString());
    prefs!.setString('phone', mat['data']['phone'].toString());

    setState(() {});
    Navigator.of(context).pushNamed(HOME);
  }
}
