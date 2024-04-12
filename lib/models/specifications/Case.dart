class Case {
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
  String? model;
  String? cabinetType;
  String? sidePanelType;
  String? color;
  String? motherboardSupports;
  String? internalDriveSize;
  String? gpuLength;
  String? supportPsuSize;
  String? frontPanel;
  String? cpuCoolerSupportSize;

  Case({
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
        "Product Specification type": productSpecificationType,
        "Brand": brand,
        "Model": model,
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
