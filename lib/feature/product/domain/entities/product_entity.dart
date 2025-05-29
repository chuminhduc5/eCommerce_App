import 'package:ecommerce_app/feature/product/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrl;
  final int categoryId;
  final String categoryName;
  final DateTime? createdAt;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        categoryId,
        categoryName,
        createdAt,
      ];
}
