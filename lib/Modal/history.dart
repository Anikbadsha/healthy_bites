class OrderList {
  List<Data>? data;

  OrderList({this.data});

  OrderList.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? phone;
  String? area;
  String? address;
  String? paymentStatus;
  String? paymentType;
  Null orderId;
  int? subTotal;
  int? shippingCharge;
  String? discoutn;
  int? total;
  String? saleDate;
  String? orderStatus;

  Data(
      {this.id,
      this.name,
      this.phone,
      this.area,
      this.address,
      this.paymentStatus,
      this.paymentType,
      this.orderId,
      this.subTotal,
      this.shippingCharge,
      this.discoutn,
      this.total,
      this.saleDate,
      this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    area = json['area'];
    address = json['address'];
    paymentStatus = json['payment_status'];
    paymentType = json['Payment_type'];
    orderId = json['order_id'];
    subTotal = json['sub_total'];
    shippingCharge = json['shipping_charge'];
    discoutn = json['discoutn'];
    total = json['total'];
    saleDate = json['sale_date'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['area'] = this.area;
    data['address'] = this.address;
    data['payment_status'] = this.paymentStatus;
    data['Payment_type'] = this.paymentType;
    data['order_id'] = this.orderId;
    data['sub_total'] = this.subTotal;
    data['shipping_charge'] = this.shippingCharge;
    data['discoutn'] = this.discoutn;
    data['total'] = this.total;
    data['sale_date'] = this.saleDate;
    data['order_status'] = this.orderStatus;
    return data;
  }
}
