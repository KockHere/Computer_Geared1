// ignore_for_file: file_names
class Product {
  String? productId;
  String? primaryProductId;
  String? name;
  String? description;
  String? unitPrice;
  String? discount;
  int? sold;
  String? categoryName;
  String? productBrandId;
  String? brandName;
  List<String>? imageLinks;
  dynamic technicalSpecification;
  int? power;
  int? quantityCart;

  Product({
    this.productId,
    this.primaryProductId,
    this.name,
    this.description,
    this.unitPrice,
    this.discount,
    this.sold,
    this.categoryName,
    this.productBrandId,
    this.brandName,
    this.imageLinks,
    this.technicalSpecification,
    this.power,
    this.quantityCart,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json["product_id"] ?? json["primary_product_id"] ?? "",
      primaryProductId: json["primary_product_id"] ?? json["product_id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      unitPrice:
          json["unit_price"] == null ? "0" : json["unit_price"].toString(),
      discount: json["discount"] == null ? "" : json["unit_price"].toString(),
      sold: json["sold"],
      categoryName: json["category_name"] ?? "",
      //productBrandId: json["product_brand_id"] ?? "",
      brandName: json["brand_name"] ?? "",
      imageLinks: json["image_links"] == null ||
              json["image_links"].isEmpty ||
              json["image_links"][0] == null
          ? []
          : List<String>.from(json["image_links"]!.map((x) => x ?? "")),
      technicalSpecification: json["technical_specification"] ?? "",
      power: json["power"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "description": description,
        "unit_price": unitPrice,
        "discount": discount,
        "sold": sold,
        "category_name": categoryName,
        //"product_brand_id": productBrandId,
        "brand_name": brandName,
        "image_links": imageLinks == null
            ? []
            : List<dynamic>.from(imageLinks!.map((x) => x)),
        "technical_specification": technicalSpecification,
      };
}
