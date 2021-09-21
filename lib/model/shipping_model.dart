class ShippingModel {
  String? shippingAmount;
  ShippingModel.fromJson(Map<String, dynamic> json) {
    shippingAmount = json['data'];
  }
}
