class Ram {
  String? specificationId;
  String? productId;
  int? memory;
  String? ramType;
  String? casLatency;
  String? dimmType;
  String? voltage;

  Ram({
    this.specificationId,
    this.productId,
    this.memory,
    this.ramType,
    this.casLatency,
    this.dimmType,
    this.voltage,
  });

  factory Ram.fromJson(Map<String, dynamic> json) => Ram(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        memory: json["memory"],
        ramType: json["ram_type"],
        casLatency: json["cas_latency"],
        dimmType: json["dimm_type"],
        voltage: json["voltage"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "memory": memory,
        "ram_type": ramType,
        "cas_latency": casLatency,
        "dimm_type": dimmType,
        "voltage": voltage,
      };

  Map<String, dynamic> toJson1() => {
        //"specification_id": specificationId,
        //"product_id": productId,
        "Memory": memory,
        "RAM Type": ramType,
        "CAS Latency": casLatency,
        "DIMM Type": dimmType,
        "Voltage": voltage,
      };
  Map<String, dynamic> toJson2() =>
      {"ramId": productId == "" ? null : productId};
}
