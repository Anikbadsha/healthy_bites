import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/Skeleton/sk_product.dart';
import 'package:healthy_bites/Design/grocerycard.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/Modal/product_search.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  SearchProduct? searchProduct;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    /*var fetch_search = Provider.of<GetData>(context, listen: false);
    fetch_search.*/
    request_search(searchController.text);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
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
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: searchController,
            cursorColor: Colors.white,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: new InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 13, right: 15),
                hintText: "পন্য সার্চ করুন",
                hintStyle: TextStyle(color: Colors.white)),
            onChanged: (text) {
              text = searchController.text;
              setState(() {
                request_search(searchController.text);
              });
            },
          ),
        ),
      ),
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.all(10),
        child: searchProduct != null
            ? ListView.builder(
                itemCount: searchProduct!.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GroceryCard(
                    title: searchProduct!.data![index].productName != null
                        ? searchProduct!.data![index].bnProductName
                        : "No Data",
                    weight: searchProduct!.data![index].bnAttribute != null
                        ? searchProduct!.data![index].bnAttribute.toString()
                        : "No Data",
                    delivery: /*searchProduct.data[index].price.toString(),*/
                        searchProduct!.data![index].discountPrice != null
                            ? searchProduct!.data![index].discountPrice
                                .toString()
                            : searchProduct!.data![index].price.toString(),
                    discount: searchProduct!.data![index].discountPrice != null
                        ? searchProduct!.data![index].price.toString()
                        : "",
                    img: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          DESCRIPTION,
                          arguments: searchProduct!.data![index],
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
                                    searchProduct!.data![index].picture != null
                                        ? main_url +
                                            searchProduct!.data![index].picture
                                                .toString()
                                        : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                                  ))),
                        ),
                      ),
                    ),
                    child:
                        /*GestureDetector(
                                onTap: () {
                                  setState(() {
                                    data.productClass.data.produucts[index]
                                        .qty = 1;
                                  });
                                  var add_cart = Provider.of<GetData>(context,
                                      listen: false);
                                  add_cart.Add_To_Cart(
                                      data.productClass.data.produucts[index]);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 15 * SizeConfig.heightMultiplier,
                                  width: _width,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Color_me.main,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 8 * SizeConfig.imageSizeMultiplier,
                                    ),
                                  ),
                                ),
                              ),*/

                        searchProduct!.data![index].qty! > 0
                            ? Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {});
                                        searchProduct!.data![index].qty =
                                            searchProduct!.data![index].qty! -
                                                1;
                                        var restore_cart = Provider.of<GetData>(
                                            context,
                                            listen: false);
                                        restore_cart.Restore_Item(index,
                                            searchProduct!.data![index].id!);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          height:
                                              4 * SizeConfig.heightMultiplier!,
                                          width:
                                              8 * SizeConfig.widthMultiplier!,
                                          color: Color_me.main,
                                          child: Center(
                                            child: new Text(
                                              "-",
                                              style: TextStyle(
                                                  fontSize: 2.5 *
                                                      SizeConfig
                                                          .textMultiplier!,
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
                                        height:
                                            4 * SizeConfig.heightMultiplier!,
                                        width: 12 * SizeConfig.widthMultiplier!,
                                        color: Colors.white,
                                        child: Center(
                                          child: Text(
                                            searchProduct!.data![index].qty
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 2.5 *
                                                    SizeConfig.textMultiplier!,
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
                                        searchProduct!.data![index].qty =
                                            searchProduct!.data![index].qty! +
                                                1;
                                        var restore_cart = Provider.of<GetData>(
                                            context,
                                            listen: false);
                                        restore_cart.Restore_Item(index,
                                            searchProduct!.data![index].id!);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          height:
                                              4 * SizeConfig.heightMultiplier!,
                                          width:
                                              8 * SizeConfig.widthMultiplier!,
                                          color: Color_me.main,
                                          child: Center(
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  fontSize: 2.5 *
                                                      SizeConfig
                                                          .textMultiplier!,
                                                  color: Colors.white70),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    searchProduct!.data![index].qty = 1;
                                  });
                                  var add_cart = Provider.of<GetData>(context,
                                      listen: false);
                                  add_cart.Add_To_Cart(
                                      searchProduct!.data![index]);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 15 * SizeConfig.heightMultiplier!,
                                  width: _width,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Color_me.main,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 8 * SizeConfig.imageSizeMultiplier!,
                                    ),
                                  ),
                                ),
                              ),
                  );
                })
            : SkProduct(),
      ),
    );
  }

  Future request_search(var text) async {
    final response =
        await http.post(Uri.parse(main_url + '/api/product/search'), body: {
      'val': text,
    });

    var data = json.decode(response.body);

    searchProduct = SearchProduct.fromJson(data);

    print(response.body.toString());

    //return json.decode(response.body);
    Change_State();
  }

  Change_State() {
    if (mounted) {
      setState(() {});
    }
  }
}
