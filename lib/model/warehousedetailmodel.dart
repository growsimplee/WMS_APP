class WarehouseDetail {
  List<Response>? response;
  String? error;

  WarehouseDetail({this.response, this.error});

  WarehouseDetail.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Response {
  int? warehouseIntId;
  String? warehouseId;
  String? warehouseName;

  Response({this.warehouseIntId, this.warehouseId, this.warehouseName});

  Response.fromJson(Map<String, dynamic> json) {
    warehouseIntId = json['warehouse_int_id'];
    warehouseId = json['warehouse_id'];
    warehouseName = json['warehouse_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouse_int_id'] = this.warehouseIntId;
    data['warehouse_id'] = this.warehouseId;
    data['warehouse_name'] = this.warehouseName;
    return data;
  }
}
