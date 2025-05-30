import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/utils/logger_utile.dart';
import 'package:ecommerce_app/feature/category/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_app/feature/category/domain/entities/category_entity.dart';
import 'package:ecommerce_app/feature/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;
  CategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await _remoteDataSource.fetchCategories();
      logger.i("Categories: $categories");
      return Right(categories.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
