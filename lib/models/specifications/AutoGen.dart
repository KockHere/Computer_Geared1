// ignore_for_file: file_names

import 'package:shop_app/models/specifications/Case.dart';
import 'package:shop_app/models/specifications/Gpu.dart';
import 'package:shop_app/models/specifications/Motherboard.dart';
import 'package:shop_app/models/specifications/Processor.dart';
import 'package:shop_app/models/specifications/Ram.dart';
import 'package:shop_app/models/specifications/Storage.dart';

class AutoGen {
    String? preBuildId;
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
    String? totalPrice;

    AutoGen({
        this.preBuildId,
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
        this.totalPrice,
    });

    factory AutoGen.fromJson(Map<String, dynamic> json) => AutoGen(
        preBuildId: json["pre_build_id"],
        motherboardId: json["motherboard_id"],
        motherboardSpecification: json["motherboard_specification"] == null ? null : Motherboard.fromJson(json["motherboard_specification"]),
        processorId: json["processor_id"],
        processorSpecification: json["processor_specification"] == null ? null : Processor.fromJson(json["processor_specification"]),
        caseId: json["case_id"],
        caseSpecification: json["case_specification"] == null ? null : Case.fromJson(json["case_specification"]),
        gpuId: json["gpu_id"],
        gpuSpecification: json["gpu_specification"] == null ? null : Gpu.fromJson(json["gpu_specification"]),
        ramId: json["ram_id"],
        ramSpecification: json["ram_specification"] == null ? null : Ram.fromJson(json["ram_specification"]),
        storageId: json["storage_id"],
        storageSpecification: json["storage_specification"] == null ? null : Storage.fromJson(json["storage_specification"]),
        totalPrice: json["total_price"],
    );

    Map<String, dynamic> toJson() => {
        "pre_build_id": preBuildId,
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
        "total_price": totalPrice,
    };
}
