class CartModel {
  String? cartId;
  String? prodId;
  String? customerId;
  String? prodTitle;
  String? prodImage;
  String? prodPrice;
  String? proddateTime;
  int? prodQuantity;
  String? prodSize;
  String? prodColor;
  // double? total;

  CartModel({
    this.cartId,
    this.prodId,
    this.customerId,
    this.prodTitle,
    this.prodImage,
    this.prodPrice,
    this.proddateTime,
    this.prodQuantity,
    this.prodColor,
    this.prodSize,
    // this.total,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    prodId = json['prodId'];
    customerId = json['customerId'];
    prodTitle = json['prodTitle'];
    prodImage = json['prodImage'];
    prodPrice = json['prodPrice'];
    proddateTime = json['proddateTime'];
    prodQuantity = json['prodQuantity'];
    prodSize = json['prodSize'];
    prodColor = json['prodColor'];
    // total = json['total'];
  }

  toJson() {
    return {
      "cartId": cartId,
      "prodId": prodId,
      "customerId": customerId,
      "prodTitle": prodTitle,
      "prodImage": prodImage,
      "prodPrice": prodPrice,
      "proddateTime": proddateTime,
      "prodQuantity": prodQuantity,
      "prodSize": prodSize,
      "prodColor": prodColor,
      // "total": total,
    };
  }
}
