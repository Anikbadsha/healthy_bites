import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/Modal/area.dart';
import 'package:healthy_bites/Modal/get_category.dart';
import 'package:healthy_bites/Modal/get_sub_category.dart';
import 'package:healthy_bites/Modal/history.dart';
import 'package:healthy_bites/Modal/notification.dart';
import 'package:healthy_bites/Modal/offer_class.dart';
import 'package:healthy_bites/Modal/popular_class.dart';
import 'package:healthy_bites/Modal/product_class.dart';
import 'package:healthy_bites/Modal/product_search.dart';
import 'package:healthy_bites/Modal/slider_class.dart';
import 'package:healthy_bites/Modal/time_range.dart';
import 'package:healthy_bites/Order/order_cart.dart';
import 'package:healthy_bites/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Modal/child_category.dart';

List? cart_id = [];
List? cart = [];

class GetData extends ChangeNotifier {
  GetCategory? getCategory;
  GetSubCategory? getSubCategory;
  ChildCategory? childCategory;
  ProductClass? productClass;
  PopularClass? popularClass;
  OfferClass? offerClass;
  OrderList? orderList;
  SearchProduct? searchProduct;
  SliderClass? sliderClass;
  NotificatonModel? notificatonModel;

  Area? area;
  TimeRange? timeRange;
  var data;
  var point;
  var cupon;
  var profile;

  static String? delivery_charge;
  static double? total_amount;
  static double? grand_total;
  static int? myCupon;

  Future get_category() async {
    final response = await http.get(Uri.parse(main_url + "/api/category"));
    var data = json.decode(response.body.toString());

    print(data);
    getCategory = GetCategory.fromJson(data);

    notifyListeners();
  }

  Future get_subcategory(String id) async {
    getSubCategory = null;

    final response =
        await http.post(Uri.parse(main_url + '/api/category/details'), body: {
      'category_id': id,
    });

    var data = json.decode(response.body.toString());

    print(data);
    getSubCategory = GetSubCategory.fromJson(data);

    notifyListeners();
  }

  Future get_childcategory(String id) async {
    childCategory = null;
    final response =
        await http.post(Uri.parse(main_url + '/api/category/details'), body: {
      'category_id': id,
    });

    var data = json.decode(response.body.toString());

    print(data);
    childCategory = ChildCategory.fromJson(data);

    notifyListeners();
  }

  Future get_products(String id) async {
    productClass = null;
    final response =
        await http.post(Uri.parse(main_url + '/api/category/details'), body: {
      'category_id': id,
    });

    var data = json.decode(response.body.toString());

    print(data);
    productClass = ProductClass.fromJson(data);

    notifyListeners();
  }

  Future get_history() async {
    final response =
        await http.post(Uri.parse(main_url + '/api/order/list'), body: {
      'user_id': prefs!.getString('uid'),
    });

    var data = json.decode(response.body.toString());

    print(data);
    orderList = OrderList.fromJson(data);

    notifyListeners();
  }

  Future get_popular() async {
    final response =
        await http.get(Uri.parse(main_url + "/api/popular/product"));
    var data = json.decode(response.body.toString());

    print(data);
    popularClass = PopularClass.fromJson(data);

    notifyListeners();
  }

  Future get_notification() async {
    final response = await http.get(Uri.parse(
        main_url + "/api/user-notification?userid=${prefs!.getString('uid')}"));
    var data = json.decode(response.body.toString());

    print(data);
    notificatonModel = NotificatonModel.fromJson(data);

    notifyListeners();
  }

  Future get_offer() async {
    final response = await http.get(Uri.parse(main_url + "/api/offer/product"));
    var data = json.decode(response.body.toString());

    print(data);
    offerClass = OfferClass.fromJson(data);

    notifyListeners();
  }

  Add_To_Cart(var product) async {
    if (cart_id!.contains(product.id)) {
      int pos = cart_id!.indexOf(product.id);
      cart![pos] = product;
    } else {
      cart_id!.add(product.id);
      cart!.add(product);
    }
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('cart', json.encode(cart));
    prefs!.setString('cart_id', json.encode(cart_id));

    notifyListeners();
  }

  Restore_Item(int index, int num, [id]) async {
    for (int i = 0; i < cart!.length; i++) {
      if (cart![i].id == id) {
        index = i;
        break;
      }
    }

    if (cart![index].qty == 0) {
      cart!.removeAt(index);
      cart_id!.removeAt(index);
    }

    prefs = await SharedPreferences.getInstance();
    prefs!.setString('cart', json.encode(cart));
    prefs!.setString('cart_id', json.encode(cart_id));

    Total_Price = 0;
    for (int i = 0; i < cart!.length; i++) {
      Total_Price += double.parse(cart![i].price.toString()) * cart![i].qty;
    }

    notifyListeners();
  }

  Remove_item(int index) async {
    cart!.removeAt(index);
    cart_id!.removeAt(index);
    prefs = await SharedPreferences.getInstance();
    prefs!.setString('cart', json.encode(cart));
    prefs!.setString('cart_id', json.encode(cart_id));

    Total_Price = 0;
    for (int i = 0; i < cart!.length; i++) {
      Total_Price += double.parse(cart![i].price.toString()) * cart![i].qty;
    }

    notifyListeners();
  }

  Future get_area() async {
    final response = await http.get(Uri.parse(main_url + "/api/location"));
    var data = json.decode(response.body.toString());

    print(data);
    area = Area.fromJson(data);

    notifyListeners();
  }

  Future get_time() async {
    final response = await http.get(Uri.parse(main_url + "/api/time-range"));
    var data = json.decode(response.body.toString());

    print(data);
    timeRange = TimeRange.fromJson(data);

    notifyListeners();
  }

  Future get_payment() async {
    final response = await http.get(Uri.parse(main_url + "/api/setting"));
    data = json.decode(response.body);
    delivery_charge = data[0]['delivery_charge'];
    grand_total = double.parse(delivery_charge!) + Total_Price;

    print(data);
    notifyListeners();
  }

  /* Future<List> get_profile() async {
    final response = await http.get(main_url + "/api/profile");
    profile = json.decode(response.body.toString());

    print(profile);
    notifyListeners();
  }*/

  Future get_point() async {
    final response =
        await http.post(Uri.parse(main_url + '/api/profile'), body: {
      'user_id': prefs!.getString('uid'),
    });

    point = json.decode(response.body.toString());

    print(point);

    notifyListeners();
  }

  Future get_cupon(String cupons) async {
    final response =
        await http.post(Uri.parse(main_url + '/api/coupon/check'), body: {
      'cupon': cupons,
    });

    cupon = json.decode(response.body.toString());
    myCupon = cupon['data'];

    print(cupon);

    notifyListeners();
  }

  Future request_search(var text) async {
    final response =
        await http.post(Uri.parse(main_url + '/api/product/search'), body: {
      'search_key': text,
    });

    var data = json.decode(response.body);

    searchProduct = SearchProduct.fromJson(data);

    print(response.body.toString());

    //return json.decode(response.body);
    notifyListeners();
  }

  Future get_slider() async {
    final response = await http.get(Uri.parse(main_url + "/api/slider"));
    var data = json.decode(response.body.toString());

    print(data);
    sliderClass = SliderClass.fromJson(data);

    notifyListeners();
  }
}
