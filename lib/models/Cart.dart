// ignore_for_file: file_names
import 'package:shop_app/models/CartItem.dart';

class Cart {
    String? cartId;
    String? userId;
    DateTime? createdAt;
    String? status;
    List<CartItem>? productList;
    String? productTotal;

    Cart({
        this.cartId,
        this.userId,
        this.createdAt,
        this.status,
        this.productList,
        this.productTotal,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cartId: json["cart_id"] ?? "",
        userId: json["user_id"] ?? "",
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        status: json["status"] ?? "",
        productList: json["product_list"][0]["product_id"] == null ? [] : List<CartItem>.from(json["product_list"]!.map((x) => CartItem.fromJson(x))),
        productTotal: json["product_total"] ?? "0",
    );

    Map<String, dynamic> toJson() => {
        "cart_id": cartId ?? "",
        "user_id": userId ?? "",
        "created_at": createdAt?.toIso8601String(),
        "status": status ?? "",
        "product_list": productList == null ? [] : List<dynamic>.from(productList!.map((x) => x.toJson())),
        "product_total": productTotal ?? "0",
    };
}