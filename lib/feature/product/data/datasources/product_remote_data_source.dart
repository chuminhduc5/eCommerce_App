import 'package:ecommerce_app/core/constansts/api_url.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/service/dio_client.dart';
import 'package:ecommerce_app/core/utils/logger_utile.dart';
import 'package:ecommerce_app/feature/product/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl();

  final supabase = Supabase.instance.client;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      // final response = await supabase
      //     .from('products')
      //     .select('*, categories(name), product_images(image_url)');
      final response = await supabase
          .from('products')
          .select('*, categories(name), product_images(image_url)');

      if (response is List) {
        return response.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw ServerException();
      }
      logger.i("Raw response: ${response.runtimeType} - $response");
      return response.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      logger.e("Lỗi khi lấy products: $e");
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await supabase
          .from('products')
          .select('*, categories(name), product_images(image_url)')
          .eq('id', id)
          .single();

      return ProductModel.fromJson(response);
    } catch (e) {
      throw ServerException();
    }
  }
}
