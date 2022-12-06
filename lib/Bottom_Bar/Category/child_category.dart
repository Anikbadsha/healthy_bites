import 'package:flutter/material.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Design/Skeleton/sk_skeleton.dart';
import 'package:healthy_bites/Design/common_widget.dart';
import 'package:healthy_bites/Design/sub_category.dart';
import 'package:healthy_bites/IMP/route.dart';
import 'package:healthy_bites/IMP/url.dart';
import 'package:healthy_bites/PROVIDER/get_data.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';
import 'package:provider/provider.dart';

class ChildCategory extends StatefulWidget {
  @override
  _ChildCategoryState createState() => _ChildCategoryState();
}

class _ChildCategoryState extends State<ChildCategory> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  var data;

  @override
  void initState() {
    /*var get_childdata = Provider.of<GetData>(context, listen: false);
    get_childdata.get_childcategory(prefs.getString('sub_id'));*/
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

    var get_childdata = Provider.of<GetData>(context, listen: false);

    if (data == null) {
      data = ModalRoute.of(context)?.settings.arguments;
      get_childdata.get_childcategory(data.toString());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_me.main,
        title: Consumer<GetData>(
          builder: (content, data, child) {
            return data.childCategory != null
                ? Container(
                    child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 2 * SizeConfig.widthMultiplier!,
                          height: 8 * SizeConfig.heightMultiplier!,
                          child: setCommonText(
                              data.childCategory!.data!.bnName!,
                              Colors.white,
                              18.0,
                              FontWeight.w500,
                              1),
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
          builder: (content, data, child) {
            return data.childCategory != null
                ? ListView(
                    children: [
                      Container(
                        width: _width,
                        alignment: Alignment.centerLeft,
                        child: setCommonText(data.childCategory!.data!.bnName!,
                            Colors.black, 16.0, FontWeight.w500, 1),
                      ),
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              data.childCategory!.data!.categories!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: large! ? 4 : (medium! ? 3 : 3),
                            childAspectRatio: large!
                                ? ((_width! / 2.7) / (_height! / 3))
                                : (medium!
                                    ? ((_width! / 2) / (_height! / 3.3))
                                    : ((_width! / 2) / (_height! / 3.3))),
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(PRODUCTS,
                                    arguments: data.childCategory!.data!
                                        .categories![index].id);
                              },
                              child: SubCategoryPlate(
                                img: main_url +
                                    data.childCategory!.data!.categories![index]
                                        .categoryPicture!,
                                title: data.childCategory!.data!
                                    .categories![index].bnCategoryName,
                              ),
                            );
                          }),
                    ],
                  )
                : SkCategory();
          },
        ),
      ),
    );
  }
}
