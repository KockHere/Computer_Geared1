// ignore_for_file: file_names

class CpuCooler {
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
  String? cpuCooler;
  String? fanRpm;
  String? noiseLevel;
  String? fanNumber;
  String? cpuCoolerSize;

  CpuCooler({
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
    this.cpuCooler,
    this.fanRpm,
    this.noiseLevel,
    this.fanNumber,
    this.cpuCoolerSize,
  });

  factory CpuCooler.fromJson(Map<String, dynamic> json) => CpuCooler(
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
        cpuCooler: json["cpu_cooler"],
        fanRpm: json["fan_rpm"],
        noiseLevel: json["noise_level"],
        fanNumber: json["fan_number"],
        cpuCoolerSize: json["cpu_cooler_size"].toString(),
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
        "cpu_cooler": cpuCooler,
        "fan_rpm": fanRpm,
        "noise_level": noiseLevel,
        "fan_number": fanNumber,
        "cpu_cooler_size": cpuCoolerSize,
      };

  Map<String, dynamic> toJson1() => {
        //"Product Specification Type": productSpecificationType,
        "Brand": brand,
        "Model": model,
        "CPU Cooler": cpuCooler,
        "Fan RPM": fanRpm,
        "Noise Level": noiseLevel,
        "Fan Number": fanNumber,
        "CPU Cooler Size": cpuCoolerSize,
      };
}
