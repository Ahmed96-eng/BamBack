class OffersProductModel {
  List<OffersProductData>? data;
  OffersProductModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List)
        .map((e) => OffersProductData.fromJson(e))
        .toList();
  }
}

class OffersProductData {
  String? id;
  String? categoryId;
  String? productName;
  String? productImage;
  String? productDescription;
  String? price;
  String? sale;
  String? stock;
  String? size;
  String? color;
  String? noSales;
  int? discount;
  int? rate;
  String? featured;
  String? status;
  String? createdAt;

  OffersProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    price = json['price'];
    sale = json['sale'];
    stock = json['stock'];
    size = json['size'];
    color = json['color'];
    noSales = json['no_sales'];
    discount = json['discount'];
    rate = json['rate'];
    featured = json['featured'];
    status = json['status'];
    createdAt = json['created_at'];
  }
}
