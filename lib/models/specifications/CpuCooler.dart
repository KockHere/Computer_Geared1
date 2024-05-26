class CpuCooler {
  String? specificationId;
  String? productId;
  String? model;
  String? cpuCooler;
  int? fanRpm;
  String? noiseLevel;
  int? fanNumber;
  int? cpuCoolerSize;
  int? fanCfm;
  int? voltage;

  CpuCooler({
    this.specificationId,
    this.productId,
    this.model,
    this.cpuCooler,
    this.fanRpm,
    this.noiseLevel,
    this.fanNumber,
    this.cpuCoolerSize,
    this.fanCfm,
    this.voltage,
  });

  factory CpuCooler.fromJson(Map<String, dynamic> json) => CpuCooler(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        model: json["model"],
        cpuCooler: json["cpu_cooler"],
        fanRpm: json["fan_rpm"],
        noiseLevel: json["noise_level"],
        fanNumber: json["fan_number"],
        cpuCoolerSize: json["cpu_cooler_size"],
        fanCfm: json["fan_cfm"],
        voltage: json["voltage"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "model": model,
        "cpu_cooler": cpuCooler,
        "fan_rpm": fanRpm,
        "noise_level": noiseLevel,
        "fan_number": fanNumber,
        "cpu_cooler_size": cpuCoolerSize,
        "fan_cfm": fanCfm,
        "voltage": voltage,
      };

  Map<String, dynamic> toJson1() => {
        "Model": model,
        "CPU Cooler": cpuCooler,
        "Fan RPM": fanRpm,
        "Noise Level": noiseLevel,
        "Fan Number": fanNumber,
        "CPU Cooler Size": cpuCoolerSize,
        "Fan CFM": fanCfm,
        "Voltage": voltage,
      };
}
