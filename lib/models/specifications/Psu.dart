class Psu {
  String? specificationId;
  String? productId;
  String? model;
  int? power;

  Psu({
    this.specificationId,
    this.productId,
    this.model,
    this.power,
  });

  factory Psu.fromJson(Map<String, dynamic> json) => Psu(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        model: json["model"],
        power: json["power"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "model": model,
        "power": power,
      };
  Map<String, dynamic> toJson1() => {
        "Model": model,
        "Power": "${power} W",
      };
}
