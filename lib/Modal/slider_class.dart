class SliderClass {
  List<Data>? data;

  SliderClass({this.data});

  SliderClass.fromJson(Map<String, dynamic> json) {
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
  String? sliderTitle;
  String? sliderPicture;

  Data({this.sliderTitle, this.sliderPicture});

  Data.fromJson(Map<String, dynamic> json) {
    sliderTitle = json['slider_title'];
    sliderPicture = json['slider_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slider_title'] = this.sliderTitle;
    data['slider_picture'] = this.sliderPicture;
    return data;
  }
}
