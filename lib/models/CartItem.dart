// ignore_for_file: file_names
class CartItem {
  String? cartItemId;
  String? productId;
  String? unitPrice;
  int? quantity;
  List<String>? images;
  String? productName;
  DateTime? createdAt;
  String? categoryName;

  CartItem({
    this.cartItemId,
    this.productId,
    this.unitPrice,
    this.quantity,
    this.images,
    this.productName,
    this.createdAt,
    this.categoryName,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cartItemId: json["cart_item_id"] ?? "",
        productId: json["product_id"] ?? "",
        unitPrice:
            json["unit_price"] == null ? "0" : json["unit_price"].toString(),
        quantity: json["quantity"] == null
            ? 0
            : int.parse(json["quantity"].toString()),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        productName: json["product_name"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        categoryName: json["category_name"] ?? "",
      );

  factory CartItem.fromJson1(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json["cart_item_id"] ?? "",
      productId: json["primary_product_id"] ?? "",
      unitPrice:
          json["unit_price"] == null ? "0" : json["unit_price"].toString(),
      quantity:
          json["quantity"] == null ? 1 : int.parse(json["quantity"].toString()),
      images: json["image_links"] == null ||
              json["image_links"].isEmpty ||
              json["image_links"][0] == null
          ? []
          : List<String>.from(json["image_links"]!.map((x) => x)),
      productName: json["name"] ?? "",
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      categoryName: json["category_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "cart_item_id": cartItemId,
        "product_id": productId,
        "unit_price": unitPrice,
        "quantity": quantity,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "product_name": productName,
        "created_at": createdAt?.toIso8601String(),
        "category_name": categoryName ?? "",
      };
}
