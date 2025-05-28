import 'package:ecommerce_app/core/constansts/api_url.dart';
import 'package:ecommerce_app/core/service/dio_client.dart';
import 'package:ecommerce_app/feature/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient _dioClient;
  ProductRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dioClient.get(ApiUrl.products);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _dioClient.get('${ApiUrl.productsById}?id=eq.$id');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load product with id: $id');
      }
    } catch (e) {
      throw Exception('Error fetching product by id: $e');
    }
  }
}
