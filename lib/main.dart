import 'package:flutter/material.dart';
import 'package:healthy_bites/Auth/forget_password.dart';
import 'package:healthy_bites/Auth/login.dart';
import 'package:healthy_bites/Auth/signup.dart';
import 'package:healthy_bites/Bottom_Bar/Category/child_category.dart';
import 'package:healthy_bites/Bottom_Bar/Category/products.dart';
import 'package:healthy_bites/Bottom_Bar/Category/subcategory.dart';
import 'package:healthy_bites/Bottom_Bar/Description/product_description.dart';
import 'package:healthy_bites/Bottom_Bar/profile.dart';
import 'package:healthy_bites/History/order_history.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/Order/order_cart.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Page/nav_point.dart';
import 'package:healthy_bites/Page/offer.dart';
import 'package:healthy_bites/Payment/payment_info.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:healthy_bites/Slash/splashscreen.dart';
import 'package:healthy_bites/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(
      ChangeNotifierProvider(create: (context) => GetData(), child: MyApp()));
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: child!,
                );
              },
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                /*cursorColor: Color_me.green,*/
                visualDensity: VisualDensity.adaptivePlatformDensity,
                errorColor: Colors.red,
              ),
              /*.copyWith(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: <TargetPlatform, PageTransitionsBuilder>{
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  },
                ),
              ),*/
              home: Home(),
              routes: <String, WidgetBuilder>{
                HOME: (BuildContext context) => Home(),
                SUBCATEGORY: (BuildContext context) => SubCategory(),
                CHILDCATEGORY: (BuildContext context) => ChildCategory(),
                PRODUCTS: (BuildContext context) => Products(),
                SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
                ORDER: (BuildContext context) => Order(),
                DESCRIPTION: (BuildContext context) => ProductDescription(),
                PAYMENT_INFO: (BuildContext context) => PaymentInfo(),
                LOGIN: (BuildContext context) => LogIn(),
                SIGNUP: (BuildContext context) => SignUp(),
                NAVBARPOINT: (BuildContext context) => NavPoints(),
                NAVOFFER: (BuildContext context) => NavOffer(),
                ORDERHISTORY: (BuildContext context) => OrderHistory(),
                PROFILE: (BuildContext context) => Profile(),
                FORGET: (BuildContext context) => ForgetPass(),
              },
              initialRoute: SPLASH_SCREEN,
            );
          },
        );
      },
    );
  }
}
