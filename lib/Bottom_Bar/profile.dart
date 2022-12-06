import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/CustomDialog.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;

  @override
  void initState() {
    var fetch_profile = Provider.of<GetData>(context, listen: false);
    fetch_profile.get_point();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_me.main,
        title: Text(("প্রোফাইল")),
      ),
      body: Container(
          height: _height,
          width: _width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<GetData>(
                  builder: (content, data, child) {
                    return data.point != null
                        ? Container(
                            padding: EdgeInsets.all(10),
                            width: _width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 1 * SizeConfig.heightMultiplier!,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: _width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: _width,
                                            child: Row(
                                              children: [
                                                Icon(Icons.account_box),
                                                Expanded(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                          data.point['data']
                                                                  ['name']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 2.2 *
                                                                  SizeConfig
                                                                      .textMultiplier!),
                                                        )))
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              child: Text(
                                                "Change",
                                                style: TextStyle(
                                                    fontSize: 2.2 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    color: Colors.redAccent),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1 * SizeConfig.heightMultiplier!,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: _width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: _width,
                                            child: Row(
                                              children: [
                                                Icon(Icons.phone),
                                                Expanded(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                          data.point['data']
                                                                  ['phone']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 2.2 *
                                                                  SizeConfig
                                                                      .textMultiplier!),
                                                        )))
                                              ],
                                            ),
                                          )),
                                      Expanded(flex: 1, child: Container()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1 * SizeConfig.heightMultiplier!,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: _width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: _width,
                                            child: Row(
                                              children: [
                                                Icon(Icons.email),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      data.point['data']
                                                                  ['email'] !=
                                                              null
                                                          ? data.point['data']
                                                                  ['email']
                                                              .toString()
                                                          : "No Email Address",
                                                      style: TextStyle(
                                                          fontSize: 2.2 *
                                                              SizeConfig
                                                                  .textMultiplier!),
                                                    ))
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1 * SizeConfig.heightMultiplier!,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: _width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: _width,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 8 *
                                                      SizeConfig
                                                          .imageSizeMultiplier!,
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      data.point['data']
                                                                  ['address'] !=
                                                              null
                                                          ? data.point['data']
                                                                  ['address']
                                                              .toString()
                                                          : "No Address",
                                                      style: TextStyle(
                                                          fontSize: 2.2 *
                                                              SizeConfig
                                                                  .textMultiplier!),
                                                    ))
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1 * SizeConfig.heightMultiplier!,
                                ),
                              ],
                            ),
                          )
                        : Customdialog();
                  },
                ),
                Container(
                  color: Colors.black12,
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  width: _width,
                  child: Text(
                    "History",
                    style: TextStyle(
                        fontSize: 2.5 * SizeConfig.textMultiplier!,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: _width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier!,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        width: _width,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                  width: _width,
                                  child: Row(
                                    children: [
                                      Icon(Icons.history),
                                      Expanded(
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Order History",
                                                style: TextStyle(
                                                    fontSize: 2.2 *
                                                        SizeConfig
                                                            .textMultiplier!),
                                              )))
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, ORDERHISTORY);
                                  },
                                  child: Container(
                                    child: Text(
                                      "Browse",
                                      style: TextStyle(
                                          fontSize:
                                              2.2 * SizeConfig.textMultiplier!,
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier!,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
