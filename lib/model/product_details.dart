class ProductDetailsModel {
  ProductDetailsData? data;
  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    data = ProductDetailsData.fromJson(json['data']);
  }
}

class ProductDetailsData {
  String? id;
  String? categoryId;
  String? productName;
  String? productImage;
  String? productDescription;
  String? price;
  String? sale;
  String? stock;
  // String? size;
  // String? color;
  String? noSales;
  int? discount;
  int? rate;
  String? featured;
  String? status;
  List? images = [];
  List? sizes = [];
  List? colors = [];

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    price = json['price'];
    sale = json['sale'];
    stock = json['stock'];
    // size = json['size'];
    // color = json['color'];
    noSales = json['no_sales'];
    discount = json['discount'];
    rate = json['rate'];
    featured = json['featured'];
    status = json['status'];
    images = json['images'];

    sizes = json['size'];
    colors = json['color'];
  }
}

// class ImagesList {
//   String? image;
//   ImagesList.fromJson(Map<String, dynamic> json) {
//     image = json['images'];
//   }
// }
