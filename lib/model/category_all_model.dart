class AllCategoryModel {
  List<AllCategoryData>? data;
  AllCategoryModel.fromJson(Map<String, dynamic> json) {
    data =
        (json['data'] as List).map((e) => AllCategoryData.fromJson(e)).toList();
  }
}

class AllCategoryData {
  String? id;
  String? parentId;
  String? title;
  String? image;
  String? noProducts;
  String? status;

  // AllCategoryData(this.id, this.parentId, this.title, this.image, this.noProducts,
  //     this.createdAt, this.updatedAt, this.status);

  AllCategoryData.fromJson(Map<String, dynamic> json) {
    id ??= json['id'];
    parentId ??= json['parent_id'];
    title ??= json['title'];
    image ??= json['image'];
    noProducts ??= json['no_products'];
    status ??= json['status'];
  }
}
