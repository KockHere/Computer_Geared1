// ignore_for_file: file_names

class BuildPurpose {
  String? purposeId;
  String? purposeName;

  BuildPurpose({
    this.purposeId,
    this.purposeName,
  });

  factory BuildPurpose.fromJson(Map<String, dynamic> json) => BuildPurpose(
        purposeId: json["purpose_id"] ?? "",
        purposeName: json["purpose_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "purpose_id": purposeId ?? "",
        "purpose_name": purposeName ?? "",
      };
}
