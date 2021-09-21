class SubCategoryModel {
  List<SubCategoryData>? data;
  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    data =
        (json['data'] as List).map((e) => SubCategoryData.fromJson(e)).toList();
  }
}

class SubCategoryData {
  String? id;
  String? parentId;
  String? title;
  String? image;
  String? noProducts;
  String? status;

  // SubCategoryData(this.id, this.parentId, this.title, this.image, this.noProducts,
  //     this.createdAt, this.updatedAt, this.status);

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id ??= json['id'];
    parentId ??= json['parent_id'];
    title ??= json['title'];
    image ??= json['image'];
    noProducts ??= json['no_products'];
    status ??= json['status'];
  }
}
