import 'package:ecommerce_app/feature/product/domain/entities/product_image_entity.dart';

class ProducImageModel {
  final int id;
  final String productId;
  final String imageUrl;

  ProducImageModel({
    required this.id,
    required this.productId,
    required this.imageUrl,
  });

  factory ProducImageModel.fromJson(Map<String, dynamic> json) {
    return ProducImageModel(
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
