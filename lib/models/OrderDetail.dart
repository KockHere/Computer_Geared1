class OrderDetail {
    int? quantity;
    String? productId;
    int? unitPrice;
    String? orderDetailId;

    OrderDetail({
        this.quantity,
        this.productId,
        this.unitPrice,
        this.orderDetailId,
    });

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        quantity: json["quantity"],
        productId: json["product_id"],
        unitPrice: json["unit_price"],
        orderDetailId: json["order_detail_id"],
    );

    Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "product_id": productId,
        "unit_price": unitPrice,
        "order_detail_id": orderDetailId,
    };
}