// ignore_for_file: file_names

class Processor {
  String? primaryProductId;
  String? name;
  dynamic description;
  int? unitPrice;
  String? price;
  int? discount;
  int? sold;
  String? categoryName;
  String? productBrandId;
  String? brandName;
  List<String>? imageLinks;
  String? specificationId;
  String? productId;
  String? productSpecificationType;
  String? brand;
  int? model;
  String? socket;
  String? microArchitecture;
  int? coreQuantity;
  int? threadsQuantity;
  double? clockSpeed;
  double? boostSpeedMax;
  int? cache;
  int? memorySupport;
  dynamic eccMemory;
  String? channelArchitecture;
  int? power;
  String? graphicChipset;
  String? chipset;

  Processor({
    this.primaryProductId,
    this.name,
    this.description,
    this.unitPrice,
    this.price,
    this.discount,
    this.sold,
    this.categoryName,
    this.productBrandId,
    this.brandName,
    this.imageLinks,
    this.specificationId,
    this.productId,
    this.productSpecificationType,
    this.brand,
    this.model,
    this.socket,
    this.microArchitecture,
    this.coreQuantity,
    this.threadsQuantity,
    this.clockSpeed,
    this.boostSpeedMax,
    this.cache,
    this.memorySupport,
    this.eccMemory,
    this.channelArchitecture,
    this.power,
    this.graphicChipset,
    this.chipset,
  });

  factory Processor.fromJson(Map<String, dynamic> json) => Processor(
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
        productBrandId: json["product_brand_id"] ?? "",
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
        model: json["model"],
        socket: json["socket"],
        microArchitecture: json["micro_architecture"],
        coreQuantity: json["core_quantity"],
        threadsQuantity: json["threads_quantity"],
        clockSpeed: json["discount"] == null
            ? 0
            : double.parse(json["discount"]
                .toString()
                .replaceAll(",", "")
                .replaceAll(".", "")),
        boostSpeedMax: json["boost_speed_max"] == null
            ? 0
            : double.parse(json["boost_speed_max"].toString()),
        cache: json["cache"],
        memorySupport: json["memory_support"],
        eccMemory: json["ecc_memory"],
        channelArchitecture: json["channel_architecture"],
        power: json["power"],
        graphicChipset: json["graphic_chipset"],
        chipset: json["chipset"],
      );

  Map<String, dynamic> toJson() => {
        "primary_product_id": primaryProductId,
        "processor_id": productId,
        "name": name,
        "description": description,
        "unit_price": unitPrice,
        "price": price,
        "discount": discount,
        "sold": sold,
        "category_name": categoryName,
        "product_brand_id": productBrandId,
        "brand_name": brandName,
        "image_links": imageLinks == null
            ? []
            : List<dynamic>.from(imageLinks!.map((x) => x)),
        "specification_id": specificationId,
        "product_id": productId,
        "product_specification_type": productSpecificationType,
        "brand": brand,
        "model": model,
        "socket": socket,
        "micro_architecture": microArchitecture,
        "core_quantity": coreQuantity,
        "threads_quantity": threadsQuantity,
        "clock_speed": clockSpeed, //lay nham thanh discount
        "boost_speed_max": boostSpeedMax,
        "cache": cache,
        "memory_support": memorySupport,
        //"ecc_memory": eccMemory,
        "channel_architecture": channelArchitecture,
        "power": power,
        //"Graphic Chipset": graphicChipset,
        "chipset": chipset,
      };

  Map<String, dynamic> toJson1() => {
        //"Product Specification Type": productSpecificationType,
        "Brand": brand,
        "Model": model,
        "Socket": socket,
        "Micro Architecture": microArchitecture,
        "Core Quantity": coreQuantity,
        "Threads Quantity": threadsQuantity,
        "Clock Speed": clockSpeed,
        "Boost Speed Max": boostSpeedMax,
        "Cache": cache,
        "Memory Support": memorySupport,
        "Channel Architecture": channelArchitecture,
        "Power": power,
        "Chipset": chipset,
      };
}
