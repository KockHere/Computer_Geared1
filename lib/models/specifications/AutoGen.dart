// ignore_for_file: file_names

import 'package:shop_app/models/Product.dart';

class AutoGen {
  String? motherboardId;
  Product? motherboardSpecification;
  String? processorId;
  Product? processorSpecification;
  String? caseId;
  Product? caseSpecification;
  String? gpuId;
  Product? gpuSpecification;
  String? ramId;
  Product? ramSpecification;
  String? storageId;
  Product? storageSpecification;
  String? cpuCoolerId;
  Product? cpuCoolerSpecification;
  String? caseCoolerId;
  Product? caseCoolerSpecification;
  String? psuId;
  Product? psuSpecification;
  String? monitorId;
  Product? monitorSpecification;
  int? ramQuantity;
  int? storageQuantity;
  int? totalPrice;
  String? purposeName;

  AutoGen({
    this.motherboardId,
    this.motherboardSpecification,
    this.processorId,
    this.processorSpecification,
    this.caseId,
    this.caseSpecification,
    this.gpuId,
    this.gpuSpecification,
    this.ramId,
    this.ramSpecification,
    this.storageId,
    this.storageSpecification,
    this.cpuCoolerId,
    this.cpuCoolerSpecification,
    this.caseCoolerId,
    this.caseCoolerSpecification,
    this.psuId,
    this.psuSpecification,
    this.monitorId,
    this.monitorSpecification,
    this.ramQuantity,
    this.storageQuantity,
    this.totalPrice,
    this.purposeName,
  });

  factory AutoGen.fromJson(Map<String, dynamic> json) => AutoGen(
        motherboardId: json["motherboard_id"],
        motherboardSpecification: json["motherboard_specification"] == null
            ? null
            : Product.fromJson(json["motherboard_specification"][0]),
        processorId: json["processor_id"],
        processorSpecification: json["processor_specification"] == null
            ? null
            : Product.fromJson(json["processor_specification"][0]),
        caseId: json["case_id"],
        caseSpecification: json["case_specification"] == null
            ? null
            : Product.fromJson(json["case_specification"][0]),
        gpuId: json["gpu_id"],
        gpuSpecification: json["gpu_specification"] == null
            ? null
            : Product.fromJson(json["gpu_specification"][0]),
        ramId: json["ram_id"],
        ramSpecification: json["ram_specification"] == null
            ? null
            : Product.fromJson(json["ram_specification"][0]),
        storageId: json["storage_id"],
        storageSpecification: json["storage_specification"] == null
            ? null
            : Product.fromJson(json["storage_specification"][0]),
        cpuCoolerId: json["cpu_cooler_id"],
        cpuCoolerSpecification: json["cpu_cooler"] == null
            ? null
            : Product.fromJson(json["cpu_cooler"][0]),
        caseCoolerId: json["case_cooler_id"],
        caseCoolerSpecification: json["case_cooler"] == null
            ? null
            : Product.fromJson(json["case_cooler"][0]),
        psuId: json["psu_id"],
        psuSpecification:
            json["psu"] == null ? null : Product.fromJson(json["psu"][0]),
        monitorId: json["monitor_id"],
        monitorSpecification: json["monitor"] == null
            ? null
            : Product.fromJson(json["monitor"][0]),
        ramQuantity: json["ram_quantity"] ?? 0,
        storageQuantity: json["storage_quantity"] ?? 0,
        totalPrice: json["total_price"] == null
            ? 0
            : int.parse(json["total_price"]
                .toString()
                .replaceAll(".00", "")
                .replaceAll(",", "")),
        purposeName: json["purpose_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "motherboard_id": motherboardId,
        "motherboard_specification": motherboardSpecification?.toJson(),
        "processor_id": processorId,
        "processor_specification": processorSpecification?.toJson(),
        "case_id": caseId,
        "case_specification": caseSpecification?.toJson(),
        "gpu_id": gpuId,
        "gpu_specification": gpuSpecification?.toJson(),
        "ram_id": ramId,
        "ram_specification": ramSpecification?.toJson(),
        "storage_id": storageId,
        "storage_specification": storageSpecification?.toJson(),
        "cpu_cooler_id": cpuCoolerId,
        "cpu_cooler": cpuCoolerSpecification?.toJson(),
        "case_cooler_id": caseCoolerId,
        "case_cooler": caseCoolerSpecification?.toJson(),
        "psu_id": psuId,
        "psu": psuSpecification?.toJson(),
        "monitor_id": monitorId,
        "monitor": monitorSpecification?.toJson(),
        "ram_quantity": ramQuantity ?? 0,
        "storage_quantity": storageQuantity ?? 0,
        "purpose_id": 3,
      };
}
