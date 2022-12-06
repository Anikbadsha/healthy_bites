import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatefulWidget {
  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  int x = 1;

  var data;
  bool click = false;

  @override
  void initState() {
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

    data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_me.main,
        title: Container(
            child: Row(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Container(
                  alignment: Alignment.centerLeft,
                  width: 2 * SizeConfig.widthMultiplier!,
                  height: 8 * SizeConfig.heightMultiplier!,
                  child: Text(
                    data.productName,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  )),
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {});

                    Navigator.of(context).pushNamed(ORDER);
                  },
                  child: Consumer<GetData>(
                    builder: (content, data, child) {
                      return Container(
                          width: 20,
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
                                                color: Colors.white,
                                                fontSize: 12),
                                          )))
                                ],
                              )
                            ],
                          ));
                    },
                  ),
                ))
          ],
        )),
      ),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              height: _height,
              width: _width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    width: _width,
                    height: 40 * SizeConfig.heightMultiplier!,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                main_url + data.picture.toString()))),
                  ),
                  /*Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                            data.qty = data.qty - 1;
                            var restore_cart =
                                Provider.of<GetData>(context, listen: false);
                            restore_cart.Restore_Item(data, data.id);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 5 * SizeConfig.heightMultiplier,
                              width: 5 * SizeConfig.heightMultiplier,
                              color: Color_me.main,
                              child: Center(
                                child: new Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 2.5 * SizeConfig.textMultiplier,
                                      color: Colors.white70),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1 * SizeConfig.widthMultiplier,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 5 * SizeConfig.heightMultiplier,
                            width: 5 * SizeConfig.heightMultiplier,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                data.qty.toString(),
                                style: TextStyle(
                                    fontSize: 2.5 * SizeConfig.textMultiplier,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1 * SizeConfig.widthMultiplier,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {});

                            data.qty = data.qty + 1;
                            var restore_cart =
                                Provider.of<GetData>(context, listen: false);
                            restore_cart.Restore_Item(data, data.id);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 5 * SizeConfig.heightMultiplier,
                              width: 5 * SizeConfig.heightMultiplier,
                              color: Color_me.main,
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 2.5 * SizeConfig.textMultiplier,
                                      color: Colors.white70),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),*/
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.productName,
                          style: TextStyle(
                              fontSize: 2.5 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "৳" + data.price.toString(),
                          style: TextStyle(
                              fontSize: 2.3 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "বিবরণ",
                        style: TextStyle(
                            fontSize: 2.2 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: _width,
                        child: Html(
                          data: data.description.toString(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10 * SizeConfig.heightMultiplier!,
                  )
                ],
              )),
          Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    data.qty = x;
                    click = true;
                  });
                  var addCart = Provider.of<GetData>(context, listen: false);
                  addCart.Add_To_Cart(data);
                },
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    width: _width,
                    height: 8 * SizeConfig.heightMultiplier!,
                    child: click == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "কার্টে যোগ করুণ",
                                style: TextStyle(
                                    fontSize: 2.3 * SizeConfig.textMultiplier!,
                                    color: Colors.white),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {});

                                  if (data.qty <= 1) {
                                    click = false;
                                    setState(() {});
                                  }

                                  data.qty = data.qty - 1;
                                  var restoreCart = Provider.of<GetData>(
                                      context,
                                      listen: false);
                                  restoreCart.Restore_Item(
                                      data.hashCode, data.id);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 5 * SizeConfig.heightMultiplier!,
                                    width: 5 * SizeConfig.heightMultiplier!,
                                    color: Color_me.main,
                                    child: Center(
                                      child: new Text(
                                        "-",
                                        style: TextStyle(
                                            fontSize: 2.5 *
                                                SizeConfig.textMultiplier!,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 1 * SizeConfig.widthMultiplier!,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 5 * SizeConfig.heightMultiplier!,
                                  width: 5 * SizeConfig.heightMultiplier!,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      data.qty.toString(),
                                      style: TextStyle(
                                          fontSize:
                                              2.5 * SizeConfig.textMultiplier!,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 1 * SizeConfig.widthMultiplier!,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {});

                                  data.qty = data.qty + 1;
                                  var restoreCart = Provider.of<GetData>(
                                      context,
                                      listen: false);
                                  restoreCart.Restore_Item(
                                      data.hashCode, data.id);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 5 * SizeConfig.heightMultiplier!,
                                    width: 5 * SizeConfig.heightMultiplier!,
                                    color: Color_me.main,
                                    child: Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                            fontSize: 2.5 *
                                                SizeConfig.textMultiplier!,
                                            color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
              ))
        ],
      ),
    );
  }
}
