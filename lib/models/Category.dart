// ignore_for_file: file_names
class Category {
  String? categoryId;
  String? parentId;
  String? name;
  String? status;
  String? description;
  String? image;
  DateTime? createdAt;

  List<Brand>? brandList;

  

  Category({
    this.categoryId,
    this.parentId,
    this.name,
    this.status,
    this.description,
    this.image,
    this.createdAt,
    this.brandList,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"] ?? "",
        parentId: json["parent_id"] ?? "",
        name: json["name"] ?? "",
        status: json["status"] ?? "",
        description: json["description"] ?? "",
        image: json["image"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        brandList: json["brand_list"] == null ? [] : List<Brand>.from(json["brand_list"]!.map((x) => Brand.fromJson(x))),    
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "parent_id": parentId,
        "name": name,
        "status": status,
        "description": description,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
      };
}

class Brand {
  String? productBrandId;
  String? productBrandName;

  Brand({
    this.productBrandId,
    this.productBrandName,
  });
  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        productBrandId: json["product_brand_id"] ?? "",
        productBrandName: json["product_brand_name"] ?? "",
      );
}
