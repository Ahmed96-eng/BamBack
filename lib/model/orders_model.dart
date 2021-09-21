class OrdersModel {
  List<OrdersData>? data;
  OrdersModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List).map((e) => OrdersData.fromJson(e)).toList();
  }
}

class OrdersData {
  String? id;
  String? orderStatus;
  String? paymentMethod;
  String? shippingLocation;
  String? paid;
  String? total;
  String? notes;
  String? details;
  String? createdAt;

  OrdersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    shippingLocation = json['shipping_location'];
    paid = json['paid'];
    total = json['total'];
    notes = json['notes'];
    details = json['details'];
    createdAt = json['created_at'];
  }
}
