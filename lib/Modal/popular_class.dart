class PopularClass {
  List<Data>? data;

  PopularClass({this.data});

  PopularClass.fromJson(Map<String, dynamic> json) {
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
  String? unit;
  String? attribute;
  int? quantity;
  int? qty;
  int? point;
  int? price;
  String? picture;
  int? discountPrice;
  String? description;

  Data(
      {this.id,
      this.productName,
      this.unit,
      this.attribute,
      this.quantity,
      this.point,
      this.qty,
      this.price,
      this.picture,
      this.discountPrice,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    unit = json['unit'];
    qty = 0;
    attribute = json['attribute'];
    quantity = json['quantity'];
    point = json['point'];
    price = json['price'];
    picture = json['picture'];
    discountPrice = json['discount_price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['unit'] = this.unit;
    data['attribute'] = this.attribute;
    data['quantity'] = this.quantity;
    data['point'] = this.point;
    data['price'] = this.price;
    data['picture'] = this.picture;
    data['discount_price'] = this.discountPrice;
    data['description'] = this.description;
    return data;
  }
}
