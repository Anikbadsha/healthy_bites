class ProductClass {
  Data? data;

  ProductClass({this.data});

  ProductClass.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Categories>? categories;
  List<Produucts>? produucts;
  String? name;
  String? bnName;

  Data({this.name, this.bnName, this.categories, this.produucts});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bnName = json['bn_name'];

    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['produucts'] != null) {
      produucts = <Produucts>[];
      json['produucts'].forEach((v) {
        produucts!.add(new Produucts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bn_name'] = this.bnName;

    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.produucts != null) {
      data['produucts'] = this.produucts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? categoryName;
  String? bnCategoryName;
  String? categoryPicture;
  int? status;

  Categories(
      {this.id,
      this.categoryName,
      this.bnCategoryName,
      this.categoryPicture,
      this.status});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    bnCategoryName = json['bn_category_name'];
    categoryPicture = json['category_picture'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['bn_category_name'] = this.bnCategoryName;
    data['category_picture'] = this.categoryPicture;
    data['status'] = this.status;
    return data;
  }
}

class Produucts {
  int? id;
  String? productName;
  String? bnProductName;
  int? price;
  String? bnPrice;
  String? unit;
  String? attribute;
  String? bnAttribute;
  int? quantity;
  int? point;
  int? qty;
  String? picture;
  var discountPrice;
  var bnDiscountPrice;
  String? description;
  String? status;

  Produucts(
      {this.id,
      this.productName,
      this.bnProductName,
      this.status,
      this.price,
      this.bnPrice,
      this.unit,
      this.qty,
      this.attribute,
      this.bnAttribute,
      this.quantity,
      this.point,
      this.picture,
      this.discountPrice,
      this.bnDiscountPrice,
      this.description});

  Produucts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    bnProductName = json['bn_product_name'];
    price = json['price'];
    qty = 0;
    bnPrice = json['bn_price'];
    unit = json['unit'];
    attribute = json['attribute'];
    bnAttribute = json['bn_attribute'];
    quantity = json['quantity'];
    point = json['point'];
    status = json['status'];
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
    data['attribute'] = this.attribute;
    data['bn_attribute'] = this.bnAttribute;
    data['quantity'] = this.quantity;
    data['point'] = this.point;
    data['picture'] = this.picture;
    data['discount_price'] = this.discountPrice;
    data['status'] = this.status;
    data['bn_discount_price'] = this.bnDiscountPrice;
    data['description'] = this.description;
    return data;
  }
}
