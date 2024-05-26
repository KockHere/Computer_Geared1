class OrderStatus {
  String? statusId;
  String? statusDetails;
  DateTime? updatedAt;

  OrderStatus({
    this.statusId,
    this.statusDetails,
    this.updatedAt,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        statusId: json["status_id"] ?? "",
        statusDetails: json["status_detail"] ?? "",
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "status_id": statusId,
        "status_detail": statusDetails,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
