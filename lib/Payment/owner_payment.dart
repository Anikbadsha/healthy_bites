import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Payment/Successfully.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:provider/provider.dart';

class OwnerPayment extends StatefulWidget {
  @override
  _OwnerPaymentState createState() => _OwnerPaymentState();
}

class _OwnerPaymentState extends State<OwnerPayment> {
  List<String> p_type = ['bKash', 'Nagad', 'Rocket'];
  String _selectedtype = "bKash";

  List<String> month = ['1', '3', '6'];
  String _selectedmonth = "1";

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextStyle textStyle = TextStyle(
      color: Colors.black, fontSize: 1.5 * SizeConfig.textMultiplier!);

  TextEditingController bkash_number = TextEditingController();
  TextEditingController bkash_tnx_id = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_me.main,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 3 * SizeConfig.heightMultiplier!,
                ),
                SizedBox(
                    height: 3 * SizeConfig.heightMultiplier!,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Color_me.main,
                        ),
                        Text(
                          "You have to clear your Payment",
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 2 * SizeConfig.textMultiplier!),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 3 * SizeConfig.heightMultiplier!,
                ),
                Row(
                  children: [
                    Expanded(child: payment_type()),
                    Expanded(child: /*expire_month(),*/ Container())
                  ],
                ),
                _selectedtype == "bKash"
                    ? paymentCard("assets/bKash.png")
                    : _selectedtype == "Nagad"
                        ? paymentCard("assets/nagad.jpg")
                        : paymentCard("assets/rocket.jpg"),
                SizedBox(
                  height: 5 * SizeConfig.heightMultiplier!,
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
                          Navigator.of(context).pop();
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SuccessfullyPage()));
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
                /*  submit()*/
              ],
            ),
          )),
    );
  }

/*  Widget expire_month() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 6 * SizeConfig.heightMultiplier,
      */ /*decoration: BoxDecoration(
        border: Border.all(color: Color_me.grey,width: 1),
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),
        ),
      ),*/ /*

      width: MediaQuery.of(context).size.width,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              borderSide: BorderSide(color: Color(0xffE50000), width: 1),
            )),
        isExpanded: true,
        value: _selectedmonth,
        hint: Text("Expire Month"),
        onChanged: (new_value) {
          setState(() {
            _selectedmonth = new_value;
            print(_selectedmonth);
          });
          */ /* print((pay_type.indexOf(_selectedMbank)+1).toString());
          type = (pay_type.indexOf(_selectedMbank)+1).toString();*/ /*
        },
        items: month.map((e) {
          return DropdownMenuItem(
            child: Text(e + " month"),
            value: e,
          );
        }).toList(),
      ),
    );
  }*/

  Widget payment_type() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 8 * SizeConfig.heightMultiplier!,
      decoration: BoxDecoration(
        // border: Border.all(color: Color_me.grey, width: 1),
        borderRadius: const BorderRadius.all(
          const Radius.circular(1.0),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              borderSide: BorderSide(color: Color(0xffE50000), width: 1),
            )),
        isExpanded: true,
        alignment: Alignment.center,
        value: _selectedtype,
        hint: Text("Payment Type"),
        onChanged: (new_value) {
          setState(() {
            _selectedtype = new_value!;
            print(_selectedtype);
          });
          /* print((pay_type.indexOf(_selectedMbank)+1).toString());
          type = (pay_type.indexOf(_selectedMbank)+1).toString();*/
        },
        items: p_type.map((e) {
          return DropdownMenuItem(
            child: Text(e),
            value: e,
          );
        }).toList(),
      ),
    );
  }

  Widget submit() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          /* GO(context);*/
        });
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
            "Create",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
                fontSize: 14,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget paymentCard(String img) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 1 * SizeConfig.heightMultiplier!,
            ),
            Container(
              height: 8 * SizeConfig.heightMultiplier!,
              child: Image.asset(img),
            ),
            SizedBox(
              height: 1 * SizeConfig.heightMultiplier!,
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.topLeft,
              child: Text(
                _selectedtype.toString(),
                style: TextStyle(
                    fontSize: 2 * SizeConfig.textMultiplier!,
                    fontWeight: FontWeight.w700,
                    color: Color_me.main),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.left,
                text: new TextSpan(
                  text:
                      'Please complete your payment at first then fillup the form bellow.Also note ',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'Total amount you need to send us at ',
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "৳ " + "1000",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Container(
              child: Text(
                _selectedtype.toString() + " personal number: 01634330813",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              margin: EdgeInsets.only(top: 5),
              color: Colors.grey,
              child: TextFormField(
                controller: bkash_number,
                style: textStyle,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'bkash_number required';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black.withAlpha(150),
                    ),
                    errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 1.5 * SizeConfig.textMultiplier!),
                    hintText: '017XXXXXXXX',
                    labelText: 'Account_number'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              margin: EdgeInsets.only(top: 5),
              color: Colors.grey,
              child: TextFormField(
                controller: bkash_tnx_id,
                style: textStyle,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'transaction_id required';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.sms,
                      color: Colors.black.withAlpha(150),
                    ),
                    errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 1.5 * SizeConfig.textMultiplier!),
                    hintText: '8N7A6D5EE7M',
                    labelText: 'transaction_id'),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
  void GO(BuildContext context) async {

    var r_data = await Request_Registration();

    Map<String, dynamic> js = r_data;
    if (js.containsKey("data")) {

      Navigator.of(context).pop();

      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: Duration(seconds: 3),
          messageText: Text("Payment Updated", style: TextStyle(fontSize: 16.0, color: Colors.green),
          )

      )..show(context);

      setState(() {});

     */ /* Navigator.of(context).pushNamedAndRemoveUntil(SIGNINPAGE, (Route<dynamic> route) => false);*/ /*





    } else {

      Flushbar(
          flushbarPosition: FlushbarPosition.BOTTOM,
          isDismissible: false,
          duration: Duration(seconds: 3),
          messageText: Text(r_data['data'], style: TextStyle(fontSize: 16.0, color: Colors.green),
          )

      )..show(context);



    }
  }*/

  /* Future Request_Registration() async {
    showDialog(
        context: context, barrierDismissible: false, child: Customdialog());

    Map<String, String> bodyFields = {
      'user_id': prefs.getString('res_id').toString(),
      'payment_type': _selectedtype.toString(),
      'payment_to': bkash_number.text.toString(),
      'transation': bkash_tnx_id.text.toString(),
      'expire_month': _selectedmonth.toString(),

    };

    Map<String, String> headers = { "Accept": "application/json"};

    var result;
    var uri = Uri.parse(main_url+"payment",);
    var request = new http.MultipartRequest("POST", uri)
      ..fields.addAll(bodyFields);
    request.headers.addAll(headers);


    var response = await request.send();
    //print(response.stream.toString());
    await response.stream.transform(utf8.decoder).listen((value) {
      result = value;
    });

    setState(() {});
    return json.decode(result);

    //PostResult p = await PostResult.connectToAPI(res_name.text, res_owner.text, res_email.text, res_phone.text, res_address.text, res_pass.text,file);
  }*/
}
