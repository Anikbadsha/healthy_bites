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

class SubCategory extends StatefulWidget {
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  double? _height, _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;
  var data;

  @override
  void initState() {
    /*  var get_data = Provider.of<GetData>(context, listen: false);
    get_data.get_subcategory(data.toString());*/

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
    var get_data = Provider.of<GetData>(context, listen: false);

    if (data == null) {
      data = ModalRoute.of(context)!.settings.arguments;
      get_data.get_subcategory(data.toString());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color_me.main,
        title: Container(
            width: _width,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Consumer<GetData>(
                    builder: (content, data, child) {
                      return data.getSubCategory != null
                          ? Container(
                              alignment: Alignment.centerLeft,
                              width: 2 * SizeConfig.widthMultiplier!,
                              height: 8 * SizeConfig.heightMultiplier!,
                              child: setCommonText(
                                  data.getSubCategory!.data!.bnName!,
                                  Colors.white,
                                  18.0,
                                  FontWeight.w500,
                                  1),
                            )
                          : Container();
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ORDER);
                  },
                  child: Consumer<GetData>(
                    builder: (content, data, child) {
                      return Container(
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
                )
              ],
            )),
      ),
      body: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.all(10),
        child: Consumer<GetData>(
          builder: (content, data, child) {
            return data.getSubCategory != null
                ? ListView(
                    children: [
                      Container(
                        width: _width,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data.getSubCategory!.data!.bnName!,
                          style: TextStyle(
                              fontSize: 2.3 * SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              data.getSubCategory!.data!.categories!.length,
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
                              onTap: () async {
                                data.getSubCategory!.data!.categories![index]
                                            .status ==
                                        1
                                    ? Navigator.of(context).pushNamed(
                                        CHILDCATEGORY,
                                        arguments: data.getSubCategory!.data!
                                            .categories![index].id)
                                    : Navigator.of(context).pushNamed(PRODUCTS,
                                        arguments: data.getSubCategory!.data!
                                            .categories![index].id);

                                setState(() {});
                              },
                              child: SubCategoryPlate(
                                img: main_url +
                                    data.getSubCategory!.data!
                                        .categories![index].categoryPicture!,
                                title: data.getSubCategory!.data!
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
