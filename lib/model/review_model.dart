class ReviewModel {
  List<ReviewData>? data;
  ReviewModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List).map((e) => ReviewData.fromJson(e)).toList();
  }
}

class ReviewData {
  String? id;
  String? productId;
  String? userId;
  String? review;
  String? createdAt;
  String? customerName;
  String? customerImage;

  // ReviewData(this.id, this.ProductId, this.userId, this.review, this.createdAt,
  //     this.createdAt, this.updatedAt, this.status);

  ReviewData.fromJson(Map<String, dynamic> json) {
    id ??= json['id'];
    productId ??= json['product_id'];
    userId ??= json['customer_id'];
    review ??= json['review'];
    createdAt ??= json['created_at'];
    customerName ??= json['customer_name'];
    customerImage ??= json['customer_image'];
  }
}
