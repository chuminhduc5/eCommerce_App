import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/product/domain/repositories/product_repository.dart';

class GetProductByIdUseCase extends Usecase<ProductEntity, String> {
  final ProductRepository _productRepository;
  GetProductByIdUseCase(this._productRepository);
  @override
  Future<Either<Failure, ProductEntity>> call(String params) async {
    return await _productRepository.getProductById(params);
  }
}
