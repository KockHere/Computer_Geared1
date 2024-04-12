// ignore_for_file: file_names

import 'package:shop_app/models/specifications/Case.dart';
import 'package:shop_app/models/specifications/CaseCooler.dart';
import 'package:shop_app/models/specifications/CpuCooler.dart';
import 'package:shop_app/models/specifications/Gpu.dart';
import 'package:shop_app/models/specifications/Monitor.dart';
import 'package:shop_app/models/specifications/Motherboard.dart';
import 'package:shop_app/models/specifications/Processor.dart';
import 'package:shop_app/models/specifications/Psu.dart';
import 'package:shop_app/models/specifications/Ram.dart';
import 'package:shop_app/models/specifications/Storage.dart';

class UserPC {
  String? userPcBuildId;
  String? profileName;
  String? motherboardId;
  Motherboard? motherboardSpecification;
  String? processorId;
  Processor? processorSpecification;
  String? caseId;
  Case? caseSpecification;
  String? gpuId;
  Gpu? gpuSpecification;
  String? ramId;
  Ram? ramSpecification;
  String? storageId;
  Storage? storageSpecification;
  String? cpuCoolerId;
  CpuCooler? cpuCoolerSpecification;
  String? caseCoolerId;
  CaseCooler? caseCoolerSpecification;
  String? psuId;
  Psu? psuSpecification;
  String? monitorId;
  Monitor? monitorSpecification;
  int? ramQuantity;
  int? storageQuantity;

  UserPC({
    this.userPcBuildId,
    this.profileName,
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
  });

  factory UserPC.fromJson(Map<String, dynamic> json) => UserPC(
        userPcBuildId: json["user_pc_build_id"],
        profileName: json["profile_name"],
        motherboardId: json["motherboard_id"],
        motherboardSpecification: json["motherboard_specification"] == null
            ? null
            : Motherboard.fromJson(json["motherboard_specification"]),
        processorId: json["processor_id"],
        processorSpecification: json["processor_specification"] == null
            ? null
            : Processor.fromJson(json["processor_specification"]),
        caseId: json["case_id"],
        caseSpecification: json["case_specification"] == null
            ? null
            : Case.fromJson(json["case_specification"]),
        gpuId: json["gpu_id"],
        gpuSpecification: json["gpu_specification"] == null
            ? null
            : Gpu.fromJson(json["gpu_specification"]),
        ramId: json["ram_id"],
        ramSpecification: json["ram_specification"] == null
            ? null
            : Ram.fromJson(json["ram_specification"]),
        storageId: json["storage_id"],
        storageSpecification: json["storage_specification"] == null
            ? null
            : Storage.fromJson(json["storage_specification"]),
        cpuCoolerId: json["cpu_cooler_id"],
        cpuCoolerSpecification: json["cpu_cooler"] == null
            ? null
            : CpuCooler.fromJson(json["cpu_cooler"]),
        caseCoolerId: json["case_cooler_id"],
        caseCoolerSpecification: json["case_cooler"] == null
            ? null
            : CaseCooler.fromJson(json["case_cooler"]),
        psuId: json["psu_id"],
        psuSpecification:
            json["psu"] == null ? null : Psu.fromJson(json["psu"]),
        monitorId: json["monitor_id"],
        monitorSpecification:
            json["monitor"] == null ? null : Monitor.fromJson(json["monitor"]),
        ramQuantity: json["ram_quantity"] ?? 0,
        storageQuantity: json["storage_quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "user_pc_build_id": userPcBuildId,
        "profile_name": profileName,
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
      };
}
