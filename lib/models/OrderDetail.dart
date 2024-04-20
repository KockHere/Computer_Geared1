class OrderDetail {
    int? quantity;
    String? productId;
    int? unitPrice;
    String? productImg;
    String? productName;
    String? orderDetailId;

    OrderDetail({
        this.quantity,
        this.productId,
        this.unitPrice,
        this.productImg,
        this.productName,
        this.orderDetailId,
    });

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        quantity: json["quantity"],
        productId: json["product_id"],
        unitPrice: json["unit_price"],
        productImg: json["product_img"],
        productName: json["product_name"],
        orderDetailId: json["order_detail_id"],
    );

    Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "product_id": productId,
        "unit_price": unitPrice,
        "product_img": productImg,
        "product_name": productName,
        "order_detail_id": orderDetailId,
    };
}