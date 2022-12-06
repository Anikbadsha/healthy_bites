import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/CustomDialog.dart';
import 'package:healthy_bites/Design/common_widget.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  double? _height, _width;
  double? _pixelRatio;
  bool large = false;
  bool medium = false;

  @override
  void initState() {
    var fetch_offer = Provider.of<GetData>(context, listen: false);
    fetch_offer.get_notification();
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
    return Scaffold(body: Consumer<GetData>(
      builder: (content, data, child) {
        return Container(
          height: _height,
          width: _width,
          child: data.notificatonModel != null
              ? ListView.builder(
                  itemCount: data.notificatonModel!.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black12))),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          width: _width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset("assets/announce.png")),
                              ),
                              Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Container(
                                      width: _width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: setCommonText(
                                                data.notificatonModel!
                                                    .data![index].date
                                                    .toString(),
                                                Color_me.main,
                                                18.0,
                                                FontWeight.w500,
                                                1),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: setCommonText(
                                                data.notificatonModel!
                                                    .data![index].message
                                                    .toString(),
                                                Colors.black,
                                                18.0,
                                                FontWeight.w300,
                                                1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Customdialog(),
        );
      },
    ));
  }
}
