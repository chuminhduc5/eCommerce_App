import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app/feature/product/domain/usecases/get_product_use_case.dart';
import 'package:ecommerce_app/feature/product/presentation/providers/product_provider.dart';
import 'package:ecommerce_app/feature/product/presentation/viewmodels/product_view_model_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';

class ProductViewModel extends AsyncNotifier<ProductViewModelState> {
  @override
  Future<ProductViewModelState> build() async {
    // Tự động gọi fetchProducts khi khởi tạo
    final state = ProductViewModelState(products: const AsyncValue.loading());
    await fetchProducts();
    return state;
  }

  Future<void> fetchProducts() async {
    state = AsyncValue.data(
        state.value!.copyWith(products: const AsyncValue.loading()));
    try {
      final useCase = ref.read(getProductUseCaseProvider);
      final result = await useCase(NoParams());
      state = AsyncValue.data(state.value!.copyWith(
        products: result.fold(
          (failure) => AsyncValue.error(failure, StackTrace.current),
          (products) => AsyncValue.data(products),
        ),
      ));
    } catch (e, stackTrace) {
      state = AsyncValue.data(
          state.value!.copyWith(products: AsyncValue.error(e, stackTrace)));
    }
  }

  Future<void> fetchProductById(int id) async {
    state = AsyncValue.data(
        state.value!.copyWith(selectedProduct: const AsyncValue.loading()));
    try {
      final useCase = ref.read(getProductByIdUseCaseProvider);
      final result = await useCase(id);
      state = AsyncValue.data(state.value!.copyWith(
        selectedProduct: result.fold(
          (failure) => AsyncValue.error(failure, StackTrace.current),
          (product) => AsyncValue.data(product),
        ),
      ));
    } catch (e, stackTrace) {
      state = AsyncValue.data(state.value!
          .copyWith(selectedProduct: AsyncValue.error(e, stackTrace)));
    }
  }
}
