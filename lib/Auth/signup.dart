import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
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

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  bool slider_click = false;
  bool click = false;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? token1;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // void firebaseCloudMessaging_Listeners() {
  //   _firebaseMessaging.getToken().then((token) {
  //     print("token is " + token!);
  //     token1 = token;
  //     print("2nd ${token1!}");
  //     setState(() {});
  //   });
  // }

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
          child: Column(
            children: [
              SizedBox(
                height: 7 * SizeConfig.heightMultiplier!,
              ),
              Container(
                width: _width,
                height: 20 * SizeConfig.heightMultiplier!,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/Healthy-Bites-bg.png",
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
              click == true
                  ? Container(
                      width: _width,
                      child: Column(
                        children: [
                          Container(
                            width: _width,
                            child: MyField(
                              keyboardType: TextInputType.phone,
                              icon: Icons.code,
                              label: "Otp",
                              textEditingController: otpController,
                            ),
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier!,
                          ),
                          Container(
                            width: _width,
                            child: MyField(
                              icon: Icons.lock,
                              label: "Password",
                              textEditingController: passwordController,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
              slider_click == false ? Send_Otp() : Register_Button()
            ],
          ),
        ),
      ),
    );
  }

  void GO(BuildContext context) async {
    var r = await request_Otp();

    try {
      Map<String, dynamic> js = r;
      if (js.containsKey('success')) {
        setState(() {
          slider_click = true;
          click = true;
        });
        Navigator.of(context).pop();

        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: Duration(seconds: 3),
            messageText: Text(
              r['success']['otp'],
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ))
          ..show(context);
      } else {
        Navigator.of(context).pop();
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: Duration(seconds: 3),
            messageText: Text(
              "Invalid Phone number",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ))
          ..show(context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: Duration(seconds: 3),
          messageText: Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          )).show(context);
    }
  }

  Widget Send_Otp() {
    return GestureDetector(
      onTap: () async {
        try {
          if (_formKey.currentState!.validate()) {
            GO(context);
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
            "Send Otp",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget Register_Button() {
    return GestureDetector(
      onTap: () async {
        try {
          if (_formKey.currentState!.validate()) {
            OK(context);
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
            "Sign Up",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future request_Otp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new Customdialog());
    final response =
        await http.post(Uri.parse('$main_url/api/customer/register'), body: {
      'phone': phoneController.text,
    });
    print(response.body.toString());
    return json.decode(response.body);
  }

  void OK(BuildContext context) async {
    var r = await request_signup();

    try {
      Map<String, dynamic> js = r;
      if (js.containsKey('data')) {
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: Duration(seconds: 3),
            messageText: Text(
              'success',
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ))
          ..show(context);

        Store(r, context);
      } else {
        Navigator.of(context).pop();
        Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            isDismissible: false,
            duration: Duration(seconds: 3),
            messageText: Text(
              "Invalid Information",
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ))
          ..show(context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: Duration(seconds: 3),
          messageText: Text(
            "Something went wrong",
            style: TextStyle(fontSize: 16.0, color: Colors.green),
          ))
        ..show(context);
    }
  }

  Future request_signup() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new Customdialog());
    final response =
        await http.post(Uri.parse('$main_url/api/customer/otp'), body: {
      'phone': phoneController.text,
      'otp': otpController.text,
      'password': passwordController.text!,
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
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HOME, (Route<dynamic> route) => false);
  }
}
