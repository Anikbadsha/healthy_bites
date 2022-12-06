import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/Skeleton/sk_product.dart';
import 'package:healthy_bites/Design/Skeleton/sk_square.dart';
import 'package:healthy_bites/Design/common_widget.dart';
import 'package:healthy_bites/Design/grocerycard.dart';
import 'package:healthy_bites/Design/parent_category.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;

  bool? click;

  final List discountList = [
    {
      'discount': '14',
      'discountName': 'Foodis Friday',
      'velidity': '20th july 2020',
      'code': 'FooDy2020',
      'bannerImage': 'Assets/RestaurantDetails/RestaurantApp.jpg'
    },
    {
      'discount': '18',
      'discountName': 'July Special',
      'velidity': '18th july 2020',
      'code': 'July2020',
      'bannerImage': 'assets/banner.jpg'
    },
    {
      'discount': '20',
      'discountName': 'Birthday Offer',
      'velidity': '22th july 2020',
      'code': 'HDOffer',
      'bannerImage': 'assets/logo.png'
    },
    {
      'discount': '25',
      'discountName': 'Junmasti Special',
      'velidity': '25th july 2020',
      'code': 'KANHA2020',
      'bannerImage': 'assets/rocket.jpg'
    },
  ];

  @override
  void initState() {
    var fetch_data = Provider.of<GetData>(context, listen: false);
    fetch_data.get_category();

    var fetch_popular = Provider.of<GetData>(context, listen: false);
    fetch_popular.get_popular();

    var fetch_slider = Provider.of<GetData>(context, listen: false);
    fetch_slider.get_slider();
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return MaterialApp(
      /*onGenerateRoute: (settings) {
        if (settings.name == SUBCATEGORY) {
          return PageTransition(
            child: SubCategory(),
            type: PageTransitionType.bottomToTop,
            inheritTheme: false,
          );
        } else {
          return null;
        }
      },*/

      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Scaffold(
            body: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 10),
                height: _height,
                width: _width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /*
                    Container(
                      padding: EdgeInsets.all(10),
                      width: _width,
                      color: Colors.orange,
                      child: Text(
                        "আমরা শুধুমাত্র উত্তরা এরিয়াতে ডেলিভারী দিয়ে থাকি। যোগাযোগ করুণ +8809678908909",
                        style: TextStyle(
                            fontSize: 2.3 * SizeConfig.textMultiplier),
                      ),
                    ),
                    SizedBox(
                      height: 1.5 * SizeConfig.heightMultiplier,
                    ),
                    */
                      Consumer<GetData>(
                        builder: (content, data, child) {
                          return data.sliderClass != null
                              ? Container(
                                  width: _width,
                                  height: (_width! / 1.8),
                                  color: Colors.white,
                                  child: CarouselSlider.builder(
                                      // key: _sliderKey,
                                      unlimitedMode: true,
                                      enableAutoSlider: true,
                                      slideBuilder: (index) {
                                        return Padding(
                                          padding: new EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 8,
                                              bottom: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5))),
                                            //color: colors[index],
                                            child:
                                                /*Image.asset(
                  discountList[index]['bannerImage'],
                  fit: BoxFit.fitWidth,
                ),*/
                                                ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5)),
                                              child: ProgressiveImage(
                                                placeholder: AssetImage(
                                                    'assets/slash.png'),
                                                // size: 1.87KB
                                                thumbnail: AssetImage(
                                                    'assets/slash.png'),
                                                // size: 1.29MB
                                                image: NetworkImage(main_url +
                                                    data
                                                        .sliderClass!
                                                        .data![index]
                                                        .sliderPicture!),
                                                height: 300,
                                                width: _width!,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      slideIndicator: CircularSlideIndicator(
                                        currentIndicatorColor: Colors.white,
                                        padding: EdgeInsets.only(bottom: 15),
                                      ),
                                      itemCount:
                                          data.sliderClass!.data!.length),
                                )
                              : Container();
                        },
                      ),
                      SizedBox(
                        height: 1.5 * SizeConfig.heightMultiplier!,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: _width,
                        alignment: Alignment.center,
                        child: setCommonText('আঙ্গো ক্যাটাগরী', Colors.black,
                            25.0, FontWeight.w500, 1),
                      ),
                      Container(
                        width: _width,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Consumer<GetData>(
                          builder: (content, data, child) {
                            return data.getCategory != null
                                ? GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data.getCategory!.data!.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          large! ? 4 : (medium! ? 3 : 3),
                                      childAspectRatio: large!
                                          ? ((_width! / 2.7) / (_height! / 3))
                                          : (medium!
                                              ? ((_width! / 2) / (_height! / 3))
                                              : ((_width! / 2.3) /
                                                  (_height! / 2.85))),
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          data.getCategory!.data![index]
                                                      .status ==
                                                  1
                                              ? Navigator.of(context).pushNamed(
                                                  SUBCATEGORY,
                                                  arguments: data.getCategory!
                                                      .data![index].id)
                                              : Navigator.of(context).pushNamed(
                                                  PRODUCTS,
                                                  arguments: data.getCategory!
                                                      .data![index].id);
                                        },
                                        child: ParentCategory(
                                          img: main_url +
                                              data.getCategory!.data![index]
                                                  .categoryPicture!,
                                          title: data.getCategory!.data![index]
                                              .bnCategoryName,
                                          /*cat_icon: main_url +
                                              data.getCategory.data[index]
                                                  .categoryIcon,*/
                                        ),
                                      );
                                    })
                                : SkSquare();
                          },
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: _width,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "জনপ্রিয় পন্য",
                          style: TextStyle(
                              fontSize: 2.3 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Container(
                        width: _width,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Consumer<GetData>(
                          builder: (content, data, child) {
                            return data.popularClass != null
                                ? ListView.builder(
                                    itemCount: data.popularClass!.data!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GroceryCard(
                                        title: data.popularClass!.data![index]
                                                    .productName !=
                                                null
                                            ? data.popularClass!.data![index]
                                                .productName
                                            : "No Data",
                                        weight: data.popularClass!.data![index]
                                                    .attribute !=
                                                null
                                            ? data.popularClass!.data![index]
                                                .attribute
                                            : "No data",
                                        delivery: data
                                                    .popularClass!
                                                    .data![index]
                                                    .discountPrice !=
                                                null
                                            ? data.popularClass!.data![index]
                                                .discountPrice
                                                .toString()
                                            : data.popularClass!.data![index]
                                                .price
                                                .toString(),
                                        discount: data
                                                    .popularClass!
                                                    .data![index]
                                                    .discountPrice !=
                                                null
                                            ? data.popularClass!.data![index]
                                                .price
                                                .toString()
                                            : "",
                                        img: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              DESCRIPTION,
                                              arguments: data
                                                  .popularClass!.data![index],
                                            );
                                          },
                                          child: Container(
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
                                                                    .popularClass!
                                                                    .data![
                                                                        index]
                                                                    .picture !=
                                                                null
                                                            ? main_url +
                                                                data
                                                                    .popularClass!
                                                                    .data![
                                                                        index]
                                                                    .picture
                                                                    .toString()
                                                            : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                                                      ))),
                                            ),
                                          ),
                                        ),
                                        child: data.popularClass!.data![index]
                                                    .qty! >
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
                                                            .popularClass!
                                                            .data![index]
                                                            .qty = data
                                                                .popularClass!
                                                                .data![index]
                                                                .qty! -
                                                            1;
                                                        var restore_cart =
                                                            Provider.of<
                                                                    GetData>(
                                                                context,
                                                                listen: false);
                                                        restore_cart.Restore_Item(
                                                            index,
                                                            data
                                                                .popularClass!
                                                                .data![index]
                                                                .id!);
                                                      },
                                                      child: new Icon(
                                                        Icons
                                                            .remove_circle_outline,
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
                                                          BorderRadius.circular(
                                                              10),
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
                                                                .popularClass!
                                                                .data![index]
                                                                .qty
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 2 *
                                                                    SizeConfig
                                                                        .textMultiplier!,
                                                                color: Colors
                                                                    .black),
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
                                                            .popularClass!
                                                            .data![index]
                                                            .qty = data
                                                                .popularClass!
                                                                .data![index]
                                                                .qty! +
                                                            1;
                                                        var restore_cart =
                                                            Provider.of<
                                                                    GetData>(
                                                                context,
                                                                listen: false);
                                                        restore_cart.Restore_Item(
                                                            index,
                                                            data
                                                                .popularClass!
                                                                .data![index]
                                                                .id!);
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .add_circle_outline,
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
                                                    data.popularClass!
                                                        .data![index].qty = 1;
                                                  });
                                                  var add_cart =
                                                      Provider.of<GetData>(
                                                          context,
                                                          listen: false);
                                                  add_cart.Add_To_Cart(data
                                                      .popularClass!
                                                      .data![index]);
                                                },
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: Color_me.main,
                                                  size: 9 *
                                                      SizeConfig
                                                          .imageSizeMultiplier!,
                                                ),
                                              ),
                                      );
                                    })
                                : SkProduct();
                          },
                        ),
                      )
                    ],
                  ),
                )),
            /* Positioned(
                top: _height / 3.5,
                right: 0,
                child: Container(
                  width: 12 * SizeConfig.widthMultiplier,
                  height: 5 * SizeConfig.heightMultiplier,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color_me.main,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        bottomLeft: const Radius.circular(40.0),
                      )),
                  child: IconButton(
                    onPressed: () {
                      UrlLauncher.launch("tel:+8801611445621");
                    },
                    icon: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ))*/
          ],
        ));
      },
    );
  }

  Change_State() {
    if (mounted) {
      setState(() {});
    }
  }
}
