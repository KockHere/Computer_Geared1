// ignore_for_file: file_names

class ShippingAddress {
  String? addressId;
  String? recipientName;
  String? streetAddress;
  String? city;
  String? country;
  String? district;
  String? ward;
  String? recipientPhone;

  ShippingAddress({
    this.addressId,
    this.recipientName,
    this.streetAddress,
    this.city,
    this.country,
    this.district,
    this.ward,
    this.recipientPhone,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        addressId: json["address_id"] ?? "",
        recipientName: json["recipient_name"] ?? "",
        streetAddress: json["street_address"] ?? "",
        city: json["city"] ?? "",
        country: json["country"] ?? "",
        district: json["district"] ?? "",
        ward: json["ward"] ?? "",
        recipientPhone: json["recipient_phone"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "recipient_name": recipientName,
        "street_address": streetAddress,
        "city": city,
        "country": country,
        "district": district,
        "ward": ward,
        "recipient_phone": recipientPhone,
      };
}
