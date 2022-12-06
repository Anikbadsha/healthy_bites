import 'dart:convert';
import 'dart:io';

import 'package:argon_buttons_flutter_fix/argon_buttons_flutter.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/CustomDialog.dart';
import 'package:healthy_bites/Design/common_widget.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/Order/order_cart.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:healthy_bites/main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Modal/area.dart';

class PaymentInfo extends StatefulWidget {
  @override
  _PaymentInfoState createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cuponController = TextEditingController();

  bool Loading = false;
  bool waiting = true;

  String? select_time;
  Data? selectedArea;

  String _selectedValue = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    var fetch_area = Provider.of<GetData>(context, listen: false);
    fetch_area.get_area();
    var fetch_time = Provider.of<GetData>(context, listen: false);
    fetch_time.get_time();

    var fetch_payment = Provider.of<GetData>(context, listen: false);
    fetch_payment.get_payment();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color_me.main,
        title: Text(
          "পেমেন্ট",
          style: TextStyle(color: Colors.white),
        ),
        /* iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),*/
      ),
      body: Container(
        color: Colors.black12,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "পন্যগুলো",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 16 * SizeConfig.heightMultiplier!,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: cart!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Card(
                                          child: Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        main_url +
                                                            cart![index]
                                                                .picture))),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              setCommonText(
                                                  cart![index].productName,
                                                  Colors.black,
                                                  16.0,
                                                  FontWeight.w300,
                                                  1),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              setCommonText(
                                                  "Quantity: " +
                                                      cart![index]
                                                          .qty
                                                          .toString(),
                                                  Colors.black54,
                                                  15.0,
                                                  FontWeight.w300,
                                                  1),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              setCommonText(
                                                  "Price: " +
                                                              cart![index]
                                                                  .discountPrice
                                                                  .toString() !=
                                                          null
                                                      ? cart![index]
                                                          .discountPrice
                                                          .toString()
                                                      : cart![index]
                                                              .price
                                                              .toString() +
                                                          "৳",
                                                  Colors.black54,
                                                  15.0,
                                                  FontWeight.w300,
                                                  1),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  )),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(6),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "ডেলিভারী তথ্য",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)
                                  /*image: DecorationImage(
                              image: NetworkImage(widget.img),
                              fit: BoxFit.cover
                          )*/
                                  ),
                              child: TextFormField(
                                controller: nameController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                enableInteractiveSelection: false,
                                autofocus: false,
                                textAlign: TextAlign.left,
                                decoration: new InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    labelText: "নাম",
                                    labelStyle: TextStyle(color: Colors.grey)

                                    /*contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),*/
                                    ),
                              ),
                            ),
                          ],
                        )),
                    Consumer<GetData>(
                      builder: (content, data, child) {
                        return data.area != null
                            ? Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0)),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButton<Data>(
                                    isExpanded: true,
                                    underline: Container(),
                                    value: selectedArea,
                                    hint: Text('এরিয়া বাচাই করুন'),
                                    items: data.area!.data!.map((e) {
                                      return DropdownMenuItem<Data>(
                                        child: Text(e.name!),
                                        value: e,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedArea = value;
                                        //print(selectedArea.id);
                                      });
                                    },
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)
                                  /*image: DecorationImage(
                              image: NetworkImage(widget.img),
                              fit: BoxFit.cover
                          )*/
                                  ),
                              child: TextFormField(
                                controller: addressController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                enableInteractiveSelection: false,
                                autofocus: false,
                                textAlign: TextAlign.left,
                                decoration: new InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    labelText: "ঠিকানা",
                                    labelStyle: TextStyle(color: Colors.grey)

                                    /*contentPadding:
                                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),*/
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, top: 5),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  /*"e.g. Level 8,House 68",*/
                                  "যেমন. লেভেল ৮,বাড়ি ৬৮",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        /*"Preferred Delivery Timings",*/
                        "সম্ভাব্য ডেলিভারী সময়",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: DatePicker(
                        DateTime.now(),
                        daysCount: 7,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors.black,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            _selectedValue =
                                DateFormat('yyyy-MM-dd').format(date);

                            print(_selectedValue.toString());
                          });
                        },
                      ),
                    ),
                    Consumer<GetData>(
                      builder: (content, data, child) {
                        return Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: data.timeRange != null
                              ? DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1.0)),
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color_me.main))),
                                  hint: Text(
                                    /*"Select Preffered Time",*/
                                    "সময় বাচাই করুণ",
                                  ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  items: data.timeRange!.data!.map((e) {
                                    return DropdownMenuItem<String>(
                                      child: Text(e),
                                      value: e,
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        select_time = val;

                                        print(select_time);
                                      },
                                    );
                                  },
                                )
                              : Container(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Consumer<GetData>(
                builder: (content, data, child) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "কার্টের আইটেম",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        data.data != null
                            ? Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "রশিদ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("সাবটোটাল"),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text("${Total_Price}BDT"),
                                          ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text("ডেলিভারী চার্জ"),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(double.parse(Total_Price
                                                        .toString()) <
                                                    double.parse(data.data[0][
                                                        'free_delivery_charge'])
                                                ? "${data.data[0]['delivery_charge']}BDT"
                                                : "0BDT"),
                                          ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Consumer<GetData>(
                                        builder: (content, data, child) {
                                      return Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text("ডিসকাউন্ট"),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.centerRight,
                                              child: data.cupon != null
                                                  ? Text(GetData.myCupon != null
                                                      ? data.cupon['data']
                                                          .toString()
                                                      : "0")
                                                  : Text("0"),
                                            ))
                                          ],
                                        ),
                                      );
                                    }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DottedLine(
                                      dashColor: Colors.black12,
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    DottedLine(
                                      dashColor: Colors.black12,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            child: Text(
                                              "মোট",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                          Expanded(
                                              child: Text(
                                            GetData.grand_total.toString() +
                                                "BDT",
                                            textAlign: TextAlign.end,
                                          ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Customdialog()
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 1)
                          /*image: DecorationImage(
                              image: NetworkImage(widget.img),
                              fit: BoxFit.cover
                          )*/
                          ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextFormField(
                              controller: cuponController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              enableInteractiveSelection: false,
                              autofocus: false,
                              textAlign: TextAlign.left,
                              decoration: new InputDecoration(
                                  prefixIcon: Icon(Icons.api_outlined),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  labelText: "কুপন এড করুন",
                                  labelStyle: TextStyle(color: Colors.grey)

                                  /*contentPadding:
                                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),*/
                                  ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {
                                  var fetch_cupon = Provider.of<GetData>(
                                      context,
                                      listen: false);
                                  fetch_cupon.get_cupon(cuponController.text
                                      .toString() /*"valentines2021"*/);
                                },
                                child: Text("এড"),
                              ))
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Bottom_sheet(_selectedValue.toString());
                      },
                      child: Card(
                        color: Colors.black,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Text(
                            "ক্যাশ অন ডেলিভারী",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        /*  Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: OwnerPayment(),
                              inheritTheme: true,
                              ctx: context),
                        );*/
                      },
                      child: Card(
                        color: Color_me.main,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Text(
                            "কার্ড পেমেন্ট",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void Bottom_sheet(String date) {
    showModalBottomSheet(
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
              topRight: const Radius.circular(20.0),
              topLeft: const Radius.circular(20.0),
            )),
            padding: EdgeInsets.all(10),
            height: 20 * SizeConfig.heightMultiplier!,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Confirm Order",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Please Confirm the order and we will Deliver Your Food On Time",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier!,
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Bottom_sheet(_selectedValue);
                          },
                          child: Card(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey,
                                ),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Text("Cancel"),
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                          child:
                              /*Card(
                          child: GestureDetector(
                            onTap: () {
                              if (prefs.containsKey('uid')) {
                                Place_Order(date);
                              } else {
                                Navigator.pushNamed(context, LOGIN);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color_me.main,
                              ),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Text(
                                "Confirm",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )*/

                              ArgonButton(
                            height: 40,
                            roundLoadingShape: true,
                            width: MediaQuery.of(context).size.width,
                            onTap: (startLoading, stopLoading, btnState) {
                              if (btnState == ButtonState.Idle) {
                                if (prefs!.containsKey('uid')) {
                                  startLoading();
                                  Place_Order(date);
                                } else {
                                  Navigator.pushNamed(context, LOGIN);
                                }
                              } else {
                                stopLoading();
                              }
                            },
                            child: setCommonText("Confirm", Colors.white, 18.0,
                                FontWeight.w700, 1),
                            loader: Container(
                              padding: EdgeInsets.all(10),
                              child: SpinKitRotatingCircle(
                                color: Colors.white,
                                // size: loaderWidth ,
                              ),
                            ),
                            borderRadius: 5.0,
                            color: Color_me.main,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

/*  void Bottom_sheet2(context) {
    showModalBottomSheet(
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
              topRight: const Radius.circular(20.0),
              topLeft: const Radius.circular(20.0),
            )),
            padding: EdgeInsets.all(10),
            height: 60 * SizeConfig.heightMultiplier,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Confirm Order",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  OwnerPayment(),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Bottom_sheet(_selectedValue);
                          },
                          child: Card(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey,
                                ),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Text("Cancel"),
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                            child: Card(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color_me.main,
                              ),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Text(
                                "Confirm",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }*/

  Change_State() {
    if (mounted) {
      setState(() {});
    }
  }

  Future Place_Order(String date) async {
    List product = [];

    for (int i = 0; i < cart!.length; i++) {
      product.add({
        "product_id": cart![i].id.toString(),
        "price": cart![i].price.toString(),
        "qty": cart![i].qty.toString(),
      });
    }

    var body = {
      "user_id": prefs!.getString('uid'),
      "area_id": selectedArea!.id.toString(),
      "name": nameController.text,
      "phone": prefs!.getString('phone'),
      "address": addressController.text,
      "sub_total": Total_Price.toString(),
      "shipping_charge": GetData.delivery_charge.toString(),
      "discount": GetData.myCupon != null ? GetData.myCupon.toString() : "0",
      "final_total": GetData.grand_total.toString(),
      "sale_date": date,
      "order_time": select_time.toString(),
      "products": product,
    };

    var response;
    response = await http.post(Uri.parse(main_url + "/api/order"),
        body: json.encode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        });

    print(response.body);
    var da = json.decode(response.body);
    Map<String, dynamic> js = da;
    Loading = false;
    Change_State();
    if (js.containsKey('data')) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Image.asset(
              "assets/success.gif",
              height: 35 * SizeConfig.imageSizeMultiplier!,
            ),
            content: Text(
              "Order Success",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color_me.main,
                  fontSize: 2.2 * SizeConfig.textMultiplier!,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins'),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: Text("Ok",
                    style: TextStyle(
                        fontSize: 2.2 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins')),
                onPressed: () {
                  cart!.clear();
                  cart_id!.clear();
                  Total_Price = 0;
                  /*Navigator.pushNamed(context, HOME);*/
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HOME, (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        },
      );
      cart!.clear();
      cart_id!.clear();
      prefs!.setString('cart', json.encode(cart));
      prefs!.setString('cart_id', json.encode(cart_id));
      Navigator.of(context).pop();
    }
  }
}
