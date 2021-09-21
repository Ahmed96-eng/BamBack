class FavoriteModel {
  int? prodId;
  int? favId;
  String? customerId;
  String? prodTitle;
  String? prodImage;
  String? prodPrice;
  String? proddateTime;

  FavoriteModel({
    this.prodId,
    this.favId,
    this.customerId,
    this.prodTitle,
    this.prodImage,
    this.prodPrice,
    this.proddateTime,
  });

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prodId'];
    favId = json['favId'];
    customerId = json['customersId'];
    prodTitle = json['prodFavTitle'];
    prodImage = json['prodFavImage'];
    prodPrice = json['prodFavPrice'];
    proddateTime = json['prodFavDateTime'];
  }

  toJson() {
    return {
      "prodId": prodId,
      "favId": favId,
      "customersId": customerId,
      "prodFavTitle": prodTitle,
      "prodFavImage": prodImage,
      "prodFavPrice": prodPrice,
      "prodFavDateTime": proddateTime,
    };
  }
}
