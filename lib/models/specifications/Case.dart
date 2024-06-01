class Case {
  String? specificationId;
  String? productId;
  String? cabinetType;
  String? sidePanelType;
  String? internalDriveSize;
  String? frontPanel;
  int? cpuCoolerSupportSize;
  int? caseCoolerSupportSize;

  Case({
    this.specificationId,
    this.productId,
    this.cabinetType,
    this.sidePanelType,
    this.internalDriveSize,
    this.frontPanel,
    this.cpuCoolerSupportSize,
    this.caseCoolerSupportSize,
  });

  factory Case.fromJson(Map<String, dynamic> json) => Case(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        cabinetType: json["cabinet_type"],
        sidePanelType: json["side_panel_type"],
        internalDriveSize: json["internal_drive_size"],
        frontPanel: json["front_panel"],
        cpuCoolerSupportSize: json["cpu_cooler_support_size"],
        caseCoolerSupportSize: json["case_cooler_support_size"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "cabinet_type": cabinetType,
        "side_panel_type": sidePanelType,
        "internal_drive_size": internalDriveSize,
        "front_panel": frontPanel,
        "cpu_cooler_support_size": cpuCoolerSupportSize,
        "case_cooler_support_size": caseCoolerSupportSize,
      };
  Map<String, dynamic> toJson1() => {
        //"Specification Id": specificationId,
        //"product_id": productId,
        "Cabinet Type": cabinetType,
        "Side Panel Type": sidePanelType,
        "Internal Drive Size": internalDriveSize,
        "Front Panel": frontPanel,
        "CPU Cooler Support Size": "${cpuCoolerSupportSize} mm",
        "Case Cooler Support Size": "${caseCoolerSupportSize} mm",
      };
  Map<String, dynamic> toJson2() =>
      {"caseId": productId == "" ? null : productId};
}
