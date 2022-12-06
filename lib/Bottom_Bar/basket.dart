import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/Skeleton/sk_product.dart';
import 'package:healthy_bites/Design/grocerycard.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:provider/provider.dart';

class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;

  @override
  void initState() {
    var fetch_offer = Provider.of<GetData>(context, listen: false);
    fetch_offer.get_offer();
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
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.all(10),
        child: Consumer<GetData>(
          builder: (content, data, child) {
            return ListView(
              children: [
                Container(
                  width: _width,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "অফারের পন্য",
                    style: TextStyle(
                        fontSize: 2.3 * SizeConfig.textMultiplier!,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                data.offerClass != null
                    ? ListView.builder(
                        itemCount: data.offerClass!.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GroceryCard(
                            title: data.offerClass!.data![index].productName !=
                                    null
                                ? data.offerClass!.data![index].productName
                                : "No Data",
                            weight:
                                data.offerClass!.data![index].attribute != null
                                    ? data.offerClass!.data![index].attribute
                                        .toString()
                                    : "No Data",
                            delivery: data.offerClass!.data![index]
                                        .discountPrice !=
                                    null
                                ? data.offerClass!.data![index].discountPrice
                                    .toString()
                                : data.offerClass!.data![index].price
                                    .toString(),
                            discount: data.offerClass!.data![index]
                                        .discountPrice !=
                                    null
                                ? data.offerClass!.data![index].price.toString()
                                : "",
                            img: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  DESCRIPTION,
                                  arguments: data.offerClass!.data![index],
                                );
                              },
                              child: Container(
                                height: 15 * SizeConfig.heightMultiplier!,
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                            data.offerClass!.data![index]
                                                        .picture !=
                                                    null
                                                ? main_url +
                                                    data.offerClass!
                                                        .data![index].picture
                                                        .toString()
                                                : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                                          ))

                                      /* image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      widget.img,
                                    ))*/

                                      ),
                                ),
                              ),
                            ),
                            child: data.offerClass!.data![index].qty! > 0
                                ? Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {});
                                            data.offerClass!.data![index].qty =
                                                data.offerClass!.data![index]
                                                        .qty! -
                                                    1;
                                            var restore_cart =
                                                Provider.of<GetData>(context,
                                                    listen: false);
                                            restore_cart.Restore_Item(
                                                index,
                                                data.offerClass!.data![index]
                                                    .id!);
                                          },
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            color: Color_me.main,
                                            size: 9 *
                                                SizeConfig.imageSizeMultiplier!,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              1 * SizeConfig.widthMultiplier!,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            height: 4 *
                                                SizeConfig.heightMultiplier!,
                                            width: 12 *
                                                SizeConfig.widthMultiplier!,
                                            color: Colors.white,
                                            child: Center(
                                              child: Text(
                                                data.offerClass!.data![index]
                                                    .qty
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 2 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              1 * SizeConfig.widthMultiplier!,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {});
                                            data.offerClass!.data![index].qty =
                                                data.offerClass!.data![index]
                                                        .qty! +
                                                    1;
                                            var restore_cart =
                                                Provider.of<GetData>(context,
                                                    listen: false);
                                            restore_cart.Restore_Item(
                                                index,
                                                data.offerClass!.data![index]
                                                    .id!);
                                          },
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: Color_me.main,
                                            size: 9 *
                                                SizeConfig.imageSizeMultiplier!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        data.offerClass!.data![index].qty = 1;
                                      });
                                      var add_cart = Provider.of<GetData>(
                                          context,
                                          listen: false);
                                      add_cart.Add_To_Cart(
                                          data.offerClass!.data![index]);
                                    },
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Color_me.main,
                                      size: 9 * SizeConfig.imageSizeMultiplier!,
                                    ),
                                  ),
                          );
                        })
                    : SkProduct()
              ],
            );
          },
        ),
      ),
    );
  }
}
