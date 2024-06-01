class Gpu {
  String? specificationId;
  String? productId;
  String? chipset;
  int? memory;
  int? maxPowerConsumption;
  int? baseClockSpeed;
  String? length;
  String? coolerType;
  String? gpuInterface;

  Gpu({
    this.specificationId,
    this.productId,
    this.chipset,
    this.memory,
    this.maxPowerConsumption,
    this.baseClockSpeed,
    this.length,
    this.coolerType,
    this.gpuInterface,
  });

  factory Gpu.fromJson(Map<String, dynamic> json) => Gpu(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        chipset: json["chipset"],
        memory: json["memory"],
        maxPowerConsumption: json["max_power_consumption"],
        baseClockSpeed: json["base_clock_speed"],
        length: json["length"],
        coolerType: json["cooler_type"],
        gpuInterface: json["interface"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "chipset": chipset,
        "memory": memory,
        "max_power_consumption": maxPowerConsumption,
        "base_clock_speed": baseClockSpeed,
        "length": length,
        "cooler_type": coolerType,
        "interface": gpuInterface,
      };

  Map<String, dynamic> toJson1() => {
        //"specification_id": specificationId,
        //"product_id": productId,
        "Chipset": chipset,
        "Memory": "${memory} GB",
        "Max Power Consumption": "${maxPowerConsumption} W",
        "Base Clock Speed": "${baseClockSpeed} MHz",
        "Length": "${length} mm",
        "Cooler Type": coolerType,
        "Interface": gpuInterface,
      };
  Map<String, dynamic> toJson2() =>
      {"gpuId": productId == "" ? null : productId};
}
