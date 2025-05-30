import 'package:ecommerce_app/feature/product/domain/entities/product_image_entity.dart';

class ProductImageModel {
  final int id;
  final String productId;
  final String imageUrl;

  ProductImageModel({
    required this.id,
    required this.productId,
    required this.imageUrl,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id'] as int,
      productId: json['productId'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'imageUrl': imageUrl,
    };
  }

  ProductImageEntity toEntity() {
    return ProductImageEntity(
      id: id,
      productId: productId,
      imageUrl: imageUrl,
    );
  }
}
