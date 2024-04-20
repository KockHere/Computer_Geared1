class Case {
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
  String? model;
  String? cabinetType;
  String? sidePanelType;
  String? color;
  String? motherboardSupports;
  String? internalDriveSize;
  int? gpuLength;
  String? supportPsuSize;
  String? frontPanel;
  int? cpuCoolerSupportSize;

  Case({
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
    this.cabinetType,
    this.sidePanelType,
    this.color,
    this.motherboardSupports,
    this.internalDriveSize,
    this.gpuLength,
    this.supportPsuSize,
    this.frontPanel,
    this.cpuCoolerSupportSize,
  });

  factory Case.fromJson(Map<String, dynamic> json) => Case(
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
        cabinetType: json["cabinet_type"],
        sidePanelType: json["side_panel_type"],
        color: json["color"],
        motherboardSupports: json["motherboard_supports"],
        internalDriveSize: json["internal_drive_size"],
        gpuLength: json["gpu_length"],
        supportPsuSize: json["support_psu_size"],
        frontPanel: json["front_panel"],
        cpuCoolerSupportSize: json["cpu_cooler_support_size"],
      );

  Map<String, dynamic> toJson() => {
        "primary_product_id": primaryProductId,
        "case_id": productId,
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
        "cabinet_type": cabinetType,
        "side_panel_type": sidePanelType,
        "color": color,
        "motherboard_supports": motherboardSupports,
        "internal_drive_size": internalDriveSize,
        "gpu_length": gpuLength,
        "support_psu_size": supportPsuSize,
        "front_panel": frontPanel,
        "cpu_cooler_support_size": cpuCoolerSupportSize,
      };

  Map<String, dynamic> toJson1() => {
        //"Product Specification type": productSpecificationType,
        "Brand": brand,
        "Cabinet Type": cabinetType,
        "Side Panel Type": sidePanelType,
        "Color": color,
        "Motherboard Supports": motherboardSupports,
        "Internal Drive Size": internalDriveSize,
        "GPU Length": gpuLength,
        "Support PSU Size": supportPsuSize,
        "Front Panel": frontPanel,
        "CPU Cooler Support Size": cpuCoolerSupportSize,
      };
}
