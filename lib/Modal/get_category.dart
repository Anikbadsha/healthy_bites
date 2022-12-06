class GetCategory {
  List<Data>? data;

  GetCategory({this.data});

  GetCategory.fromJson(Map<String, dynamic> json) {
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
  String? categoryName;
  String? bnCategoryName;
  String? categoryPicture;
  String? categoryIcon;
  int? status;

  Data(
      {this.id,
      this.categoryName,
      this.bnCategoryName,
      this.categoryPicture,
      this.categoryIcon,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    bnCategoryName = json['bn_category_name'];
    categoryPicture = json['category_picture'];
    categoryIcon = json['category_icon'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['bn_category_name'] = this.bnCategoryName;
    data['category_picture'] = this.categoryPicture;
    data['category_icon'] = this.categoryIcon;
    data['status'] = this.status;
    return data;
  }
}
