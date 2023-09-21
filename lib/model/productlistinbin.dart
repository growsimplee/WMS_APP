class ProductListInBin {
  int? productId;
  String? productSkuId;
  String? productName;
  int? total;
  int? pickedQty;
  int? nextProduct;
  bool? available;
  List<PickingOrder>? pickingOrder;
  List<Summary>? summary;

  ProductListInBin(
      {this.productId,
      this.productSkuId,
      this.productName,
      this.total,
      this.pickedQty,
      this.nextProduct,
      this.available,
      this.pickingOrder,
      this.summary});

  ProductListInBin.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productSkuId = json['product__sku_id'];
    productName = json['product__name'];
    total = json['total'];
    pickedQty = json['picked_qty'];
    nextProduct = json['next_product'];
    available = json['available'];
    if (json['picking_order'] != null) {
      pickingOrder = <PickingOrder>[];
      json['picking_order'].forEach((v) {
        pickingOrder!.add(new PickingOrder.fromJson(v));
      });
    }
    if (json['summary'] != null) {
      summary = <Summary>[];
      json['summary'].forEach((v) {
        summary!.add(new Summary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product__sku_id'] = this.productSkuId;
    data['product__name'] = this.productName;
    data['total'] = this.total;
    data['picked_qty'] = this.pickedQty;
    data['next_product'] = this.nextProduct;
    data['available'] = this.available;
    if (this.pickingOrder != null) {
      data['picking_order'] =
          this.pickingOrder!.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PickingOrder {
  String? binName;
  int? binId;
  int? pendingQty;
  int? pickedQty;

  PickingOrder({this.binName, this.binId, this.pendingQty, this.pickedQty});

  PickingOrder.fromJson(Map<String, dynamic> json) {
    binName = json['bin_name'];
    binId = json['bin_id'];
    pendingQty = json['pending_qty'];
    pickedQty = json['picked_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bin_name'] = this.binName;
    data['bin_id'] = this.binId;
    data['pending_qty'] = this.pendingQty;
    data['picked_qty'] = this.pickedQty;
    return data;
  }
}

class Summary {
  String? binName;
  int? binId;
  int? pendingQty;
  int? pickedQty;

  Summary({this.binName, this.binId, this.pendingQty, this.pickedQty});

  Summary.fromJson(Map<String, dynamic> json) {
    binName = json['bin_name'];
    binId = json['bin_id'];
    pendingQty = json['pending_qty'];
    pickedQty = json['picked_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bin_name'] = this.binName;
    data['bin_id'] = this.binId;
    data['pending_qty'] = this.pendingQty;
    data['picked_qty'] = this.pickedQty;
    return data;
  }
}
