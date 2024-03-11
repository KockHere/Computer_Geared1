// ignore_for_file: file_names
class Product {
    String? productId;
    String? name;
    String? description;
    String? unitPrice;
    String? discount;
    int? sold;
    String? categoryName;
    String? brandName;
    List<String>? imageLinks;
    dynamic technicalSpecification;

    Product({
        this.productId,
        this.name,
        this.description,
        this.unitPrice,
        this.discount,
        this.sold,
        this.categoryName,
        this.brandName,
        this.imageLinks,
        this.technicalSpecification,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        unitPrice: json["unit_price"] ?? "",
        discount: json["discount"] ?? "",
        sold: json["sold"],
        categoryName: json["category_name"] ?? "",
        brandName: json["brand_name"] ?? "",
        imageLinks: json["image_links"][0] == null ? [] : List<String>.from(json["image_links"]!.map((x) => x)),
        technicalSpecification: json["technical_specification"] ?? "",
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
        "image_links": imageLinks == null ? [] : List<dynamic>.from(imageLinks!.map((x) => x)),
        "technical_specification": technicalSpecification,
    };
}
