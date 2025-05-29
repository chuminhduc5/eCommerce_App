import 'package:equatable/equatable.dart';

class ProductImageEntity extends Equatable {
  final int id;
  final String productId;
  final String imageUrl;

  const ProductImageEntity({
    required this.id,
    required this.productId,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, productId, imageUrl];
}
