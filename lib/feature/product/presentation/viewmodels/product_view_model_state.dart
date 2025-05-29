import 'package:ecommerce_app/feature/product/domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductViewModelState {
  final AsyncValue<List<ProductEntity>> products;
  final AsyncValue<ProductEntity?> selectedProduct;

  ProductViewModelState({
    required this.products,
    this.selectedProduct = const AsyncValue.data(null),
  });

  ProductViewModelState copyWith({
    AsyncValue<List<ProductEntity>>? products,
    AsyncValue<ProductEntity?>? selectedProduct,
  }) {
    return ProductViewModelState(
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }
}
