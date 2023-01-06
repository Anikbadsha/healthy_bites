import 'package:flutter/material.dart';
import 'package:healthy_bites/Bottom_Bar/home_page.dart';
import 'package:healthy_bites/Bottom_Bar/notification.dart';
import 'package:healthy_bites/Bottom_Bar/points.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/main.dart';
import 'package:healthy_bites/product_search/product_search.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

import 'Bottom_Bar/basket.dart';
import 'Responsive/size_config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> _screen = [HomePage(), Offer(), Points(), Notifications()];
  String qrCodeResult = "Not Yet Scanned";
  bool _slowAnimations = false;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTaped(int selectedIndex) {
    setState(() {
      _pageController.jumpToPage(selectedIndex);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_me.main,
        title: Consumer<GetData>(
          builder: (content, data, child) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Healthy Bites",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  /*Navigator.of(context)
                                    .pushNamed(SHOP_PRODUCT_SEARCH);*/

                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: ProductSearch(),
                                        inheritTheme: true,
                                        ctx: context),
                                  );
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2 * SizeConfig.widthMultiplier!,
                            ),
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(ORDER);
                                  },
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                    size: 30,
                                  ),
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
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        type: BottomNavigationBarType.fixed,
        /*backgroundColor: Color_me.main,*/
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Color_me.main,
        onTap: _onItemTaped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Color_me.main : Colors.grey,
            ),
            label: "হোম",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_offer,
                color: _selectedIndex == 1 ? Color_me.main : Colors.grey,
              ),
              label: "অফার"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.point_of_sale,
                color: _selectedIndex == 2 ? Color_me.main : Colors.grey,
              ),
              label: "পয়েন্টস"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: _selectedIndex == 3 ? Color_me.main : Colors.grey,
            ),
            label: "নোটিফিকেশন",
          ),
        ],
      ),
      drawer: Drawer(
        //width: 65 * SizeConfig.widthMultiplier,
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                child: DrawerHeader(
                  child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Text(
                            "Healthy Bites",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                                child: Icon(
                                              Icons.person,
                                              size: 7 *
                                                  SizeConfig
                                                      .imageSizeMultiplier!,
                                            )),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                prefs!.containsKey('uid')
                                                    ? prefs!.getString('phone')!
                                                    : "গেষ্ট",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: prefs!.containsKey('uid')
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, PROFILE);
                                              },
                                              child: Column(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .account_box_outlined,
                                                      size: 2 *
                                                          SizeConfig
                                                              .textMultiplier!,
                                                      color: Colors.black),
                                                  SizedBox(
                                                    width: 1.27 *
                                                        SizeConfig
                                                            .widthMultiplier!,
                                                  ),
                                                  Text(
                                                    'প্রোফাইল',
                                                    style: TextStyle(
                                                        fontSize: 2 *
                                                            SizeConfig
                                                                .textMultiplier!,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, LOGIN);
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.login,
                                                    ),
                                                    Text('Log In')
                                                  ],
                                                ),
                                              ),
                                            ))
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                  decoration: BoxDecoration(
                    color: Color_me.main,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 0.005 * SizeConfig.heightMultiplier!),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.home,
                          size: 2 * SizeConfig.textMultiplier!,
                          color: Colors.white),
                      SizedBox(
                        width: 1.27 * SizeConfig.widthMultiplier!,
                      ),
                      Text(
                        'হোম',
                        style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier!,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    Navigator.pop(context);
                    /*Navigator.of(context).pushNamed(SETTINGS);*/

                    // ...
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 0.005 * SizeConfig.heightMultiplier!),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.shopping_basket,
                          size: 2 * SizeConfig.textMultiplier!,
                          color: Colors.white),
                      SizedBox(
                        width: 1.27 * SizeConfig.widthMultiplier!,
                      ),
                      Text(
                        'বাস্কেট',
                        style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier!,
                            color: Colors.white),
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width,
                        child: Consumer<GetData>(
                          builder: (content, data, child) {
                            return Container(
                                alignment: Alignment.center,
                                height: 2 * SizeConfig.heightMultiplier!,
                                width: 2 * SizeConfig.heightMultiplier!,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  cart!.length.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ));
                          },
                        ),
                      ))
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(ORDER);

                    // ...
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 0.005 * SizeConfig.heightMultiplier!),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.history,
                          size: 2 * SizeConfig.textMultiplier!,
                          color: Colors.white),
                      SizedBox(
                        width: 1.27 * SizeConfig.widthMultiplier!,
                      ),
                      Text(
                        'অর্ডারগুলো',
                        style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier!,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.

                    Navigator.of(context).pushNamed(ORDERHISTORY);

                    // ...
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 0.005 * SizeConfig.heightMultiplier!),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.privacy_tip,
                          size: 2 * SizeConfig.textMultiplier!,
                          color: Colors.white),
                      SizedBox(
                        width: 1.27 * SizeConfig.widthMultiplier!,
                      ),
                      Text(
                        'প্রাইভেসি পলিসি',
                        style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier!,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    _launchInWebViewOrVC(
                        'https://www.freeprivacypolicy.com/live/0755655a-43e0-4cf7-8c60-44adf69634aa');
                    /*Navigator.of(context).pushNamed(SETTINGS);*/

                    // ...
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 0.005 * SizeConfig.heightMultiplier!),
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.language,
                          size: 2 * SizeConfig.textMultiplier!,
                          color: Colors.white),
                      SizedBox(
                        width: 1.27 * SizeConfig.widthMultiplier!,
                      ),
                      Text(
                        'ভাষা',
                        style: TextStyle(
                            fontSize: 2 * SizeConfig.textMultiplier!,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app.
                    Navigator.pop(context);
                    /*Navigator.of(context).pushNamed(SETTINGS);*/

                    // ...
                  },
                ),
              ),

              /*  Divider(
               height: 1,
               color: Colors.black,
             ),
*/

              Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10, right: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, NAVBARPOINT);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Icon(Icons.point_of_sale, color: Colors.white),
                                Text(
                                  'পয়েন্টস',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            UrlLauncher.launch("tel:+01634330813");
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10, right: 15),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Icon(Icons.phone, color: Colors.white),
                                Text(
                                  'হট লাইন',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  )),
              prefs!.containsKey('uid')
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                UrlLauncher.launch("https://m.me/angobazar",
                                    forceWebView: false);
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Icon(Icons.chat, color: Colors.white),
                                    Text(
                                      'লাইভ ম্যাসেজ',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "সতর্কতা!",
                                  desc: "আপনি কি লগআউট করতে চাচ্ছেন?",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "বাতিল",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: Color.fromRGBO(0, 179, 134, 1.0),
                                    ),
                                    DialogButton(
                                      child: Text(
                                        "ঠিক আছে",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          prefs!.clear();
                                          Navigator.pop(context);
                                        });
                                      },
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(116, 116, 191, 1.0),
                                        Color.fromRGBO(52, 138, 199, 1.0)
                                      ]),
                                    )
                                  ],
                                ).show();
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'লগআউট',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ))
                  : Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            UrlLauncher.launch("https://m.me/Shodaibuzz",
                                forceWebView: true);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10, right: 15),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Icon(Icons.chat, color: Colors.white),
                                Text(
                                  'Live Chat',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
