class SearchProduct {
  List<Data>? data;

  SearchProduct({this.data});

  SearchProduct.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? productName;
  String? bnProductName;
  int? price;
  int? qty;
  String? bnPrice;
  String? unit;
  String? bnAttribute;
  int? quantity;
  int? point;
  String? picture;
  var discountPrice;
  String? bnDiscountPrice;
  String? description;

  Data(
      {this.id,
      this.productName,
      this.bnProductName,
      this.price,
      this.qty,
      this.bnPrice,
      this.unit,
      this.bnAttribute,
      this.quantity,
      this.point,
      this.picture,
      this.discountPrice,
      this.bnDiscountPrice,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    bnProductName = json['bn_product_name'];
    price = json['price'];
    bnPrice = json['bn_price'];
    qty = 0;
    unit = json['unit'];
    bnAttribute = json['bn_attribute'];
    quantity = json['quantity'];
    point = json['point'];
    picture = json['picture'];
    discountPrice = json['discount_price'];
    bnDiscountPrice = json['bn_discount_price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['bn_product_name'] = this.bnProductName;
    data['price'] = this.price;
    data['bn_price'] = this.bnPrice;
    data['unit'] = this.unit;
    data['bn_attribute'] = this.bnAttribute;
    data['quantity'] = this.quantity;
    data['point'] = this.point;
    data['picture'] = this.picture;
    data['discount_price'] = this.discountPrice;
    data['bn_discount_price'] = this.bnDiscountPrice;
    data['description'] = this.description;
    return data;
  }
}
