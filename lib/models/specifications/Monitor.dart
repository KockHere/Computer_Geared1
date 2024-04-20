// ignore_for_file: file_names

class Monitor {
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
  String? screenSize;
  String? resolution;
  String? responseTime;
  String? aspectRation;
  String? refreshRate;
  String? panelType;

  Monitor({
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
    this.screenSize,
    this.resolution,
    this.responseTime,
    this.aspectRation,
    this.refreshRate,
    this.panelType,
  });

  factory Monitor.fromJson(Map<String, dynamic> json) => Monitor(
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
        screenSize: json["screen_size"],
        resolution: json["resolution"],
        responseTime: json["response_time"],
        aspectRation: json["aspect_ration"],
        refreshRate: json["refresh_rate"],
        panelType: json["panel_type"],
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
        "screen_size": screenSize,
        "resolution": resolution,
        "response_time": responseTime,
        "aspect_ration": aspectRation,
        "refresh_rate": refreshRate,
        "panel_type": panelType,
      };

  Map<String, dynamic> toJson1() => {
        //"Product Specification Type": productSpecificationType,
        "Brand": brand,
        "Model": model,
        "Screen Size": screenSize,
        "Resolution": resolution,
        "Response Time": responseTime,
        "Aspect Ratio": aspectRation,
        "Refresh Rate": refreshRate,
        "Panel Type": panelType,
      };
}
