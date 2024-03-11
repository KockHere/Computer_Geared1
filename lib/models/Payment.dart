// ignore_for_file: file_names
class Payment {
  String? paymentId;
  String? paymentImage;
  String? paymentMethod;

  Payment({this.paymentId, this.paymentImage, this.paymentMethod});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["payment_id"] ?? "",
        paymentImage: json["payment_image"] ?? "",
        paymentMethod: json["payment_method"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "payment_image": paymentImage,
        "payment_method": paymentMethod,
    };
}
