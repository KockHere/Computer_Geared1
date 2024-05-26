class Review {
  int? rating;
  String? review;
  String? reviewUser;
  String? productName;

  Review({
    this.rating,
    this.review,
    this.reviewUser,
    this.productName,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"] ?? 1,
        review: json["review"] ?? "",
        reviewUser: json["review_user"] ?? "",
        productName: json["product_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "review": review,
        "review_user": reviewUser,
        "product_name": productName,
      };
}
