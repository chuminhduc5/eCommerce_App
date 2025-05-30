import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/category/domain/entities/category_entity.dart';
import 'package:ecommerce_app/feature/category/domain/usecases/get_category_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryViewModel extends StateNotifier<AsyncValue<List<CategoryEntity>>> {
  final GetCategoryUseCase _getCategoryUseCase;
  CategoryViewModel(this._getCategoryUseCase) : super(const AsyncValue.loading());

  Future<void> fetchCategory() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _getCategoryUseCase.call(NoParams());
      categories.fold(
            (failure) => state = AsyncValue.error(failure, StackTrace.current),
            (categories) => state = AsyncValue.data(categories),
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}