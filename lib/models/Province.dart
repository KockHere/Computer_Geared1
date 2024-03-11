// ignore_for_file: file_names
class Province {
    String? provinceId;
    String? provinceName;
    String? provinceType;

    Province({
        this.provinceId,
        this.provinceName,
        this.provinceType,
    });

    factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"]  ?? "",
        provinceName: json["province_name"] ?? "",
        provinceType: json["province_type"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province_name": provinceName,
        "province_type": provinceType,
    };
}
