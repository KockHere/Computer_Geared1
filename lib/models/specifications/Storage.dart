// ignore_for_file: file_names

class Storage {
  String? specificationId;
  String? productId;
  String? model;
  String? type;
  String? storageInterface;
  String? formFactor;
  int? capacity;
  int? voltage;

  Storage({
    this.specificationId,
    this.productId,
    this.model,
    this.type,
    this.storageInterface,
    this.formFactor,
    this.capacity,
    this.voltage,
  });

  factory Storage.fromJson(Map<String, dynamic> json) => Storage(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        model: json["model"],
        type: json["type"],
        storageInterface: json["interface"],
        formFactor: json["form_factor"],
        capacity: json["capacity"],
        voltage: json["voltage"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "model": model,
        "type": type,
        "interface": storageInterface,
        "form_factor": formFactor,
        "capacity": capacity,
        "voltage": voltage,
      };

  Map<String, dynamic> toJson1() => {
        "Model": model,
        "Type": type,
        "Interface": storageInterface,
        "Form Factor": formFactor,
        "Capacity": "${capacity} GB",
        "Voltage": "${voltage} W",
      };
  Map<String, dynamic> toJson2() =>
      {"storageId": productId == "" ? null : productId};
}
