// ignore_for_file: file_names
class Ward {
  String? districtId;
  String? wardId;
  String? wardName;
  String? wardType;

  Ward({
    this.districtId,
    this.wardId,
    this.wardName,
    this.wardType,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        districtId: json["district_id"] ?? "",
        wardId: json["ward_id"] ?? "",
        wardName: json["ward_name"] ?? "",
        wardType: json["ward_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "ward_id": wardId,
        "ward_name": wardName,
        "ward_type": wardType,
      };
}
