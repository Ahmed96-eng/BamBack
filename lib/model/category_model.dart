class CategoryModel {
  List<CategoryData>? data;
  CategoryModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] as List).map((e) => CategoryData.fromJson(e)).toList();
  }
}

class CategoryData {
  String? id;
  String? parentId;
  String? title;
  String? image;
  String? noProducts;
  String? status;

  // CategoryData(this.id, this.parentId, this.title, this.image, this.noProducts,
  //     this.createdAt, this.updatedAt, this.status);

  CategoryData.fromJson(Map<String, dynamic> json) {
    id ??= json['id'];
    parentId ??= json['parent_id'];
    title ??= json['title'];
    image ??= json['image'];
    noProducts ??= json['no_products'];
    status ??= json['status'];
  }
}
