import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/Skeleton/sk_product.dart';
import 'package:healthy_bites/Design/common_widget.dart';
import 'package:healthy_bites/Design/grocerycard.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  var data;

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

    var get_product = Provider.of<GetData>(context, listen: false);

    if (data == null) {
      data = ModalRoute.of(context)!.settings.arguments;
      get_product.get_products(data.toString());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_me.main,
        title: Consumer<GetData>(
          builder: (content, data, child) {
            return data.productClass != null
                ? Container(
                    child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 2 * SizeConfig.widthMultiplier!,
                          height: 8 * SizeConfig.heightMultiplier!,
                          child: setCommonText(data.productClass!.data!.bnName!,
                              Colors.white, 18.0, FontWeight.w500, 1),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(ORDER);
                          },
                          child: Container(
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
                              )))
                    ],
                  ))
                : Container();
          },
        ),
      ),
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.all(10),
        child: Consumer<GetData>(
          builder: (cont, data, child) {
            return data.productClass != null
                ? ListView(
                    children: [
                      Container(
                        width: _width,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data.productClass!.data!.bnName!,
                          style: TextStyle(
                              fontSize: 2.3 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      ListView.builder(
                          itemCount: data.productClass!.data!.produucts!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return data.productClass!.data!.produucts![index]
                                        .status ==
                                    "Available"
                                ? GroceryCard(
                                    title: data
                                                .productClass!
                                                .data!
                                                .produucts![index]
                                                .productName !=
                                            null
                                        ? data.productClass!.data!
                                            .produucts![index].bnProductName
                                        : "No Data",
                                    weight: data.productClass!.data!
                                                .produucts![index].attribute !=
                                            null
                                        ? data.productClass!.data!
                                            .produucts![index].bnAttribute
                                            .toString()
                                        : "No Data",
                                    delivery: data
                                                .productClass!
                                                .data!
                                                .produucts![index]
                                                .discountPrice !=
                                            null
                                        ? data.productClass!.data!
                                            .produucts![index].bnDiscountPrice
                                            .toString()
                                        : data.productClass!.data!
                                            .produucts![index].bnPrice
                                            .toString(),
                                    discount: data
                                                .productClass!
                                                .data!
                                                .produucts![index]
                                                .discountPrice !=
                                            null
                                        ? data.productClass!.data!
                                            .produucts![index].bnPrice
                                        : "",
                                    img: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          DESCRIPTION,
                                          arguments: data.productClass!.data!
                                              .produucts![index],
                                        );
                                      },
                                      child: Container(
                                        height:
                                            15 * SizeConfig.heightMultiplier!,
                                        padding: EdgeInsets.all(10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: NetworkImage(
                                                    data
                                                                .productClass!
                                                                .data!
                                                                .produucts![
                                                                    index]
                                                                .picture !=
                                                            null
                                                        ? main_url +
                                                            data
                                                                .productClass!
                                                                .data!
                                                                .produucts![
                                                                    index]
                                                                .picture
                                                                .toString()
                                                        : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                                                  ))),
                                        ),
                                      ),
                                    ),
                                    child: data.productClass!.data!
                                                .produucts![index].qty! >
                                            0
                                        ? Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {});
                                                    data
                                                        .productClass!
                                                        .data!
                                                        .produucts![index]
                                                        .qty = data
                                                            .productClass!
                                                            .data!
                                                            .produucts![index]
                                                            .qty! -
                                                        1;
                                                    var restore_cart =
                                                        Provider.of<GetData>(
                                                            context,
                                                            listen: false);
                                                    restore_cart.Restore_Item(
                                                        index,
                                                        data
                                                            .productClass!
                                                            .data!
                                                            .produucts![index]
                                                            .id!);
                                                  },
                                                  child: Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Color_me.main,
                                                    size: 9 *
                                                        SizeConfig
                                                            .imageSizeMultiplier!,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    height: 4 *
                                                        SizeConfig
                                                            .heightMultiplier!,
                                                    width: 12 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                    color: Colors.white,
                                                    child: Center(
                                                      child: Text(
                                                        data
                                                            .productClass!
                                                            .data!
                                                            .produucts![index]
                                                            .qty
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 2 *
                                                                SizeConfig
                                                                    .textMultiplier!,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1 *
                                                      SizeConfig
                                                          .widthMultiplier!,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {});
                                                    data
                                                        .productClass!
                                                        .data!
                                                        .produucts![index]
                                                        .qty = data
                                                            .productClass!
                                                            .data!
                                                            .produucts![index]
                                                            .qty! +
                                                        1;
                                                    var restore_cart =
                                                        Provider.of<GetData>(
                                                            context,
                                                            listen: false);
                                                    restore_cart.Restore_Item(
                                                        index,
                                                        data
                                                            .productClass!
                                                            .data!
                                                            .produucts![index]
                                                            .id!);
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle_outline,
                                                    color: Color_me.main,
                                                    size: 9 *
                                                        SizeConfig
                                                            .imageSizeMultiplier!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                data.productClass!.data!
                                                    .produucts![index].qty = 1;
                                              });
                                              var add_cart =
                                                  Provider.of<GetData>(context,
                                                      listen: false);
                                              add_cart.Add_To_Cart(data
                                                  .productClass!
                                                  .data!
                                                  .produucts![index]);
                                            },
                                            child: Icon(
                                              Icons.add_circle,
                                              color: Color_me.main,
                                              size: 9 *
                                                  SizeConfig
                                                      .imageSizeMultiplier!,
                                            ),
                                          ),
                                  )
                                : Stack(
                                    children: [
                                      GroceryCard(
                                          title: data.productClass!.data!.produucts![index].productName != null
                                              ? data
                                                  .productClass!
                                                  .data!
                                                  .produucts![index]
                                                  .bnProductName
                                              : "No Data",
                                          weight: data.productClass!.data!.produucts![index].attribute != null
                                              ? data.productClass!.data!
                                                  .produucts![index].bnAttribute
                                                  .toString()
                                              : "No Data",
                                          delivery:
                                              data.productClass!.data!.produucts![index].discountPrice != null
                                                  ? data
                                                      .productClass!
                                                      .data!
                                                      .produucts![index]
                                                      .bnDiscountPrice
                                                      .toString()
                                                  : data.productClass!.data!
                                                      .produucts![index].bnPrice
                                                      .toString(),
                                          discount: data
                                                      .productClass!
                                                      .data!
                                                      .produucts![index]
                                                      .discountPrice !=
                                                  null
                                              ? data.productClass!.data!.produucts![index].bnPrice
                                              : "",
                                          img: Container(
                                            height: 15 *
                                                SizeConfig.heightMultiplier!,
                                            padding: EdgeInsets.all(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: NetworkImage(
                                                        data
                                                                    .productClass!
                                                                    .data!
                                                                    .produucts![
                                                                        index]
                                                                    .picture !=
                                                                null
                                                            ? main_url +
                                                                data
                                                                    .productClass!
                                                                    .data!
                                                                    .produucts![
                                                                        index]
                                                                    .picture
                                                                    .toString()
                                                            : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                                                      ))),
                                            ),
                                          ),
                                          child: Container()),
                                      Positioned(
                                          top: 10,
                                          bottom: 10,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              width: _width,
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              child: Center(
                                                child: setCommonText(
                                                    "Stock Out",
                                                    Colors.white,
                                                    24.0,
                                                    FontWeight.w800,
                                                    1),
                                              ),
                                            ),
                                          ))
                                    ],
                                  );
                          })
                    ],
                  )
                : SkProduct();
          },
        ),
      ),
    );
  }
}
