// ignore_for_file: file_names

class Motherboard {
  String? primaryProductId;
  String? name;
  dynamic description;
  int? unitPrice;
  String? price;
  int? discount;
  int? sold;
  String? categoryName;
  String? productBrandId;
  String? brandName;
  List<String>? imageLinks;
  String? specificationId;
  String? productId;
  String? productSpecificationType;
  String? chipset;
  String? spuSocket;
  String? usbDetails;
  String? audio;
  String? ethernetController;
  String? wifiAntenna;
  String? memorySlots;
  String? memorySupports;
  String? maximumCapacity;
  String? channelArchitecture;
  String? sata;
  String? m2;
  String? raidSupport;
  String? expansionSlots;
  String? airCooling;
  String? powerConnectors;
  String? audioInternal;
  String? rom;
  String? audioCodec;
  double? bluetooth;
  String? wifi;
  int? formFactor;
  String? brand;

  Motherboard({
    this.primaryProductId,
    this.name,
    this.description,
    this.unitPrice,
    this.price,
    this.discount,
    this.sold,
    this.categoryName,
    this.productBrandId,
    this.brandName,
    this.imageLinks,
    this.specificationId,
    this.productId,
    this.productSpecificationType,
    this.chipset,
    this.spuSocket,
    this.usbDetails,
    this.audio,
    this.ethernetController,
    this.wifiAntenna,
    this.memorySlots,
    this.memorySupports,
    this.maximumCapacity,
    this.channelArchitecture,
    this.sata,
    this.m2,
    this.raidSupport,
    this.expansionSlots,
    this.airCooling,
    this.powerConnectors,
    this.audioInternal,
    this.rom,
    this.audioCodec,
    this.bluetooth,
    this.wifi,
    this.formFactor,
    this.brand,
  });

  factory Motherboard.fromJson(Map<String, dynamic> json) => Motherboard(
        primaryProductId: json["primary_product_id"],
        name: json["name"],
        description: json["description"],
        unitPrice: int.parse(json["unit_price"].toString().replaceAll(",", "")),
        price: json["price"],
        discount: json["discount"] == null
            ? 0
            : int.parse(json["discount"]
                .toString()
                .replaceAll(",", "")
                .replaceAll(".", "")),
        sold: json["sold"],
        categoryName: json["category_name"],
        productBrandId: json["product_brand_id"] ?? "",
        brandName: json["brand_name"],
        imageLinks: json["image_links"] == null ||
                json["image_links"].isEmpty ||
                json["image_links"][0] == null
            ? []
            : List<String>.from(json["image_links"]!.map((x) => x)),
        specificationId: json["specification_id"],
        productId: json["product_id"],
        productSpecificationType: json["product_specification_type"],
        chipset: json["chipset"],
        spuSocket: json["spu_socket"],
        usbDetails: json["usb_details"],
        audio: json["audio"],
        ethernetController: json["ethernet_controller"],
        wifiAntenna: json["wifi_antenna"],
        memorySlots: json["memory_slots"],
        memorySupports: json["memory_supports"],
        maximumCapacity: json["maximum_capacity"],
        channelArchitecture: json["channel_architecture"],
        sata: json["sata"],
        m2: json["m2"],
        raidSupport: json["raid_support"],
        expansionSlots: json["expansion_slots"],
        airCooling: json["air_cooling"],
        powerConnectors: json["power_connectors"],
        audioInternal: json["audio_internal"],
        rom: json["rom"],
        audioCodec: json["audio_codec"],
        bluetooth: json["bluetooth"] == null
            ? 0
            : double.parse(json["bluetooth"]
                .toString()
                .replaceAll(",", "")
                .replaceAll(".", "")),
        wifi: json["wifi"],
        formFactor: json["form_factor"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "primary_product_id": primaryProductId,
        "motherboard_id": productId,
        "name": name,
        "description": description,
        "unit_price": unitPrice,
        "price": price,
        "discount": discount,
        "sold": sold,
        "category_name": categoryName,
        "product_brand_id": productBrandId,
        "brand_name": brandName,
        "image_links": imageLinks == null
            ? []
            : List<dynamic>.from(imageLinks!.map((x) => x)),
        "specification_id": specificationId,
        "product_id": productId,
        "product_specification_type": productSpecificationType,
        "chipset": chipset,
        "spu_socket": spuSocket,
        "usb_details": usbDetails,
        "audio": audio,
        "ethernet_controller": ethernetController,
        "wifi_antenna": wifiAntenna,
        "memory_slots": memorySlots,
        "memory_supports": memorySupports,
        "maximum_capacity": maximumCapacity,
        "channel_architecture": channelArchitecture,
        "sata": sata,
        "m2": m2,
        "raid_support": raidSupport,
        "expansion_slots": expansionSlots,
        "air_cooling": airCooling,
        "power_connectors": powerConnectors,
        "audio_internal": audioInternal,
        "rom": rom,
        "audio_codec": audioCodec,
        "bluetooth": bluetooth,
        "wifi": wifi,
        "form_factor": formFactor,
        "brand": brand,
      };

  Map<String, dynamic> toJson1() => {
        //"Product Specification Type": productSpecificationType,
        "Brand": brand,
        "Chipset": chipset,
        "CPU Socket": spuSocket,
        "USB Details": usbDetails,
        "Audio": audio,
        "Ethernet Controller": ethernetController,
        "WiFi Antenna": wifiAntenna,
        "Memory Slots": memorySlots,
        "Memory Supports": memorySupports,
        "Channel Architecture": channelArchitecture,
        "SATA": sata,
        "M.2": m2,
        "RAID Support": raidSupport,
        "Expansion Slots": expansionSlots,
        "Air Cooling": airCooling,
        "Power Connectors": powerConnectors,
        "Audio Internal": audioInternal,
        "ROM": rom,
        "Audio Codec": audioCodec,
        "Bluetooth": bluetooth,
        "WiFi": wifi,
        "Form Factor": formFactor,
      };
}
