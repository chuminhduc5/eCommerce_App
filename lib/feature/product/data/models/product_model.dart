import 'package:ecommerce_app/feature/product/domain/entities/product_entity.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrl;
  final int categoryId;
  final String categoryName;
  final DateTime? createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> imageList = json['product_images'] ?? [];

    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: imageList.map((e) => e['image_url'] as String).toList(),
      categoryId: json['category_id'] as int,
      categoryName: json['categories']?['name'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category_id': categoryId,
      'category_name': categoryName,
      'imageUrls': imageUrl,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      categoryId: categoryId,
      categoryName: categoryName,
      createdAt: createdAt,
    );
  }
}
