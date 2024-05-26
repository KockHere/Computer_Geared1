// ignore_for_file: file_names

class Processor {
  String? specificationId;
  String? productId;
  String? model;
  String? microArchitecture;
  String? clockSpeed;
  String? boostSpeedMax;
  int? cache;
  String? memorySupport;
  int? power;
  String? id;
  String? processorChipset;
  DateTime? createdAt;
  int? processorSocket;
  String? label;

  Processor({
    this.specificationId,
    this.productId,
    this.model,
    this.microArchitecture,
    this.clockSpeed,
    this.boostSpeedMax,
    this.cache,
    this.memorySupport,
    this.power,
    this.id,
    this.processorChipset,
    this.createdAt,
    this.processorSocket,
    this.label,
  });

  factory Processor.fromJson(Map<String, dynamic> json) => Processor(
        specificationId: json["specification_id"] ?? "",
        productId: json["product_id"] ?? "",
        model: json["model"],
        microArchitecture: json["micro_architecture"],
        clockSpeed: json["clock_speed"],
        boostSpeedMax: json["boost_speed_max"],
        cache: json["cache"],
        memorySupport: json["memory_support"],
        power: json["power"],
        id: json["id"],
        processorChipset: json["processor_chipset"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        processorSocket: json["processor_socket"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "model": model,
        "micro_architecture": microArchitecture,
        "clock_speed": clockSpeed,
        "boost_speed_max": boostSpeedMax,
        "cache": cache,
        "memory_support": memorySupport,
        "power": power,
        "id": id,
        "processor_chipset": processorChipset,
        "created_at": createdAt?.toIso8601String(),
        "processor_socket": processorSocket,
        "label": label,
      };

  Map<String, dynamic> toJson1() => {
        "Model": model,
        "Micro Architecture": microArchitecture,
        "Clock Speed": clockSpeed,
        "Boost Speed Max": boostSpeedMax,
        "Cache": cache,
        "Memory Support": memorySupport,
        "Power": power,
        //"Id": id,
        "Processor Chipset": processorChipset,
        //"Created At": createdAt?.toIso8601String(),
        "Processor Socket": processorSocket,
        "Label": label,
      };
  Map<String, dynamic> toJson2() =>
      {"processorId": productId == "" ? null : productId};
}
