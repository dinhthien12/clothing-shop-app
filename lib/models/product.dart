class ProductVariant {
  final String color;
  final String image;

  ProductVariant({required this.color, required this.image});

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      color: json['color'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  final List<ProductVariant>? variants;

  // Các thuộc tính đang bị báo lỗi thiếu:
  final List<String> colors;
  final String categoryId;
  final String gender;
  final String sport;
  final double rating;
  final int soldCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    this.variants,
    this.colors = const [],
    this.categoryId = '',
    this.gender = '',
    this.sport = '',
    this.rating = 0.0,
    this.soldCount = 0,
  });

  // Getter để xử lý lỗi 'formattedPrice'
  String get formattedPrice => "${price.toStringAsFixed(0)}đ";

  factory Product.fromJson(Map<String, dynamic> json) {
    var variantList = json['variants'] as List?;
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      variants: variantList?.map((v) => ProductVariant.fromJson(v)).toList(),
      colors: List<String>.from(json['colors'] ?? []),
      categoryId: json['categoryId'] ?? '',
      gender: json['gender'] ?? '',
      sport: json['sport'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      soldCount: json['soldCount'] ?? 0,
    );
  }
}