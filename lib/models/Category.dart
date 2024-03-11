// ignore_for_file: file_names
class Category {
    String? categoryId;
    String? parentId;
    String? name;
    String? status;
    String? description;
    String? image;
    DateTime? createdAt;

    Category({
        this.categoryId,
        this.parentId,
        this.name,
        this.status,
        this.description,
        this.image,
        this.createdAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"] ?? "",
        parentId: json["parent_id"] ?? "",
        name: json["name"] ?? "",
        status: json["status"] ?? "",
        description: json["description"] ?? "",
        image: json["image"] ?? "",
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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
