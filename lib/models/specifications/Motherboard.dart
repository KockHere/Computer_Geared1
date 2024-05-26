class Motherboard {
  String? specificationId;
  String? productId;
  String? cpuSocket;
  String? usbDetails;
  String? audio;
  int? memorySlots;
  String? sata;
  String? m2;
  String? powerConnectors;
  String? wifi;
  String? formFactor;
  String? gpuInterface;
  String? storageInterface;
  String? chipset;
  String? motherboardSupportRam;

  Motherboard({
    this.specificationId,
    this.productId,
    this.cpuSocket,
    this.usbDetails,
    this.audio,
    this.memorySlots,
    this.sata,
    this.m2,
    this.powerConnectors,
    this.wifi,
    this.formFactor,
    this.gpuInterface,
    this.storageInterface,
    this.chipset,
    this.motherboardSupportRam,
  });

  factory Motherboard.fromJson(Map<String, dynamic> json) => Motherboard(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        cpuSocket: json["cpu_socket"],
        usbDetails: json["usb_details"],
        audio: json["audio"],
        memorySlots: json["memory_slots"],
        sata: json["sata"],
        m2: json["m2"],
        powerConnectors: json["power_connectors"],
        wifi: json["wifi"],
        formFactor: json["form_factor"],
        gpuInterface: json["gpu_interface"],
        storageInterface: json["storage_interface"],
        chipset: json["chipset"],
        motherboardSupportRam: json["motherboard_support_ram"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "cpu_socket": cpuSocket,
        "usb_details": usbDetails,
        "audio": audio,
        "memory_slots": memorySlots,
        "sata": sata,
        "m2": m2,
        "power_connectors": powerConnectors,
        "wifi": wifi,
        "form_factor": formFactor,
        "gpu_interface": gpuInterface,
        "storage_interface": storageInterface,
        "chipset": chipset,
        "motherboard_support_ram": motherboardSupportRam,
      };

  Map<String, dynamic> toJson1() => {
        "CPU Socket": cpuSocket,
        "USB Details": usbDetails,
        "Audio": audio,
        "Memory Slots": memorySlots,
        "SATA": sata,
        "M2": m2,
        "Power Connectors": powerConnectors,
        "Wifi": wifi,
        "Form Factor": formFactor,
        "GPU Interface": gpuInterface,
        "Storage Interface": storageInterface,
        "Chipset": chipset,
        "Ram Support": motherboardSupportRam,
      };
  Map<String, dynamic> toJson2() =>
      {"motherboardId": productId == "" ? null : productId};
}
