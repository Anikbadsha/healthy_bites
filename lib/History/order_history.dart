import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bites/Auth/login.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:healthy_bites/main.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;

  @override
  void initState() {
    if (prefs!.containsKey('uid')) {
      var fetch_history = Provider.of<GetData>(context, listen: false);
      fetch_history.get_history();
    }

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
        title: Text("Order History"),
      ),
      body: Consumer<GetData>(
        builder: (content, data, child) {
          return prefs!.containsKey('uid')
              ? Container(
                  height: _height,
                  width: _width,
                  child: data.orderList != null
                      ? ListView.builder(
                          itemCount: data.orderList!.data!.length,
                          itemBuilder: (context, index) {
                            return ExpandablePanel(
                              header: Container(
                                  padding: EdgeInsets.all(5),
                                  width: _width,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Order ID: #${data.orderList!.data![index].id}",
                                        style: TextStyle(
                                            fontSize: 2.5 *
                                                SizeConfig.textMultiplier!,
                                            color: Colors.orange),
                                      ),
                                      Text(
                                          data.orderList!.data![index]
                                              .paymentStatus
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                                2 * SizeConfig.textMultiplier!,
                                          )),
                                      Divider()
                                    ],
                                  )),
                              collapsed: Text(
                                "gtygfcrhtd",
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              expanded: Container(
                                  width: _width,
                                  child: Column(
                                    children: [
                                      Text(
                                        data.orderList!.data![index].name
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 2.5 *
                                                SizeConfig.textMultiplier!),
                                      ),
                                      Text(
                                        data.orderList!.data![index].phone
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 2.2 *
                                                SizeConfig.textMultiplier!),
                                      ),
                                      Text(
                                        data.orderList!.data![index].paymentType
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 2.2 *
                                                SizeConfig.textMultiplier!),
                                      ),
                                      SizedBox(
                                        height:
                                            2 * SizeConfig.heightMultiplier!,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(child: Container()),
                                          Expanded(
                                            child: Text(
                                              data.orderList!.data![index]
                                                  .saleDate
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            1 * SizeConfig.heightMultiplier!,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Status',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data.orderList!.data![index]
                                                  .orderStatus
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            1 * SizeConfig.heightMultiplier!,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Address',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data.orderList!.data![index].area
                                                      .toString() +
                                                  "," +
                                                  data.orderList!.data![index]
                                                      .address
                                                      .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            1 * SizeConfig.heightMultiplier!,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Shipping Charge',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data.orderList!.data![index]
                                                      .shippingCharge
                                                      .toString() +
                                                  "৳",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            1 * SizeConfig.heightMultiplier!,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Total Charge',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data.orderList!.data![index].total
                                                      .toString() +
                                                  "৳",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .textMultiplier!),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  )),
                              // tapHeaderToExpand: true,
                              // hasIcon: true,
                            );
                          })
                      : Container())
              : LogIn();
        },
      ),
    );
  }
}
