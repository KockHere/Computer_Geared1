// ignore_for_file: file_names
class District {
  String? districtId;
  String? districtName;
  String? districtType;
  String? lat;
  String? lng;
  String? provinceId;

  District({
    this.districtId,
    this.districtName,
    this.districtType,
    this.lat,
    this.lng,
    this.provinceId,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"] ?? "",
        districtName: json["district_name"] ?? "",
        districtType: json["district_type"] ?? "",
        lat: json["lat"] ?? "",
        lng: json["lng"] ?? "",
        provinceId: json["province_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
        "district_type": districtType,
        "lat": lat,
        "lng": lng,
        "province_id": provinceId,
      };
}
