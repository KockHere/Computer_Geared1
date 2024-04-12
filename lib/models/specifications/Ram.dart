// ignore_for_file: file_names

class Ram {
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
  int? warranty;
  String? memory;
  String? ramType;
  String? casLatency;
  String? dimmType;
  double? voltage;

  Ram({
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
    this.warranty,
    this.memory,
    this.ramType,
    this.casLatency,
    this.dimmType,
    this.voltage,
  });

  factory Ram.fromJson(Map<String, dynamic> json) => Ram(
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
        warranty: json["warranty"] == null
            ? 0
            : int.parse(json["warranty"]
                .toString()
                .replaceAll(",", "")
                .replaceAll(".", "")),
        memory: json["memory"],
        ramType: json["ram_type"],
        casLatency: json["cas_latency"],
        dimmType: json["dimm_type"],
        voltage: json["voltage"] == null
            ? 0
            : double.parse(json["voltage"]
                .toString()
                .replaceAll(",", "")
                .replaceAll(".", "")),
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
        //"Warranty": warranty,
        "Memory": memory,
        "RAM Type": ramType,
        "CAS Latency": casLatency,
        "DIMM Type": dimmType,
        "Voltage": voltage,
      };
}
