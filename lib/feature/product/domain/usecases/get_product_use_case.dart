import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/feature/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/product/domain/repositories/product_repository.dart';

class GetProductUseCase extends Usecase<List<ProductEntity>, NoParams> {
  final ProductRepository _productRepository;
  GetProductUseCase(this._productRepository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await _productRepository.getProducts();
  }
}
