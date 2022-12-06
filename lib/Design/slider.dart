import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:progressive_image/progressive_image.dart';

class SliderPage extends StatefulWidget {
  /*final double width;*/
  /*final List<BannerRestaurent> bannerData;
  BannerRestaurants(this.width, this.bannerData);*/

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  final List discountList = [
    {
      'discount': '14',
      'discountName': 'Foodis Friday',
      'velidity': '20th july 2020',
      'code': 'FooDy2020',
      'bannerImage': 'https://i.ytimg.com/vi/nf06gJ4hg60/maxresdefault.jpg'
    },
    {
      'discount': '18',
      'discountName': 'July Special',
      'velidity': '18th july 2020',
      'code': 'July2020',
      'bannerImage': 'https://pbs.twimg.com/media/DjvwvpTXsAAsqdl.jpg'
    },
    {
      'discount': '20',
      'discountName': 'Birthday Offer',
      'velidity': '22th july 2020',
      'code': 'HDOffer',
      'bannerImage':
          'https://cdn.grabon.in/gograbon/images/web-images/uploads/1593767938443/groceries-offers.jpg'
    },
    {
      'discount': '25',
      'discountName': 'Junmasti Special',
      'velidity': '25th july 2020',
      'code': 'KANHA2020',
      'bannerImage':
          'https://image.slidesharecdn.com/onlinegrocerydeliverywithexclusiveoffersinchennai-191212082949/95/online-grocery-delivery-with-exclusive-offers-in-chennai-1-638.jpg?cb=1576139507'
    },
  ];

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);
    return Container(
      width: _width,
      height: (_width! / 1.8),
      color: Colors.white,
      child: CarouselSlider.builder(
          // key: _sliderKey,
          unlimitedMode: true,
          enableAutoSlider: true,
          slideBuilder: (index) {
            return Padding(
              padding:
                  new EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
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
                    placeholder: AssetImage('assets/logo.png'),
                    // size: 1.87KB
                    thumbnail: AssetImage('assets/logo.png'),
                    // size: 1.29MB
                    image: NetworkImage(discountList[index]['bannerImage']),
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
          itemCount: discountList.length),
    );
  }
}
