// ignore_for_file: file_names

class CaseCooler {
  String? productId;
  String? name;
  dynamic description;
  int? unitPrice;
  int? discount;
  int? sold;
  String? categoryName;
  String? brandName;
  List<String>? imageLinks;
  String? specificationId;
  String? productSpecificationType;
  String? brand;
  String? model;
  String? airflow;
  String? fanRpm;
  String? size;
  String? color;

  CaseCooler({
    this.productId,
    this.name,
    this.description,
    this.unitPrice,
    this.discount,
    this.sold,
    this.categoryName,
    this.brandName,
    this.imageLinks,
    this.specificationId,
    this.productSpecificationType,
    this.brand,
    this.model,
    this.airflow,
    this.fanRpm,
    this.size,
    this.color,
  });

  factory CaseCooler.fromJson(Map<String, dynamic> json) => CaseCooler(
        productId: json["product_id"] ?? json["primary_product_id"],
        name: json["name"],
        description: json["description"],
        unitPrice: int.parse(json["unit_price"].toString().replaceAll(",", "")),
        discount: json["discount"] == null
            ? 0
            : int.parse(json["discount"]
                .toString()
                .replaceAll(",", "")
                .replaceAll(".", "")),
        sold: json["sold"],
        categoryName: json["category_name"],
        brandName: json["brand_name"],
        imageLinks: json["image_links"] == null ||
                json["image_links"].isEmpty ||
                json["image_links"][0] == null
            ? []
            : List<String>.from(json["image_links"]!.map((x) => x)),
        specificationId: json["specification_id"],
        productSpecificationType: json["product_specification_type"],
        brand: json["brand"],
        model: json["model"],
        airflow: json["airflow"],
        fanRpm: json["fan_rpm"],
        size: json["size"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "description": description,
        "unit_price": unitPrice,
        "discount": discount,
        "sold": sold,
        "category_name": categoryName,
        "brand_name": brandName,
        "image_links": imageLinks == null
            ? []
            : List<dynamic>.from(imageLinks!.map((x) => x)),
        "specification_id": specificationId,
        "product_specification_type": productSpecificationType,
        "brand": brand,
        "model": model,
        "airflow": airflow,
        "fan_rpm": fanRpm,
        "size": size,
        "color": color,
      };

  Map<String, dynamic> toJson1() => {
        //"Product Specification Type": productSpecificationType,
        "Brand": brand,
        "Model": model,
        "Airflow": airflow,
        "Fan RPM": fanRpm,
        "Size": size,
        "Color": color,
      };
}
