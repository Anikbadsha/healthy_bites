import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/order_card.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

double Total_Price = 0;

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool Loading = false;
  bool waiting = true;

  TextEditingController table = TextEditingController();

  @override
  void initState() {
    Total_Price = 0;
    for (int i = 0; i < cart!.length; i++) {
      if (cart![i].discountPrice != null) {
        Total_Price +=
            double.parse(cart![i].discountPrice.toString()) * cart![i].qty;
      } else {
        Total_Price += double.parse(cart![i].price.toString()) * cart![i].qty;
      }
    }

    print(cart!.length.toString());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_me.main,
        title: Container(
            child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  width: 2 * SizeConfig.widthMultiplier!,
                  height: 8 * SizeConfig.heightMultiplier!,
                  child: Text(
                    "আমার কার্ট",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  )),
            ),
            GestureDetector(
              onTap: () {},
              child: Consumer<GetData>(
                builder: (content, data, child) {
                  return Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: <Widget>[
                          Stack(
                            children: [
                              Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                                size: 30,
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        cart!.length.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )))
                            ],
                          )
                        ],
                      ));
                },
              ),
            )
          ],
        )),
      ),
      body: Container(
          child: Stack(
        children: [
          ListView(
            children: <Widget>[
              Consumer<GetData>(
                builder: (content, data, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cart!.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return OrderCard(
                          image: main_url + cart![index].picture,
                          title: cart![index].productName,
                          count: cart![index].qty.toString(),
                          price: cart![index].discountPrice != null
                              ? cart![index].discountPrice.toString()
                              : cart![index].price.toString(),
                          inc: GestureDetector(
                            onTap: () {
                              setState(() {});
                              cart![index].qty = cart![index].qty + 1;
                              var restore_cart =
                                  Provider.of<GetData>(context, listen: false);
                              restore_cart.Restore_Item(index, cart![index].id);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 4 * SizeConfig.heightMultiplier!,
                                width: 8 * SizeConfig.widthMultiplier!,
                                color: Color_me.main,
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        fontSize:
                                            2.5 * SizeConfig.textMultiplier!,
                                        color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          dec: GestureDetector(
                            onTap: () {
                              setState(() {});
                              cart![index].qty = cart![index].qty - 1;
                              var restore_cart =
                                  Provider.of<GetData>(context, listen: false);
                              restore_cart.Restore_Item(index, cart![index].id);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 4 * SizeConfig.heightMultiplier!,
                                width: 8 * SizeConfig.widthMultiplier!,
                                color: Color_me.main,
                                child: Center(
                                  child: new Text(
                                    "-",
                                    style: TextStyle(
                                        fontSize:
                                            2.5 * SizeConfig.textMultiplier!,
                                        color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                var remove_item = Provider.of<GetData>(context,
                                    listen: false);
                                remove_item.Remove_item(index);
                              },
                            ),
                          ),
                        );
                      });
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 80),
              ),
            ],
          ),
          Bottom_Bar()
        ],
      )),
    );
  }

  Widget Bottom_Bar() {
    return Positioned(
        bottom: 0,
        height: 10 * SizeConfig.heightMultiplier!,
        child: Card(
          child: Consumer<GetData>(
            builder: (content, data, child) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "৳" + Total_Price.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "মোট",
                              style: TextStyle(
                                  color: Color_me.main,
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {});
                            prefs = await SharedPreferences.getInstance();
                            prefs!.setString(
                                'total_price', Total_Price.toString());

                            if (prefs!.containsKey('uid')) {
                              Navigator.of(context).pushNamed(PAYMENT_INFO);
                              /*Place_Order(date);*/
                            } else {
                              Navigator.pushNamed(context, LOGIN);
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                              alignment: Alignment.center,
                              height: 10 * SizeConfig.heightMultiplier!,
                              child: Text(
                                "চেকআউট",
                                style: TextStyle(
                                    color: Color_me.main,
                                    fontSize: 2.2 * SizeConfig.textMultiplier!,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        ));
  }
}
