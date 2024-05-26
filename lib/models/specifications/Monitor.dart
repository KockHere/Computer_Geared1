class Monitor {
  String? specificationId;
  String? productId;
  String? model;
  int? screenSize;
  String? resolution;
  int? responseTime;
  String? aspectRatio;
  int? refreshRate;
  String? panelType;
  int? voltage;

  Monitor({
    this.specificationId,
    this.productId,
    this.model,
    this.screenSize,
    this.resolution,
    this.responseTime,
    this.aspectRatio,
    this.refreshRate,
    this.panelType,
    this.voltage,
  });

  factory Monitor.fromJson(Map<String, dynamic> json) => Monitor(
        specificationId: json["specification_id"],
        productId: json["product_id"],
        model: json["model"],
        screenSize: json["screen_size"],
        resolution: json["resolution"],
        responseTime: json["response_time"],
        aspectRatio: json["aspect_ratio"],
        refreshRate: json["refresh_rate"],
        panelType: json["panel_type"],
        voltage: json["voltage"],
      );

  Map<String, dynamic> toJson() => {
        "specification_id": specificationId,
        "product_id": productId,
        "model": model,
        "screen_size": screenSize,
        "resolution": resolution,
        "response_time": responseTime,
        "aspect_ratio": aspectRatio,
        "refresh_rate": refreshRate,
        "panel_type": panelType,
        "voltage": voltage,
      };

  Map<String, dynamic> toJson1() => {
        //"specification_id": specificationId,
        //"product_id": productId,
        "Model": model,
        "Screen Size": screenSize,
        "Resolution": resolution,
        "Response Time": responseTime,
        "Aspect Ratio": aspectRatio,
        "Refresh Rate": refreshRate,
        "Panel Type": panelType,
        "Voltage": voltage,
      };
}
