class Itemlistmodel {
  int? id;
  int? skuCount;
  int? totalItems;
  String? picklistType;
  int? itemsAdded;
  String? createdAt;
  String? status;
  String? channel;
  int? warehouse;
  List<Pendency>? pendency;

  Itemlistmodel(
      {this.id,
      this.skuCount,
      this.totalItems,
      this.picklistType,
      this.itemsAdded,
      this.createdAt,
      this.status,
      this.channel,
      this.warehouse,
      this.pendency});

  Itemlistmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuCount = json['sku_count'];
    totalItems = json['total_items'];
    picklistType = json['picklist_type'];
    itemsAdded = json['items_added'];
    createdAt = json['created_at'];
    status = json['status'];
    channel = json['channel'];
    warehouse = json['warehouse'];
    if (json['pendency'] != null) {
      pendency = <Pendency>[];
      json['pendency'].forEach((v) {
        pendency!.add(new Pendency.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku_count'] = this.skuCount;
    data['total_items'] = this.totalItems;
    data['picklist_type'] = this.picklistType;
    data['items_added'] = this.itemsAdded;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['channel'] = this.channel;
    data['warehouse'] = this.warehouse;
    if (this.pendency != null) {
      data['pendency'] = this.pendency!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pendency {
  int? productId;
  String? productSkuId;
  String? productName;
  List<String>? productProductPics;
  int? total;
  int? pickedQty;
  bool? available;

  Pendency(
      {this.productId,
      this.productSkuId,
      this.productName,
      this.productProductPics,
      this.total,
      this.pickedQty,
      this.available});

  Pendency.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productSkuId = json['product__sku_id'];
    productName = json['product__name'];
    productProductPics = json['product__product_pics'].cast<String>();
    total = json['total'];
    pickedQty = json['picked_qty'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product__sku_id'] = this.productSkuId;
    data['product__name'] = this.productName;
    data['product__product_pics'] = this.productProductPics;
    data['total'] = this.total;
    data['picked_qty'] = this.pickedQty;
    data['available'] = this.available;
    return data;
  }
}
