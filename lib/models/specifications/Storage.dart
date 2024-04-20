// ignore_for_file: file_names

class Storage {
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
  String? type;
  String? rpm;
  int? cacheMemory;
  int? storageInterface;
  String? formFactor;
  String? capacity;

  Storage({
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
    this.type,
    this.rpm,
    this.cacheMemory,
    this.storageInterface,
    this.formFactor,
    this.capacity,
  });

  factory Storage.fromJson(Map<String, dynamic> json) => Storage(
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
        type: json["type"],
        rpm: json["rpm"],
        cacheMemory: json["cache_memory"],
        storageInterface: json["interface"],
        formFactor: json["form_factor"],
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "primary_product_id": primaryProductId,
        "storage_id": productId,
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
        "type": type,
        "rpm": rpm,
        "cache_memory": cacheMemory,
        "interface": storageInterface,
        "form_factor": formFactor,
        "capacity": capacity,
      };

  Map<String, dynamic> toJson1() => {
        //"Product Specification Type": productSpecificationType,
        "Brand": brand,
        "Model": model,
        "Type": type,
        "Interface": storageInterface,
        "Form Factor": formFactor,
        "Capacity": capacity,
      };
}
