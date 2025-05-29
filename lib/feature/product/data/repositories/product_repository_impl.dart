import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/feature/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/feature/product/data/models/product_model.dart';
import 'package:ecommerce_app/feature/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;
  const ProductRepositoryImpl(this._productRemoteDataSource);

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      final product = await _productRemoteDataSource.getProductById(id);
      return Right(product.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await _productRemoteDataSource.getProducts();
      return Right(products.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
