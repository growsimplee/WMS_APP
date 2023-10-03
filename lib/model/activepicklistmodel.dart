class ActivePicklist {
  List<ActivePicklistResults>? results;
  int? pages;
  int? count;

  ActivePicklist({this.results, this.pages, this.count});

  ActivePicklist.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ActivePicklistResults>[];
      json['results'].forEach((v) {
        results!.add(new ActivePicklistResults.fromJson(v));
      });
    }
    pages = json['pages'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['pages'] = this.pages;
    data['count'] = this.count;
    return data;
  }

  void clear() {}
}

class ActivePicklistResults {
  int? id;
  int? skuCount;
  int? totalItems;
  String? picklistType;
  int? itemsAdded;
  String? createdAt;
  String? status;
  String? channel;
  int? warehouse;

  ActivePicklistResults(
      {this.id,
      this.skuCount,
      this.totalItems,
      this.picklistType,
      this.itemsAdded,
      this.createdAt,
      this.status,
      this.channel,
      this.warehouse});

  ActivePicklistResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuCount = json['sku_count'];
    totalItems = json['total_items'];
    picklistType = json['picklist_type'];
    itemsAdded = json['items_added'];
    createdAt = json['created_at'];
    status = json['status'];
    channel = json['channel'];
    warehouse = json['warehouse'];
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
    return data;
  }
}
