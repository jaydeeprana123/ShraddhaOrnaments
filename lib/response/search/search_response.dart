class SearchResponse {
  String status;
  int statusCode;
  String message;
  Data data;

  SearchResponse({
      this.status, 
      this.statusCode, 
      this.message, 
      this.data});

  SearchResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
    message = json["message"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["status_code"] = statusCode;
    map["message"] = message;
    if (data != null) {
      map["data"] = data.toJson();
    }
    return map;
  }

}

class Data {
  int currentPage;
  List<ProductData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Data({
      this.currentPage, 
      this.data, 
      this.firstPageUrl, 
      this.from, 
      this.lastPage, 
      this.lastPageUrl, 
      this.nextPageUrl, 
      this.path, 
      this.perPage, 
      this.prevPageUrl, 
      this.to, 
      this.total});

  Data.fromJson(dynamic json) {
    currentPage = json["current_page"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(ProductData.fromJson(v));
      });
    }
    firstPageUrl = json["first_page_url"];
    from = json["from"];
    lastPage = json["last_page"];
    lastPageUrl = json["last_page_url"];
    nextPageUrl = json["next_page_url"];
    path = json["path"];
    perPage = json["per_page"];
    prevPageUrl = json["prev_page_url"];
    to = json["to"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = currentPage;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    map["first_page_url"] = firstPageUrl;
    map["from"] = from;
    map["last_page"] = lastPage;
    map["last_page_url"] = lastPageUrl;
    map["next_page_url"] = nextPageUrl;
    map["path"] = path;
    map["per_page"] = perPage;
    map["prev_page_url"] = prevPageUrl;
    map["to"] = to;
    map["total"] = total;
    return map;
  }

}

class ProductData {
  int id;
  String title;
  String description;
  String itemNo;
  String productCode;
  String price;
  String quantity;
  String sellingType;
  String size;
  String brand;
  String department;
  String width;
  String length;
  String colour;
  String material;
  String plating;
  String stoneType;
  String tna;
  String packing;
  String wishlist;
  String imageName;

  ProductData({
      this.id, 
      this.title, 
      this.description, 
      this.itemNo, 
      this.productCode, 
      this.price, 
      this.quantity, 
      this.sellingType, 
      this.size, 
      this.brand, 
      this.department, 
      this.width, 
      this.length, 
      this.colour, 
      this.material, 
      this.plating, 
      this.stoneType, 
      this.tna, 
      this.packing, 
      this.wishlist, 
      this.imageName});

  ProductData.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    itemNo = json["item_no"];
    productCode = json["product_code"];
    price = json["price"];
    quantity = json["quantity"];
    sellingType = json["selling_type"];
    size = json["size"];
    brand = json["brand"];
    department = json["department"];
    width = json["width"];
    length = json["length"];
    colour = json["colour"];
    material = json["material"];
    plating = json["plating"];
    stoneType = json["stone_type"];
    tna = json["tna"];
    packing = json["packing"];
    wishlist = json["wishlist"];
    imageName = json["image_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    map["item_no"] = itemNo;
    map["product_code"] = productCode;
    map["price"] = price;
    map["quantity"] = quantity;
    map["selling_type"] = sellingType;
    map["size"] = size;
    map["brand"] = brand;
    map["department"] = department;
    map["width"] = width;
    map["length"] = length;
    map["colour"] = colour;
    map["material"] = material;
    map["plating"] = plating;
    map["stone_type"] = stoneType;
    map["tna"] = tna;
    map["packing"] = packing;
    map["wishlist"] = wishlist;
    map["image_name"] = imageName;
    return map;
  }

}