import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/category/domain/entities/category_entity.dart';
import 'package:ecommerce_app/feature/category/domain/repositories/category_repository.dart';

class GetCategoryUseCase extends Usecase<List<CategoryEntity>, NoParams> {
  final CategoryRepository _categoryRepository;
  GetCategoryUseCase(this._categoryRepository);
  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await _categoryRepository.getCategories();
  }
}
