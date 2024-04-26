class Product {
  int? id;
  String? title;
  int? price;
  List<String>? images;
  String? description;
  String? thumbnail;
  double? rating;
  double? discountPercentage;
  int? stock;
  String?brand;

  Product({this.id, this.title, this.price, this.thumbnail, this.rating,
  this.images, this.description, this.discountPercentage, this.brand, this.stock});

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    price = json['price'];
    thumbnail = json['thumbnail'];
    rating = json['rating'];
    if (json['images'] != null) {
      if (json['images'] is List) {
        images = List<String>.from(json['images']);
      } else {
        images = [json['images'].toString()];
      }
    } else {
      images = [];
    }
    description = json['description'];
    discountPercentage = json['discountPercentage'];
    brand = json['brand'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['thumbnail'] = thumbnail;
    data['rating'] = rating;
    data['images'] = images;
    data['description'] = description;
    data['discountPercentage'] = discountPercentage;
    data['brand'] = brand;
    data['stock'] = stock;

    return data;
  }
}

