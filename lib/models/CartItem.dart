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
        unitPrice: json["unit_price"] ?? "0",
        quantity: json["quantity"] ?? 0,
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        productName: json["product_name"] ?? "",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_item_id": cartItemId,
        "product_id": productId,
        "unit_price": unitPrice,
        "quantity": quantity,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "product_name": productName,
        "created_at": createdAt?.toIso8601String(),
      };
}
