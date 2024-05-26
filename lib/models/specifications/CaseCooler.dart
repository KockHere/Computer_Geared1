class CaseCooler {
  String? specificationId;
  String? productId;
  String? model;
  int? airflow;
  int? fanRpm;
  int? size;
  int? voltage;

  CaseCooler({
    this.specificationId,
    this.productId,
    this.model,
    this.airflow,
    this.fanRpm,
    this.size,
    this.voltage,
  });

  factory CaseCooler.fromJson(Map<String, dynamic> json) => CaseCooler(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        model: json["model"],
        airflow: json["airflow"],
        fanRpm: json["fan_rpm"],
        size: json["size"],
        voltage: json["voltage"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "model": model,
        "airflow": airflow,
        "fan_rpm": fanRpm,
        "size": size,
        "voltage": voltage,
      };

  Map<String, dynamic> toJson1() => {
        //"specification_id": specificationId,
        //"product_id": productId,
        "Model": model,
        "Airflow": airflow,
        "Fan RPM": fanRpm,
        "Size": size,
        "Voltage": voltage,
      };
}
