class ProductListResponse {
  String status;
  int statusCode;
 // List<String> message;
  List<ProductData> data;

  ProductListResponse({
      this.status, 
      this.statusCode, 
    //  this.message,
      this.data});

  ProductListResponse.fromJson(dynamic json) {
    status = json["status"];
    statusCode = json["status_code"];
   // message = json["message"] != null ? json["message"].cast<String>() : [];//message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["status_code"] = statusCode;
   // map["message"] = message;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
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

 // bool isWishlist=false;


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