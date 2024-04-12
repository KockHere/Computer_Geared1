// ignore_for_file: file_names

class Gpu {
  String? primaryProductId;
  String? name;
  dynamic description;
  int? unitPrice;
  String? price;
  int? discount;
  int? sold;
  String? categoryName;
  String? brandName;
  List<String>? imageLinks;
  String? specificationId;
  String? productId;
  String? productSpecificationType;
  String? brand;
  String? chipset;
  String? memory;
  int? benchmark;
  int? maxPowerConsumption;
  int? clockSpeed;
  int? baseClockSpeed;
  int? length;
  String? frameSync;
  String? coolerTyper;
  String? gpuInterface;
  String? supportApi;

  Gpu({
    this.primaryProductId,
    this.name,
    this.description,
    this.unitPrice,
    this.price,
    this.discount,
    this.sold,
    this.categoryName,
    this.brandName,
    this.imageLinks,
    this.specificationId,
    this.productId,
    this.productSpecificationType,
    this.brand,
    this.chipset,
    this.memory,
    this.benchmark,
    this.maxPowerConsumption,
    this.clockSpeed,
    this.baseClockSpeed,
    this.length,
    this.frameSync,
    this.coolerTyper,
    this.gpuInterface,
    this.supportApi,
  });

  factory Gpu.fromJson(Map<String, dynamic> json) => Gpu(
        primaryProductId: json["primary_product_id"],
        name: json["name"],
        description: json["description"],
        unitPrice: int.parse(json["unit_price"].toString().replaceAll(",", "")),
        price: json["price"],
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
        productId: json["product_id"],
        productSpecificationType: json["product_specification_type"],
        brand: json["brand"],
        chipset: json["chipset"],
        memory: json["memory"],
        benchmark: json["benchmark"] == null
            ? 0
            : int.parse(json["benchmark"]
                .toString()
                .replaceAll(",", "")
                .replaceAll(".", "")),
        maxPowerConsumption: json["max_power_consumption"],
        clockSpeed: json["clock_speed"],
        baseClockSpeed: json["base_clock_speed"],
        length: json["length"] == null
            ? 0
            : int.parse(json["length"]
                .toString()
                .replaceAll(",", "")
                .replaceAll(".", "")),
        frameSync: json["frame_sync"],
        coolerTyper: json["cooler_typer"],
        gpuInterface: json["interface"],
        supportApi: json["support_api"],
      );

  Map<String, dynamic> toJson() => {
        "primary_product_id": primaryProductId,
        "name": name,
        "description": description,
        "unit_price": unitPrice,
        "price": price,
        "discount": discount,
        "sold": sold,
        "category_name": categoryName,
        "brand_name": brandName,
        "image_links": imageLinks == null
            ? []
            : List<dynamic>.from(imageLinks!.map((x) => x)),
        "specification_id": specificationId,
        "product_id": productId,
        "Product Specification Type": productSpecificationType,
        "Brand": brand,
        "Chipset": chipset,
        "Memory": memory,
        "Benchmark": benchmark,
        "Max Power Consumption": maxPowerConsumption,
        //"Clock Speed": clockSpeed,
        "Base Clock Speed": baseClockSpeed,
        "Length": length,
        //"Frame_sync": frameSync,
        "Cooler Type": coolerTyper,
        "Interface": gpuInterface,
        //"support_api": supportApi,
      };
}
