// ignore_for_file: file_names

import 'package:shop_app/models/OrderDetail.dart';

class Orders {
    String? orderId;
    String? userId;
    String? statusId;
    String? total;
    String? paymentId;
    String? shippingFee;
    DateTime? createdAt;
    int? quantity;
    DateTime? paymentDate;
    bool? vnpayStatus;
    String? addressId;
    String? statusDetail;
    String? paymentMethod;
    List<OrderDetail>? orderDetails;
    String? totalItems;
    String? recipientName;
    String? streetAddress;
    String? city;

    Orders({
        this.orderId,
        this.userId,
        this.statusId,
        this.total,
        this.paymentId,
        this.shippingFee,
        this.createdAt,
        this.quantity,
        this.paymentDate,
        this.vnpayStatus,
        this.addressId,
        this.statusDetail,
        this.paymentMethod,
        this.orderDetails,
        this.totalItems,
        this.recipientName,
        this.streetAddress,
        this.city,
    });

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderId: json["order_id"],
        userId: json["user_id"],
        statusId: json["status_id"],
        total: json["total"],
        paymentId: json["payment_id"],
        shippingFee: json["shipping_fee"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        quantity: json["quantity"],
        paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
        vnpayStatus: json["vnpay_status"] ?? false,
        addressId: json["address_id"],
        statusDetail: json["status_detail"],
        paymentMethod: json["payment_method"],
        orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
        totalItems: json["total_items"],
        recipientName: json["recipient_name"],
        streetAddress: json["street_address"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "status_id": statusId,
        "total": total,
        "payment_id": paymentId,
        "shipping_fee": shippingFee,
        "created_at": createdAt?.toIso8601String(),
        "quantity": quantity,
        "payment_date": paymentDate?.toIso8601String(),
        "vnpay_status": vnpayStatus,
        "address_id": addressId,
        "status_detail": statusDetail,
        "payment_method": paymentMethod,
        "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
        "total_items": totalItems,
        "recipient_name": recipientName,
        "street_address": streetAddress,
        "city": city,
    };
}