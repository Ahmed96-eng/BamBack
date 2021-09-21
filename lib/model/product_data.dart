class ProductData {
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
  String? featured;
  String? status;
  int? rate;

  ProductData.fromJson(Map<String, dynamic> json) {
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
    featured = json['featured'];
    status = json['status'];
    rate = json['rate'];
  }
}
