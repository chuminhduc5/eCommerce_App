import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/core/utils/logger_utile.dart';
import 'package:ecommerce_app/feature/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app/feature/product/domain/usecases/get_product_use_case.dart';
import 'package:ecommerce_app/feature/product/presentation/providers/product_provider.dart';
import 'package:ecommerce_app/feature/product/presentation/viewmodels/product_view_model_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';

// class ProductViewModel extends AsyncNotifier<ProductViewModelState> {
//   @override
//   Future<ProductViewModelState> build() async {
//     // Tự động gọi fetchProducts khi khởi tạo
//     logger.i("Building ProductViewModel");
//     final state = ProductViewModelState(products: const AsyncValue.loading());
//     await fetchProducts();
//     return state;
//   }
//
//   Future<void> fetchProducts() async {
//     state = AsyncValue.data(
//         state.value!.copyWith(products: const AsyncValue.loading()));
//     try {
//       final useCase = ref.read(getProductUseCaseProvider);
//       final result = await useCase(NoParams());
//       state = AsyncValue.data(state.value!.copyWith(
//         products: result.fold(
//           (failure) => AsyncValue.error(failure, StackTrace.current),
//           (products) => AsyncValue.data(products),
//         ),
//       ));
//     } catch (e, stackTrace) {
//       state = AsyncValue.data(
//           state.value!.copyWith(products: AsyncValue.error(e, stackTrace)));
//     }
//   }
//
//   Future<void> fetchProductById(int id) async {
//     state = AsyncValue.data(
//         state.value!.copyWith(selectedProduct: const AsyncValue.loading()));
//     try {
//       final useCase = ref.read(getProductByIdUseCaseProvider);
//       final result = await useCase(id);
//       state = AsyncValue.data(state.value!.copyWith(
//         selectedProduct: result.fold(
//           (failure) => AsyncValue.error(failure, StackTrace.current),
//           (product) => AsyncValue.data(product),
//         ),
//       ));
//     } catch (e, stackTrace) {
//       state = AsyncValue.data(state.value!
//           .copyWith(selectedProduct: AsyncValue.error(e, stackTrace)));
//     }
//   }
// }

class ProductViewModel extends AsyncNotifier<ProductViewModelState> {
  @override
  Future<ProductViewModelState> build() async {
    logger.i("Building ProductViewModel");
    //final state = ProductViewModelState(products: const AsyncValue.loading());
    state = AsyncValue.data(
      ProductViewModelState(products: const AsyncValue.loading()),
    );
    await fetchProducts();
    return state.value!;
  }

  Future<void> fetchProducts() async {
    logger.i("Starting fetchProducts");
    state = AsyncValue.data(
      state.value?.copyWith(products: const AsyncValue.loading()) ??
          ProductViewModelState(
              products: const AsyncValue.loading(),
              selectedProduct: const AsyncValue.data(null)),
    );
    try {
      final useCase = ref.read(getProductUseCaseProvider);
      logger.i("Calling GetProductUseCase");
      final result = await useCase(NoParams()); // Sử dụng EmptyParams
      logger.i("Result: $result");
      state = AsyncValue.data(state.value!.copyWith(
        products: result.fold(
              (failure) {
            logger.e("Failure: $failure");
            return AsyncValue.error(failure, StackTrace.current);
          },
              (products) {
            logger.i("Products fetched: ${products.length}");
            return AsyncValue.data(products);
          },
        ),
      ));
    } catch (e, stackTrace) {
      logger.e("Error in fetchProducts: $e");
      state = AsyncValue.data(
        state.value!.copyWith(products: AsyncValue.error(e, stackTrace)),
      );
    }
  }

  Future<void> fetchProductById(String id) async {
    logger.i("Starting fetchProductById: $id");
    state = AsyncValue.data(
      state.value?.copyWith(selectedProduct: const AsyncValue.loading()) ??
          ProductViewModelState(
              products: const AsyncValue.data([]),
              selectedProduct: const AsyncValue.loading()),
    );
    try {
      final useCase = ref.read(getProductByIdUseCaseProvider);
      logger.i("Calling GetProductByIdUseCase");
      final result = await useCase(id); // Đổi sang String
      logger.i("Result: $result");
      state = AsyncValue.data(state.value!.copyWith(
        selectedProduct: result.fold(
              (failure) {
            logger.e("Failure: $failure");
            return AsyncValue.error(failure, StackTrace.current);
          },
              (product) {
            logger.i("Product fetched: ${product.name}");
            return AsyncValue.data(product);
          },
        ),
      ));
    } catch (e, stackTrace) {
      logger.e("Error in fetchProductById: $e");
      state = AsyncValue.data(
        state.value!.copyWith(selectedProduct: AsyncValue.error(e, stackTrace)),
      );
    }
  }
}