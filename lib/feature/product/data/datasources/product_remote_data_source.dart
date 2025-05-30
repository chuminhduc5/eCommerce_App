import 'package:ecommerce_app/core/constansts/api_url.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/service/dio_client.dart';
import 'package:ecommerce_app/core/utils/logger_utile.dart';
import 'package:ecommerce_app/feature/product/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final SupabaseClient _supabaseClient;
  ProductRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _supabaseClient
          .from('products')
          .select('*, categories(name), product_images(image_url)');
      if (response is List) {
        if (response.isEmpty) {
          return [];
        }
        return response.map((e) {
          return ProductModel.fromJson(e);
        }).toList();
      } else {
        logger.e("Unexpected response type: ${response.runtimeType}");
        throw ServerException();
      }
    } catch (e) {
      logger.e("Error fetching products: $e");
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _supabaseClient
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
